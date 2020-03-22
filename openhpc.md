Enable root:
<pre>sudo -i</pre>
Check if SELinux is enabled, if enabled disable it(find out how online):
<pre>
getenforce
</pre>
Disable firewall:
<pre>
systemctl disable firewalld 
systemctl stop firewalld
</pre>
Then:
<pre>
yum install http://build.openhpc.community/OpenHPC:/1.3/CentOS_7/x86_64/ohpc-release-1.3-1.el7.x86_64.rpm
</pre>
