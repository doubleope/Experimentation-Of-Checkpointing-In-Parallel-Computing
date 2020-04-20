MPICC     ?= mpicc
MPICXX    ?= mpicxx
MPIF90    ?= mpif90
OPT       ?= -g -O3
LIBDIR     = -L/users/doupleop/spack/opt/spack/linux-centos7-haswell/gcc-4.8.5/scr-2.0.0-cue4xoblysuh5pailuwj57g5fu7jvuns/lib64 -Wl,-rpath,/users/doupleop/spack/opt/spack/linux-centos7-haswell/gcc-4.8.5/scr-2.0.0-cue4xoblysuh5pailuwj57g5fu7jvuns/lib64 -lscr 
INCLUDES   = -I/users/doupleop/spack/opt/spack/linux-centos7-haswell/gcc-4.8.5/scr-2.0.0-cue4xoblysuh5pailuwj57g5fu7jvuns/include -I/usr/include -I.

all: test_api ping_pong original_ping_pong mpi_prog test_ckpt

clean:
	rm -rf *.o test_api ping_pong original_ping_pong mpi_prog test_ckpt

test_api: test_common.o test_common.h test_api.c
	$(MPICC) $(OPT) $(CFLAGS) $(INCLUDES) -o test_api test_common.o test_api.c \
	  $(LDFLAGS) $(LIBDIR)
ping_pong:
	$(MPICC) $(OPT) $(CFLAGS) $(INCLUDES) -o ping_pong ping_pong.c -std=c99 $(LDFLAGS) $(LIBDIR)
original_ping_pong:
	$(MPICC) $(OPT) $(CFLAGS) $(INCLUDES) -o original_ping_pong original_ping_pong.c -std=c99 $(LDFLAGS) $(LIBDIR)
mpi_prog:
	$(MPICC) $(OPT) $(CFLAGS) $(INCLUDES) -o mpi_prog mpi_prog.c -std=c99 $(LDFLAGS) $(LIBDIR)
test_ckpt:
	$(MPICC) $(OPT) $(CFLAGS) $(INCLUDES) -o mpi_prog mpi_prog.c -std=c99 $(LDFLAGS) $(LIBDIR)
