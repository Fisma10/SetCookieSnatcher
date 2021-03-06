# I'm sure this code looks like it's escaped a SCP lab. But I just quickly threw it up for a project, and might change later if I am willing to go through the horrors of bash scripting again

# Basically a help page
if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]
 then
 echo "[Insert good ascii art by someone with talent]"
 echo "Usage: ./SetCookieSnatcher [Cookie] [URL] [Number of IDs] [(Optional) POST data {-P=}] [(Optional) Cookies data to send {-C=}] [(Optional) Sleep time {-S=}]"
 echo "Example: ./SetCookieSnatcher PHPSESSID www.example.com 20 -P=test1=1&test2=2 -C=darkmode=1 -S=1"
 exit
fi

# Get the parameters in a horribly inefficient and ugly way
Nap=0
Cookies=
Post=
if [ -n $4 ]
 then
 ParamLen=${#4}
 if [ $ParamLen -gt 3 ]
  then
  Param=${4:0:3}
  if [ $Param == "-P=" ]
   then
   Post=${4:3:$ParamLen - 3}
  fi
  if [ $Param == "-C=" ]
   then
   Cookies=${4:3:$ParamLen - 3}
  fi
  if [ $Param == "-S=" ]
   then
   Nap=${4:3:$ParamLen - 3}
  fi
 fi
fi
if [ -n $5 ]
 then
 ParamLen=${#5}
 if [ $ParamLen -gt 3 ]
  then
  Param=${5:0:3}
  if [ $Param == "-P=" ]
   then
   Post=${5:3:$ParamLen - 3}
  fi
  if [ $Param == "-C=" ]
   then
   Cookies=${5:3:$ParamLen - 3}
  fi
  if [ $Param == "-S=" ]
   then
   Nap=${5:3:$ParamLen - 3}
  fi
 fi
fi
if [ -n $6 ]
 then
 ParamLen=${#6}
 if [ $ParamLen -gt 3 ]
  then
  Param=${6:0:3}
  if [ $Param == "-P=" ]
   then
   Post=${6:3:$ParamLen - 3}
  fi
  if [ $Param == "-C=" ]
   then
   Cookies=${6:3:$ParamLen - 3}
  fi
  if [ $Param == "-S=" ]
   then
   Nap=${6:3:$ParamLen - 3}
  fi
 fi
fi

# Essentially just use curl and grep the results that you want. But with just a few bells and whistles that in all honestly just save a few key presses
Len=$3
i=0
while [[ i -le $Len ]]
 do
 if [ -z $Cookies ] && [ -z $Post ]
  then
  curl -I $2 2>/dev/null | grep -o -E "$1.*;"
 elif [ -z $Cookies ]
  then
  curl -X POST -d $Post -i $2 2>/dev/null | grep -o -E "$1.*;"
 elif [ -z $Post ]
  then
  curl -I --cookie $Cookies $2 2>/dev/null | grep -o -E "$1.*;"
 else
  curl -X POST -d $Post --cookie $Cookies -i $2 2>/dev/null | grep -o -E "$1.*"
 fi
 ((i = i + 1))
 sleep $Nap
done
