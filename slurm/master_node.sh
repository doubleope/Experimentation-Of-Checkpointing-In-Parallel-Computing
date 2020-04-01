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
scp /etc/munge/munge.key root@128.105.145.242:/etc/munge 
scp /etc/munge/munge.key root@128.105.146.1:/etc/munge  

chown -R munge: /etc/munge/ /var/log/munge/
















