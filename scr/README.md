# How to setup SCR

## Install spack:

<pre>git clone https://github.com/spack/spack.git
cd spack/bin
./spack install zlib
</pre>

## Install compilers:

<pre>sudo yum install gcc-gfortran</pre>

Open the compilers.yaml file:
<pre>vim ~/.spack/linux/compilers.yaml </pre>

Modify the file and make changes to 'f77' and 'fc' fields like so:
<pre>
f77: /usr/bin/gfortran
fc: /usr/bin/gfortran
</pre>

## Install scr:

<pre>~/spack/bin/./spack install scr</pre>

## Complete SCR setup

#### Find the directory where openmpi was installed and export to path:
<pre>
~/spack/bin/./spack find --paths openmpi
</pre>
Copy the output and replace {directory} in the following line with it
<pre>
export PATH={directory}/bin:$PATH
</pre>

## Run the SCR test_api example

#### Find the directory where SCR was installed:
<pre>~/spack/bin/./spack find --paths scr</pre>

#### Go to the installation directory and find the examples folder:
<pre>cd {installation directory}/share/scr/examples</pre>
<pre>make test_api</pre>
<pre>mpirun -np 2 test_api</pre>
