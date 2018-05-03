#!/bin/bash

count=0

while IFS= read -r lineA && IFS= read -r lineB <&3;
do
echo "
#----------------------------------------------
# EIP
#----------------------------------------------
resource \"alicloud_eip_association\" \"node_eip_asso-${count}\" {
  allocation_id = \"$lineA\"
  instance_id = \"$lineB\"
}" >>eip_address/eip_association.tf
  count=`expr $count + 1`
done <node_ipidline.txt 3<node_idline.txt
