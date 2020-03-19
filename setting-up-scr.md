## Note: This is not working yet, this is for documentation purposes only for now. Will update when everything works

## Install spack:

<pre>git clone https://github.com/spack/spack.git
cd spack/bin
./spack install zlib
</pre>

## Install compilers:

<pre>sudo yum install gcc-gfortran</pre>

Then locate compilers.yaml file at:
<pre>~/.spack/linux </pre>

Modify the file and make changes to 'f77' and 'fc' fields like so:
<pre>
f77: /usr/bin/gfortran
fc: /usr/bin/gfortran
</pre>

## Install scr:

<pre>~/spack/bin/./spack install scr</pre>

## Building the SCR test_api example

#### Do the following:
<pre>
sudo yum install openmpi-devel.x86_64
export PATH=/usr/lib64/openmpi/bin:$PATH
</pre>

#### Find the directory where SCR was installed:
<pre>~/spack/bin/./spack find --paths scr</pre>

#### Go to the installation directory and find the examples folder:
<pre>cd <install dir>/share/scr/examples</pre>

#### Build the test_api example:
<pre>make test_api</pre>

## Running the scr test_api example:
### Install SLURM
Go to home directory by entering:
<pre>cd</pre>
Download SLURM:
<pre>wget https://download.schedmd.com/slurm/slurm-20.02.0.tar.bz2</pre>
Install by doing the following:
<pre>
tar -xf slurm-20.02.0.tar.bz2
cd slurm-20.02.0
./configure
sudo make install
</pre>
## Current Tasks:
<ul>
  <li>Setting up SLURM</li>
 
</ul>

