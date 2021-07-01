#!/bin/bash

#The script  waits 60 secs before checking the app. If it's up, it returns success. If it's not up, then it falls back to default database. If it is up with default database, shows that message. Otherwise shows error message.

sleep 60

if [ "$(curl http://localhost:8080/actuator/health)" == '{"status":"UP"}' ] && [ "$(curl -Is http://localhost:8080/actuator/health | grep HTTP/ | awk {'print $2'})" == '200' ]
then 
	echo "Success! Petclinic is running on the main database!"
else 
        echo "Cannot connect to the main database. Connecting to the default database... "
	sudo systemctl stop petclinic
        /bin/java -jar /home/petclinic/petclinic.jar > /dev/null 2>&1 &
	sleep 30

        if [ "$(curl http://localhost:8080/actuator/health)" == '{"status":"UP"}' ] && [ "$(curl -Is http://localhost:8080/actuator/health | grep HTTP/ | awk {'print $2'})" == '200' ]
        then 
                echo "Petclinic is running on the default database!"
        else
                echo "Petclinic Failed!!!"
        fi 2>/dev/null
fi 2>/dev/null
