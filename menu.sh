#!/bin/bash

option=0

while : ; do
    # clean screen
    clear
    # show options
    echo "--------------------"
    echo "       PGUTIL"
    echo "--------------------"
    echo "1) Install Postgres"
    echo "2) Uninstall Postgres"
    echo "3) Make backup"
    echo "4) Restore backup"
    echo "5) Exit"
    echo -e "\n"

    read -n1 -p "Enter an option [1-5]:" option
    echo -e "\n"
    # Check option
    case $option in
        1) 
            echo "Install Postgres"
            sleep 3
            ;;
        2) 
            echo "Uninstall Postgres"
            sleep 3
            ;;
        3) 
            echo "Make backup"
            sleep 3
            ;;
        4) 
            echo "Restore backup"
            sleep 3
            ;;
        5) 
            echo "Exit"
            exit 0
            ;;
    esac
done
