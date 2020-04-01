#!/bin/sh

export MUNGEUSER=991
groupadd -g $MUNGEUSER munge
useradd  -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge  -s /sbin/nologin munge
export SLURMUSER=992
groupadd -g $SLURMUSER slurm
useradd  -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm  -s /bin/bash slurm

yum install epel-release
yum install munge munge-libs munge-devel -y

chown -R munge: /etc/munge/ /var/log/munge/
chmod 0700 /etc/munge/ /var/log/munge/

systemctl enable munge
systemctl start munge

yum install openssl openssl-devel pam-devel numactl numactl-devel hwloc hwloc-devel lua lua-devel readline-devel rrdtool-devel ncurses-devel man2html libibmad libibumad -y
mkdir /nfs
cd /nfs
wget https://download.schedmd.com/slurm/slurm-20.02.1.tar.bz2
yum install perl-devel perl-CPAN
yum install rpm-build
rpmbuild -ta slurm-20.02.1.tar.bz2
cd /root/rpmbuild/RPMS/x86_64  
mkdir /nfs/slurm-rpms   
cp -a . /nfs/slurm-rpms  



