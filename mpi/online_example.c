#include <mpi.h>
#include <stdio.h>
#include <unistd.h>
#include "/users/doupleop/spack/opt/spack/linux-centos7-haswell/gcc-4.8.5/scr-2.0.0-cue4xoblysuh5pailuwj57g5fu7jvuns/include/scr.h"

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

int main(int argc, char* argv[]) {
  MPI_Init(&argc, &argv);

  /* Call SCR_Init after MPI_Init */
  SCR_Init();
  int state;
  for(int t = 0; t < TIMESTEPS; t++)
  {
    /* ... Do work ... */
    state = t;
    int flag;
    /* Ask SCR if we should take a checkpoint now */
    SCR_Need_checkpoint(&flag);
    if (flag)
      checkpoint(state);
  }

  /* Call SCR_Finalize before MPI_Finalize */
  SCR_Finalize();
  MPI_Finalize();
  return 0;
}

