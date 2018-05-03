#!/bin/bash

groupadd ecs-user
useradd --create-home -d /home/ecs-user --shell /bin/bash -g ecs-user ecs-user -G wheel,adm
echo "ecs-user        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/ecs-user
chmod 0440 /etc/sudoers.d/ecs-user
mkdir /home/ecs-user/.ssh
#cat <<EOF >/home/ecs-user/.ssh/authorized_keys
#"${ecs_keypair}"
#EOF
echo "${ecs_keypair}" > /home/ecs-user/.ssh/authorized_keys
chown -R ecs-user.ecs-user /home/ecs-user/.ssh
chmod -R 0700 /home/ecs-user/.ssh
chmod 0600 /home/ecs-user/.ssh/authorized_keys
