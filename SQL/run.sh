#!/bin/bash

clear

username="root"
password="H3ro_0fOur+T1me"

mysql -u$username -p$password -t -v < ecommerce_dds.sql
mysql -u$username -p$password -t -v < ecommerce_dms.sql
mysql -u$username -p$password -t -v < ecommerce_functions.sql
mysql -u$username -p$password -t -v < ecommerce_views.sql
