#!/bin/bash

# Chemin du fichier de configuration
CONFIG_FILE="/etc/named.*.zones"
ll "$CONFIG_FILE" | awk '{print $9}' | while read -r file; do
echo "Vérification de la vue $file"
# Extraire et vérifier chaque fichier de zone
	grep '^zone.*{$' "$file" | awk '{print $2}' | while read -r zone; do
   	# Trouver le chemin du fichier de zone correspondant
        	zone_file=$(grep "file \"$zone" "$file" | awk -F'"' '{print$2}')
        	filename=/var/named/$zone_file
        	if [ -f "$filename" ]; then
            		#echo "Vérification de la zone $zone avec le fichier $zone_file..."
            		check=$(named-checkzone "$zone" "$filename" | grep "OK")
            		if [ -z "$check" ]; then
                	named-checkzone "$zone" "$filename"
            		fi
        	fi
    	done
done
