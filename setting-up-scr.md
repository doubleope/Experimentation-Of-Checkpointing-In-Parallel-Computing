## Note: This is not working yet, this is for documentation purposes only for now. Will update when everything works

## Install spack:

<pre>git clone https://github.com/spack/spack.git
cd spack/bin
./spack install zlib
</pre>

## Install compilers:

<pre>sudo yum install gcc-gfortran</pre>

Then locate compilers.yaml file at:
<pre> /users/your_username/.spack/linux </pre>

Modify the file and make changes to 'f77' and 'fc' fields like so:
<pre>
f77: /usr/bin/gfortran
fc: /usr/bin/gfortran
</pre>

## Install scr (make sure you're in the spack/bin directory):

<pre>./spack install scr</pre>

## Building the SCR test_api example

#### Do the following:
<pre>
sudo yum install openmpi-devel.i686
export PATH=/usr/lib/openmpi/bin:$PATH
sudo yum -y install glibc-devel.i686 glibc-devel
</pre>

#### Find the directory where SCR was installed:
<pre>./spack find --paths</pre>


## Tasks:
1. test online example
2. complete Docker
