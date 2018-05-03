#!/bin/bash

if [ ! -d dns_record ]; then
mkdir -p dns_record;
fi

file1=tower_ipaddress.txt
file2=node_ipaddress.txt
count=0

for a in $file1
do
cut -d',' --output-delimiter=$'\n' -f1- $file1 >>tower_ipaddressline.txt
done

for a in $file2
do
cut -d',' --output-delimiter=$'\n' -f1- $file2 >>node_ipaddressline.txt
done

echo "
#----------------------------------------------
# API Keys
#----------------------------------------------
provider \"alicloud\" {
  access_key = \"$ALICLOUD_ACCESS_KEY\"
  secret_key = \"$ALICLOUD_SECRET_KEY\"
  region     = \"$ALICLOUD_REGION\"
}" >>dns_record/dns_record.tf

while read line
do
echo "
#----------------------------------------------
# DNS
#----------------------------------------------
resource \"alicloud_dns_record\" \"tower_node-${count}\" {
  value = \"$line\"
  name = \"$ALICLOUD_DOMAIN\"
  host_record = \"$ALICLOUD_WORKSHOP_PREFIX.tower.${count}\"
  type = \"A\"
  ttl = \"300\"
}" >>dns_record/dns_record.tf
count=`expr $count + 1`

done < tower_ipaddressline.txt
