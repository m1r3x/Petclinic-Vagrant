#!/bin/bash


#checking if we can access petclinic database with petclinicDBuser

if mysql -u $DBUSER -p$DBPASSWD -h 192.168.1.2 -e "use $DBNAME"; then 
	echo "Database works!"; else 
	echo "Database failed!"; 
fi 2>/dev/null
