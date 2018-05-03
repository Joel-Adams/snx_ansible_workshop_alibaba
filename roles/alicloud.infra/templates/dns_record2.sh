#!/bin/bash

count=0

while read line
do
echo "
#----------------------------------------------
# DNS
#----------------------------------------------
resource \"alicloud_dns_record\" \"node-${count}\" {
  value = \"$line\"
  name = \"$ALICLOUD_DOMAIN\"
  host_record = \"$ALICLOUD_WORKSHOP_PREFIX.node.${count}\"
  type = \"A\"
  ttl = \"300\"
}" >>dns_record/dns_record.tf
count=`expr $count + 1`

done < node_ipaddressline.txt
