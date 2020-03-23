Enable root:
<pre>sudo -i</pre>
Check if SELinux is enabled, if enabled disable it(find out how online):
<pre>
getenforce
</pre>
Decide what node to make the master node. For example 'node0'. Then copy the ip address of this node from hosts file. Open the file:
<pre>cat /etc/hosts</pre>
Then save the ipaddress and the name of the master node e.g 'master' to the host files by entering:
<pre>echo {master_node_ip} {name_of_master_node} >> /etc/hosts</pre>
Disable firewall:
<pre>
systemctl disable firewalld 
systemctl stop firewalld
</pre>
Then:
<pre>
yum install http://build.openhpc.community/OpenHPC:/1.3/CentOS_7/x86_64/ohpc-release-1.3-1.el7.x86_64.rpm
yum -y install ohpc-base
yum -y install ohpc-warewulf
systemctl enable ntpd.service
systemctl restart ntpd
yum -y install ohpc-slurm-server
perl -pi -e "s/ControlMachine=\S+/ControlMachine={name_of_master_node}/" /etc/slurm/slurm.conf
</pre>
Replace {sms_eth_internal} with what you get from entering:
<pre>ip a</pre>
<pre>
perl -pi -e "s/device = eth1/device = {sms_eth_internal}/" /etc/warewulf/provision.conf
perl -pi -e "s/^\s+disable\s+= yes/ disable = no/" /etc/xinetd.d/tftp
ifconfig {sms_eth_internal} {sms_ip} netmask {internal_netmask} up
systemctl restart xinetd
systemctl enable mariadb.service
systemctl restart mariadb
systemctl enable httpd.service
systemctl restart httpd

</pre>
