// Author: Wes Kendall
// Copyright 2011 www.mpitutorial.com
// This code is provided freely with the tutorials on mpitutorial.com. Feel
// free to modify it for your own use. Any distribution of the code must
// either provide a link to www.mpitutorial.com or keep this header intact.
//
// Ping pong example with MPI_Send and MPI_Recv. Two processes ping pong a
// number back and forth, incrementing it until it reaches a given value.
//
#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include "scr.h"

int TIMESTEPS =100;

void checkpoint(state) {
  /* Tell SCR that you are getting ready to start a checkpoint phase */
  SCR_Start_checkpoint();

  int rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);

  char file[256];
  /* create your checkpoint file name */
  sprintf(file, "rank_%d.ckpt", rank);

  /* Call SCR_Route_file to request a new file name (scr_file) that will cause
     your application to write the file to a fast tier of storage, e.g.,
     a burst buffer */
  char scr_file[SCR_MAX_FILENAME];
  SCR_Route_file(file, scr_file);

  /* Use the new file name to perform your checkpoint I/O */
  FILE* fs = fopen(scr_file, "w");
  if (fs != NULL) {
    fwrite(state, 1, sizeof(state), fs);
    fclose(fs);
  }

  /* Tell SCR that you are done with your checkpoint phase */
  SCR_Complete_checkpoint(1);
  return;
}

int main(int argc, char** argv) {
  const int PING_PONG_LIMIT = 10;

  // Initialize the MPI environment
  MPI_Init(NULL, NULL);
  SCR_Init();
  int state;
   for(int t = 0; t < TIMESTEPS; t++)
  {
    /* ... Do work ... */
     int world_rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);
  int world_size;
  MPI_Comm_size(MPI_COMM_WORLD, &world_size);

  // We are assuming at least 2 processes for this task
  if (world_size != 2) {
    fprintf(stderr, "World size must be two for %s\n", argv[0]);
    MPI_Abort(MPI_COMM_WORLD, 1);
  }

  int ping_pong_count = 0;
  int partner_rank = (world_rank + 1) % 2;
  while (ping_pong_count < PING_PONG_LIMIT) {
    if (world_rank == ping_pong_count % 2) {
      // Increment the ping pong count before you send it
      ping_pong_count++;
      MPI_Send(&ping_pong_count, 1, MPI_INT, partner_rank, 0, MPI_COMM_WORLD);
      printf("%d sent and incremented ping_pong_count %d to %d\n",
             world_rank, ping_pong_count, partner_rank);
    } else {
      MPI_Recv(&ping_pong_count, 1, MPI_INT, partner_rank, 0, MPI_COMM_WORLD,
               MPI_STATUS_IGNORE);
      printf("%d received ping_pong_count %d from %d\n",
             world_rank, ping_pong_count, partner_rank);
    }
  }
    char state[] = "a state";
    int flag;
    /* Ask SCR if we should take a checkpoint now */
    SCR_Need_checkpoint(&flag);
    if (flag)
      checkpoint(state);
  }
  // Find out rank, size
  SCR_Finalize();
  MPI_Finalize();
}
