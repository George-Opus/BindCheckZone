# BindCheckZone
This script checks all DNS zones named '/etc/named.*.zones'. 
If your zone files are not located here, you can change this by modifying the 'CONFIG_FILE' variable.

## Verbose mode

-v is the first level of verbosity, which displays which zone file or DNS view is currently being checked.
-vv adds to the -v output by showing which domain is currently being checked.

## Default return
By default, the script does not return anything when there are no errors and the zone can be loaded.
