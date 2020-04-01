#!/bin/sh
yum remove mariadb-server mariadb-devel -y
yum remove slurm munge munge-libs munge-devel -y
cat /etc/passwd | grep slurm
userdel -r slurm
userdel -r munge
