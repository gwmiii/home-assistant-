#!/bin/bash 
# 
# Copyright 2017 George Murdock III biosman.1978@gmail.com
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 

#uses pfsense_fauxapi at  https://github.com/ndejong/pfsense_fauxapi/tree/master/extras/client-libs/bash
#pulls stats file from pfsense using fauxapi
#set current working directory to the directory of the script

cd "$(dirname "$0")"

source lib/fauxapi_lib.sh
export  fauxapi_auth=`fauxapi_auth $3 $4`


#Help
if [ "$#" -ne 4 ]; then 
    echo "Illegal number of parameters."
    echo "<ip? <output file> <apikey> <apisecret> "
    echo ""
    exit 1
fi

nc -z -w 1  $1 443 # test to see if Https:// is open for this host

if [ $? -eq 0 ] #test to see nc returns error
then
  fauxapi_system_stats $1| tee $2
  exit 0
else
  echo "port not open on pfsense router" >&2
  exit 1
fi
