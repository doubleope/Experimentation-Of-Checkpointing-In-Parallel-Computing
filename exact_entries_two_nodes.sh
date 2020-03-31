#!/bin/sh
getenforce
cat /etc/hosts

echo 10.10.1.1 master >> /etc/hosts

systemctl disable firewalld 
systemctl stop firewalld

yum install http://build.openhpc.community/OpenHPC:/1.3/CentOS_7/x86_64/ohpc-release-1.3-1.el7.x86_64.rpm
yum -y install ohpc-base
yum -y install ohpc-warewulf
systemctl enable ntpd.service
systemctl restart ntpd
yum -y install ohpc-slurm-server
perl -pi -e "s/ControlMachine=\S+/ControlMachine=master/" /etc/slurm/slurm.conf

ip a

perl -pi -e "s/device = eth1/device = eth1/" /etc/warewulf/provision.conf
perl -pi -e "s/^\s+disable\s+= yes/ disable = no/" /etc/xinetd.d/tftp
ifconfig eth1 10.10.1.1 netmask 255.255.255.0 up
systemctl restart xinetd
systemctl enable mariadb.service
systemctl restart mariadb
systemctl enable httpd.service
systemctl restart httpd
systemctl enable dhcpd.service

export CHROOT=/opt/ohpc/admin/images/centos7.7
wwmkchroot centos-7 $CHROOT
yum -y --installroot=$CHROOT install ohpc-base-compute
cp -p /etc/resolv.conf $CHROOT/etc/resolv.conf
yum -y --installroot=$CHROOT install ohpc-slurm-client
yum -y --installroot=$CHROOT install ntp
yum -y --installroot=$CHROOT install kernel
yum -y --installroot=$CHROOT install lmod-ohpc

wwinit database
wwinit ssh_keys
echo "10.10.1.1:/home /home nfs nfsvers=3,nodev,nosuid 0 0" >> $CHROOT/etc/fstab
echo "10.10.1.1:/opt/ohpc/pub /opt/ohpc/pub nfs nfsvers=3,nodev 0 0" >> $CHROOT/etc/fstab
echo "/home *(rw,no_subtree_check,fsid=10,no_root_squash)" >> /etc/exports
echo "/opt/ohpc/pub *(ro,no_subtree_check,fsid=11)" >> /etc/exports
exportfs -a
systemctl restart nfs-server
systemctl enable nfs-server
chroot $CHROOT systemctl enable ntpd
echo "server 10.10.1.1" >> $CHROOT/etc/ntp.conf

perl -pi -e 's/# End of file/\* soft memlock unlimited\n$&/s' /etc/security/limits.conf
perl -pi -e 's/# End of file/\* hard memlock unlimited\n$&/s' /etc/security/limits.conf
perl -pi -e 's/# End of file/\* soft memlock unlimited\n$&/s' $CHROOT/etc/security/limits.conf
perl -pi -e 's/# End of file/\* hard memlock unlimited\n$&/s' $CHROOT/etc/security/limits.conf
echo "account required pam_slurm.so" >> $CHROOT/etc/pam.d/sshd


perl -pi -e "s/\\#\\\$ModLoad imudp/\\\$ModLoad imudp/" /etc/rsyslog.conf
perl -pi -e "s/\\#\\\$UDPServerRun 514/\\\$UDPServerRun 514/" /etc/rsyslog.conf
systemctl restart rsyslog
echo "*.* @10.10.1.1:514" >> $CHROOT/etc/rsyslog.conf
perl -pi -e "s/^\*\.info/\\#\*\.info/" $CHROOT/etc/rsyslog.conf
perl -pi -e "s/^authpriv/\\#authpriv/" $CHROOT/etc/rsyslog.conf
perl -pi -e "s/^mail/\\#mail/" $CHROOT/etc/rsyslog.conf
perl -pi -e "s/^cron/\\#cron/" $CHROOT/etc/rsyslog.conf
perl -pi -e "s/^uucp/\\#uucp/" $CHROOT/etc/rsyslog.conf

yum -y install ohpc-ganglia
yum -y --installroot=$CHROOT install ganglia-gmond-ohpc
cp /opt/ohpc/pub/examples/ganglia/gmond.conf /etc/ganglia/gmond.conf
perl -pi -e "s/<sms>/master/" /etc/ganglia/gmond.conf
cp /etc/ganglia/gmond.conf $CHROOT/etc/ganglia/gmond.conf
echo "gridname MySite" >> /etc/ganglia/gmetad.conf
systemctl enable gmond
systemctl enable gmetad
systemctl start gmond
systemctl start gmetad
chroot $CHROOT systemctl enable gmond
systemctl try-restart httpd


yum -y install clustershell-ohpc
cd /etc/clustershell/groups.d
mv local.cfg local.cfg.orig
echo "adm: master" > local.cfg
echo "compute: c[1-2]" >> local.cfg
echo "all: @adm,@compute" >> local.cfg

yum -y install mrsh-ohpc mrsh-rsh-compat-ohpc
yum -y --installroot=$CHROOT install mrsh-ohpc mrsh-rsh-compat-ohpc mrsh-server-ohpc
echo "mshell 21212/tcp # mrshd" >> /etc/services
echo "mlogin 541/tcp # mrlogind" >> /etc/services
chroot $CHROOT systemctl enable xinetd

yum -y install nhc-ohpc
yum -y --installroot=$CHROOT install nhc-ohpc
echo "HealthCheckProgram=/usr/sbin/nhc" >> /etc/slurm/slurm.conf
echo "HealthCheckInterval=300" >> /etc/slurm/slurm.conf

wwsh file import /etc/passwd
wwsh file import /etc/group
wwsh file import /etc/shadow
wwsh file import /etc/slurm/slurm.conf
wwsh file import /etc/munge/munge.key
export WW_CONF=/etc/warewulf/bootstrap.conf
echo "drivers += updates/kernel/" >> $WW_CONF
echo "drivers += overlay" >> $WW_CONF
wwbootstrap `uname -r`


wwvnfs --chroot $CHROOT
echo "GATEWAYDEV=eth0" > /tmp/network.$$
wwsh -y file import /tmp/network.$$ --name network
wwsh -y file set network --path /etc/sysconfig/network --mode=0644 --uid=0


wwsh -y node new c1 --ipaddr=10.10.1.3 --hwaddr=02:79:38:1f:9e:41 -D eth0
wwsh -y node new c2 --ipaddr=10.10.1.2 --hwaddr=02:33:d5:e7:30:6e -D eth0


wwsh -y provision set "c1" --vnfs=centos7.7 --bootstrap=`uname -r` --files=dynamic_hosts,passwd,group,shadow,slurm.conf,munge.key,network
wwsh -y provision set "c2" --vnfs=centos7.7 --bootstrap=`uname -r` --files=dynamic_hosts,passwd,group,shadow,slurm.conf,munge.key,network

systemctl restart gmond
wwsh pxe update
