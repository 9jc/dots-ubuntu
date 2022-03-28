#!/bin/bash
# Script written by Warith Al Maawali  
# (c) 2021 Founder of Eagle Eye Digital Solutions
# Discord channel https://discord.gg/KEFErEx
# Twitter http://twitter.com/warith2020
# Linkedin http://www.linkedin.com/in/warith1977
# http://www.digi77.com
# http://www.om77.net
# Kodachi  OS/Software/Code are strictly protected by LICENSE terms at /home/kodachi/LICENSE
#
#
# script starts here:




cd $(dirname $0) 
source Globalconfig;



# detect empty arguments
if [ $# -eq 0 ]; then
	echo "No arguments entered"
	
	#pause 'Press [Enter] key to exit...or Ctrl c to quit the script and run it again correctly'	
        #exit 1
fi


# Accept command line arguments
while [ $# -gt 0 ]
do
    case "$1" in
    -a)  myAction=$2 ; shift;;       
	--)	shift; break;;
	-*)
	    echo >&2 \
	    "usage: $0 [-v] [-f file] [file ...]"
	    exit 1;;
	*)  break;;	# terminate while loop
    esac
    shift
done
 



if [[ "$myAction" == *digi77* ]]
then     
	netStatustxt=$(cat $Jason_file_name | jq -r .InternetStatus);
	if [[ $netStatustxt == *Online* ]]
	then
		url2=$(cat $Jason_web_file_name | jq -r '.ServerFeed2[].kodachiipcheck'|xargs);
		sudo chown $LOGED_USER.$LOGED_USER $Mykodachi_path/workingdomain.txt;
		echo $url2 > $Mykodachi_path/workingdomain.txt;			
		sudo chown $LOGED_USER.$LOGED_USER $Mykodachi_path/workingdomain.txt;
		writeToJason "1" "systemhealthactionpicker";
		#print_good "digi77.com site will be used as a domain";
	else
		print_error "Net is offline please try again later";
	fi
    #exit; # don't exit because this script used in system health
fi

if [[ "$myAction" == *other* ]]
then   
	
	# First we validate those domains
	arr=( $(cat $Jason_web_file_name | jq -r '.ServerFeed3.netStatusDomains[]') )
	i=0 
	declare -a my_array
	while [ $i -lt ${#arr[@]} ] 
	do   		
		# Get domain only
		x=$(curl -s -m 30 ${arr[$i]}|xargs|tr -d " \t\n\r");
		x=$(echo $x |grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}');
		x=$(echo $x|xargs);
		# If reply is valid ip address then accept the domain
		if [[ "$x" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then
			# Domain is valid
			#echo ${arr[$i]}
			my_array[i]=${arr[$i]}
		fi
		i=`expr $i + 1` 
	done
	
	 
	#if (cat $Jason_web_file_name | jq -r '.ServerFeed3.netStatusDomains[]' > workingdomain.txt)
	if (printf "%s\n" "${my_array[@]}" > workingdomain.txt)
	then
		mq=$(wc -l < workingdomain.txt)
		# If only we have less than 3 domains than we have an issue
		if [[ $mq -lt 3 ]]
		then	
			print_error "Results are bad count is: $mq";
			url2=$(cat $Jason_web_file_name | jq -r '.ServerFeed2[].kodachiipcheck'|xargs);
			sudo chown $LOGED_USER.$LOGED_USER $Mykodachi_path/workingdomain.txt;
			echo $url2 > $Mykodachi_path/workingdomain.txt;			
			sudo chown $LOGED_USER.$LOGED_USER $Mykodachi_path/workingdomain.txt;
			print_good "digi77.com site will be used as a domain";
			writeToJason "1" "systemhealthactionpicker";
		fi
		writeToJason "1" "systemhealthactionpicker";
	else
		print_error "We could not get the jason file please try again later";
		url2=$(cat $Jason_web_file_name | jq -r '.ServerFeed2[].kodachiipcheck'|xargs);
		sudo chown $LOGED_USER.$LOGED_USER $Mykodachi_path/workingdomain.txt;
		echo $url2 > $Mykodachi_path/workingdomain.txt;			
		sudo chown $LOGED_USER.$LOGED_USER $Mykodachi_path/workingdomain.txt;
		print_good "digi77.com site will be used as a domain";
		writeToJason "1" "systemhealthactionpicker";
	fi
	
fi
#exit 1; #exit; # don't exit because this script used in system health
 
