## Install spack:

<pre>git clone https://github.com/spack/spack.git
cd spack/bin
./spack install zlib
</pre>

## Install compilers:

<pre>sudo yum install gcc-gfortran</pre>

Then add to compilers.yaml file located at
<pre> /users/your_username/.spack/linux </pre>

## Install scr (make sure you're in the spack/bin directory):

<pre>./spack install scr</pre>

## Building the SCR test_api example

#### Do the following:
<pre>
sudo yum install openmpi-devel.i686
export PATH=/usr/lib/openmpi/bin:$PATH
sudo yum -y install glibc-devel.i386
</pre>

#### Find the directory where spack was installed:
<pre>./spack find --paths</pre>
