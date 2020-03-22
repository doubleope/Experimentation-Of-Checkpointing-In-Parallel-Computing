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
