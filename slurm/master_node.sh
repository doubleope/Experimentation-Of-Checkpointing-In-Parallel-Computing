#!/bin/sh
yum remove mariadb-server mariadb-devel -y
yum remove slurm munge munge-libs munge-devel -y
cat /etc/passwd | grep slurm

yum install mariadb-server mariadb-devel -y

export MUNGEUSER=991
groupadd -g $MUNGEUSER munge
useradd  -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge  -s /sbin/nologin munge
export SLURMUSER=992
groupadd -g $SLURMUSER slurm
useradd  -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm  -s /bin/bash slurm

yum install epel-release
yum install munge munge-libs munge-devel -y
yum install rng-tools -y
rngd -r /dev/urandom
/usr/sbin/create-munge-key -r

dd if=/dev/urandom bs=1 count=1024 > /etc/munge/munge.key
chown munge: /etc/munge/munge.key
chmod 400 /etc/munge/munge.key
scp /etc/munge/munge.key root@172.17.20.2:/etc/munge 
scp /etc/munge/munge.key root@172.17.20.3:/etc/munge 


yum install openssl openssl-devel pam-devel numactl numactl-devel hwloc hwloc-devel lua lua-devel readline-devel rrdtool-devel ncurses-devel man2html libibmad libibumad -y
mkdir /nfs
cd /nfs
wget https://download.schedmd.com/slurm/slurm-20.02.1.tar.bz2
yum install perl-devel perl-CPAN
rpmbuild -ta slurm-20.02.1.tar.bz2
cd /root/rpmbuild/RPMS/x86_64  
mkdir /nfs/slurm-rpms   
cp -a . /nfs/slurm-rpms  

yum --nogpgcheck localinstall slurm-20.02.1-1.el7.x86_64.rpm slurm-libpmi-20.02.1-1.el7.x86_64.rpm slurm-slurmctld-20.02.1-1.el7.x86_64.rpm slurm-contribs-20.02.1-1.el7.x86_64.rpm slurm-openlava-20.02.1-1.el7.x86_64.rpm slurm-slurmd-20.02.1-1.el7.x86_64.rpm slurm-devel-20.02.1-1.el7.x86_64.rpm slurm-pam_slurm-20.02.1-1.el7.x86_64.rpm slurm-slurmdbd-20.02.1-1.el7.x86_64.rpm slurm-example-configs-20.02.1-1.el7.x86_64.rpm slurm-perlapi-20.02.1-1.el7.x86_64.rpm slurm-torque-20.02.1-1.el7.x86_64.rpm

cd /etc/slurm
wget https://raw.githubusercontent.com/doubleope/Up-To-Par-Alell/master/slurm/slurm.conf 
mkdir /var/spool/slurmctld
chown slurm: /var/spool/slurmctld
chmod 755 /var/spool/slurmctld
touch /var/log/slurmctld.log
chown slurm: /var/log/slurmctld.log
touch /var/log/slurm_jobacct.log /var/log/slurm_jobcomp.log
chown slurm: /var/log/slurm_jobacct.log /var/log/slurm_jobcomp.log

yum install ntp -y
chkconfig ntpd on
ntpdate pool.ntp.org
systemctl start ntpd











