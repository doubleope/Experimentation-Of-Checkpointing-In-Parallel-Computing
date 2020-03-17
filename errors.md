## Current error while building an scr example
<pre>
mpicc -g -O3  -I/users/doupleop/spack/opt/spack/linux-centos7-x86_64/gcc-4.
8.5/scr-2.0.0-q4bu7rwlres7cpk3bpzt4vyrcua3mwix/include -I/usr/include -I. -
c -o test_common.o test_common.c                                           
mpicc -g -O3  -I/users/doupleop/spack/opt/spack/linux-centos7-x86_64/gcc-4.
8.5/scr-2.0.0-q4bu7rwlres7cpk3bpzt4vyrcua3mwix/include -I/usr/include -I. -
o test_api test_common.o test_api.c \                                      
   -L/users/doupleop/spack/opt/spack/linux-centos7-x86_64/gcc-4.8.5/scr-2.0
.0-q4bu7rwlres7cpk3bpzt4vyrcua3mwix/lib64 -Wl,-rpath,/users/doupleop/spack/
opt/spack/linux-centos7-x86_64/gcc-4.8.5/scr-2.0.0-q4bu7rwlres7cpk3bpzt4vyr
cua3mwix/lib64 -lscr                                                       
/usr/bin/ld: skipping incompatible /users/doupleop/spack/opt/spack/linux-ce
ntos7-x86_64/gcc-4.8.5/scr-2.0.0-q4bu7rwlres7cpk3bpzt4vyrcua3mwix/lib64/lib
scr.so when searching for -lscr                                            
/usr/bin/ld: skipping incompatible /users/doupleop/spack/opt/spack/linux-ce
ntos7-x86_64/gcc-4.8.5/scr-2.0.0-q4bu7rwlres7cpk3bpzt4vyrcua3mwix/lib64/lib
scr.a when searching for -lscr                                             
/usr/bin/ld: cannot find -lscr                                             
collect2: error: ld returned 1 exit status                                 
make: *** [test_api] Error 1 
</pre>
