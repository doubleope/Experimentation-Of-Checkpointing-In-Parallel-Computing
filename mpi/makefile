MPICC     ?= mpicc
MPICXX    ?= mpicxx
MPIF90    ?= mpif90
OPT       ?= -g -O3
LIBDIR     = -L/users/doupleop/spack/opt/spack/linux-centos7-haswell/gcc-4.8.5/scr-2.0.0-cue4xoblysuh5pailuwj57g5fu7jvuns/lib64 -Wl,-rpath,/users/doupleop/spack/opt/spack/linux-centos7-haswell/gcc-4.8.5/scr-2.0.0-cue4xoblysuh5pailuwj57g5fu7jvuns/lib64 -lscr 
INCLUDES   = -I/users/doupleop/spack/opt/spack/linux-centos7-haswell/gcc-4.8.5/scr-2.0.0-cue4xoblysuh5pailuwj57g5fu7jvuns/include -I/usr/include -I.

all: test_api test_api_multiple test_interpose test_interpose_multiple test_ckpt_C test_ckpt_F online_example ping_pong original_ping_pong

clean:
	rm -rf *.o test_api test_api_multiple test_interpose test_interpose_multiple test_ckpt_C

test_api: test_common.o test_common.h test_api.c
	$(MPICC) $(OPT) $(CFLAGS) $(INCLUDES) -o test_api test_common.o test_api.c \
	  $(LDFLAGS) $(LIBDIR)

test_api_multiple: test_common.o test_common.h test_api_multiple.c
	$(MPICC) $(OPT) $(CFLAGS) $(INCLUDES) -o test_api_multiple test_common.o test_api_multiple.c \
	  $(LDFLAGS) $(LIBDIR)

test_interpose: test_interpose.c
	$(MPICC) $(OPT) $(CFLAGS) -o test_interpose test_interpose.c $(LDFLAGS)

test_interpose_multiple: test_common.o test_common.h test_interpose_multiple.c
	$(MPICC) $(OPT) $(CFLAGS) -o test_interpose_multiple test_common.o test_interpose_multiple.c $(LDFLAGS)

test_common.o: test_common.c test_common.h
	$(MPICC) $(OPT) $(CFLAGS) $(INCLUDES) -c -o test_common.o test_common.c

test_ckpt_C: test_ckpt.C
	$(MPICXX) $(OPT) $(CXXFLAGS) $(INCLUDES) -o test_ckpt_C test_ckpt.C \
	  $(LDFLAGS) $(LIBDIR)

test_ckpt_F: test_ckpt.F
	$(MPIF90) $(OPT) $(F90FLAGS) $(INCLUDES) -o test_ckpt_F test_ckpt.F \
	  $(LDFLAGS) -lscrf $(LIBDIR)
online_example:
	$(MPICC) $(OPT) $(CFLAGS) $(INCLUDES) -o online_example online_example.c -std=c99 $(LDFLAGS) $(LIBDIR)
ping_pong:
	$(MPICC) $(OPT) $(CFLAGS) $(INCLUDES) -o ping_pong ping_pong.c -std=c99 $(LDFLA GS) $(LIBDIR)
original_ping_pong:
	$(MPICC) $(OPT) $(CFLAGS) $(INCLUDES) -o original_ping_pong original_ping_pong.c -std=c99 $(LDFLA GS) $(LIBDIR)
