#!/bin/bash

if [ ! -d eip_address ]; then
mkdir -p eip_address;
fi

file1=tower_ipid.txt
file2=tower_id.txt
file3=node_ipid.txt
file4=node_id.txt
count=0

for a in $file1
do
cut -d',' --output-delimiter=$'\n' -f1- $file1 >>tower_ipidline.txt
done

for a in $file2
do
cut -d',' --output-delimiter=$'\n' -f1- $file2 >>tower_idline.txt
done

for a in $file3
do
cut -d',' --output-delimiter=$'\n' -f1- $file3 >>node_ipidline.txt
done

for a in $file4
do
cut -d',' --output-delimiter=$'\n' -f1- $file4 >>node_idline.txt
done

echo "
#----------------------------------------------
# API Keys
#----------------------------------------------
provider \"alicloud\" {
  access_key = \"$ALICLOUD_ACCESS_KEY\"
  secret_key = \"$ALICLOUD_SECRET_KEY\"
  region     = \"$ALICLOUD_REGION\"
}">>eip_address/eip_association.tf

while IFS= read -r lineA && IFS= read -r lineB <&3;
do
echo "
#----------------------------------------------
# EIP
#----------------------------------------------
resource \"alicloud_eip_association\" \"tower_eip_asso-${count}\" {
  allocation_id = \"$lineA\"
  instance_id = \"$lineB\"
}" >>eip_address/eip_association.tf
  count=`expr $count + 1`
done <tower_ipidline.txt 3<tower_idline.txt
