#!/bin/bash
RED='\033[31m'
RESET='\033[0m'
BLUE='\033[34m'
CONFIG_FILE="/etc/named.*.zones"
ls -l $CONFIG_FILE | awk '{print $9}' | while read -r file; do
	if [ "$1" = "-v" ] || [ "$1" = "-vv"  ]
 	then
		echo -e  ${BLUE}"Vérification de la vue $file"${RESET}
 	fi
	grep '^zone.*{$' "$file" | awk '{print $2}' | while read -r zone; do
        	zone_file=$(grep "file \"$zone" "$file" | awk -F'"' '{print$2}')
        	filename=/var/named/$zone_file
        	if [ -f $filename ]
		then
			if [ "$1" = "-vv" ]
			then
				echo "Vérification de la zone $zone avec le fichier $zone_file..."
			fi
			check=$(named-checkzone "$zone" "$filename" | grep "OK")
        		if [ -z $check ]
			then
				echo -e ${RED}| $(named-checkzone "$zone" "$filename")${RESET}
			fi
        	fi
    	done
done
