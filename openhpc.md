Enable root:
<pre>sudo -i</pre>
Then:
<pre>
yum install http://build.openhpc.community/OpenHPC:/1.3/CentOS_7/x86_64/ohpc-release-1.3-1.el7.x86_64.rpm
yum -y install docs-ohpc  
cp /opt/ohpc/pub/doc/recipes/centos7/input.local input.local
cp -p /opt/ohpc/pub/doc/recipes/centos7/x86_64/warewulf/slurm/recipe.sh .
export OHPC_INPUT_LOCAL=./input.local
./recipe.sh
</pre>
