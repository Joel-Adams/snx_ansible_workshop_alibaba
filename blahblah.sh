#!/bin/sh

NAME=test-user
groupadd $NAME
useradd --create-home -d /home/$NAME --shell /bin/bash -g $NAME $NAME
