#!/usr/bin/env bash

#checking for updates and installing jdk if not installed already
sudo apt update --fix-missing -y
sudo apt install openjdk-14-jdk -y

#function to clone the repo if it does not exist in working directory. If it exists, it pulls the repo for any updates.
function clone_pull {
    Dir=$(basename "$1" .git)
    if [[ -d "$Dir" ]]; then
      cd $Dir
      git pull
    else
      git clone "$1" && cd $Dir
    fi
}

#cloning my repo
clone_pull https://gitlab.com/m1r3x/demo1

chmod +x mvnw

./mvnw clean package

#copying the .jar file from original location to home directory of petclinic user
cp /home/petclinic/demo1/target/*.jar /home/petclinic/petclinic.jar
