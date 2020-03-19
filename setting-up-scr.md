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
<pre>./spack find --paths scr</pre>


## Use CMake
<pre>
git clone https://github.com/LLNL/scr 
mkdir build
mkdir install
cd build
pip3 install --user git+https://github.com/jaraco/path.git
sudo yum install pdsh

if (NOT PYTHON_INCLUDE_DIRS OR NOT PYTHON_LIBRARY)
    SET PYTHON_INCLUDE_DIRS = "/usr/include/python2.7"
    SET PYTHON_LIBRARY = "/usr/lib/python2.7/config/libpython2.7.so"
endif()

cmake -DCMAKE_INSTALL_PREFIX=../install ../scr



</pre>
## Tasks:
<ul>
  <li>Try using CMake to build it on a fresh node</li>
  <li>Test online example</li>
  <li>Complete Docker</li>
  <li> Add /usr/lib/openmpi/include to include in makefile. Do this in a fresh node</li>
  <li></li>
</ul>

