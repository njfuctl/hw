#!/bin/bash

max_value=
min_value=

awk -F'>' '/<td class=rb>[0-9]+<\/td>/ {
  num = $5
  gsub("[^0-9]+", "", num)  

  if (max_value == "" || num > max_value) {
    max_value = num
  }

  if (min_value == "" || num < min_value) {
    min_value = num
  }
}

END {
  print "最小值：" min_value
  print "最大值：" max_value
}'  tables.html

sum=0

awk -F'>' '/<td class=rb>[0-9]+<\/td>/ {
  num2 = $5
  num3 = $7
  gsub("[^0-9]+", "", num2)  
  gsub("[^0-9]+", "", num3)

  if (num2 ~ /^[0-9]+$/ && num3 ~ /^[0-9]+$/) {
    diff = num2 - num3
    sum += diff
  }
}

END {
  print "第二列和第三列数字的差的和：" sum
}'  tables.html
