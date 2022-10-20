#!/bin/bash

readonly SCRIPT_NAME="$(basename "$0")"

function log {
    local readonly level="$1"
    local readonly message="$2"
    local readonly timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    local readonly now=$(date +"%Y%m%d")
    if [[ ! -f $now.log ]] ; then
        touch $now.log
        echo "log file $now.log created"
    fi
    echo -e "${timestamp} [${level}] [$SCRIPT_NAME] ${message}" >> $now.log
}

function log_error {
    local readonly message="$1"
    log "ERROR" "$message"
}

function log_info {
    local readonly message"$1"
    log "INFO" "$message"
}

function assert_is_installed {
    local readonly program_name="$1"
    if [[ $(command -v ${program_name}) ]] ; then
        log_error "'$program_name' allready installed"
    fi
}

function install_postgres {
    if [[ $(command -v psql) ]] ; then
        echo "'postgres' allready installed"
        log_error "'postgres' allready installed"
    else
        echo "Installing postgres..."
        read -s -p "Enter 'sudo' password" sudo_password
        echo "$sudo_password" | sudo -S apt update -y 
        echo "$sudo_password" | sudo -S apt upgrade -y
        echo "$sudo_password" | sudo -S apt-get -y install postgresql postgresql-contrib
        read -s -p "Enter 'postgres' password" psql_password
        echo "$sudo_password" | sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '{$psql_password}';"
        echo "$sudo_password" | sudo -S systemctl enable postgresql.service
        echo "$sudo_password" | sudo -S systemctl start postgresql.service
        log_info "'postgres' installed sucessfully"
    fi
    read -n 1 -s -r -p "Press [ENTER] to continue..." 
}

function uninstall_postgres {
    echo "Uninstalling postgres..."

}

function db_backup {

    echo "Backup database"
    local BAK_DIR="$(echo $HOME/mysql)"
    local MYSQL="$(which mysql)"
    local MYSQLDUMP="$(which mysqldump)"
    local GZIP="$(which gzip)"

    DB_USER=""
    DB_PASS=""
    HOST=""
    DATABASE=""

    echo "Backup path $BAK_DIR"
    [[ ! -d $BAK_DIR ]] && mkdir -p "$BAK_DIR"
    FILE=$BAK_DIR/$DATABASE.$NOW-$(date +"%T").gz
    $MYSQLDUMP --single-transaction --set-gtid-purged=OFF -u $USER -h $HOST -p$PASS $DATABASE | $GZIP -9 > $FILE

}

function db_restore {
    echo "Restore database"
    echo "Restore path $1"

}

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
            install_postgres $backup_path
            sleep 3
            ;;
        2) 
            uninstall_postgres
            sleep 3
            ;;
        3) 
            read -p "Backup path:" backup_path
            db_backup $backup_path
            sleep 3
            ;;
        4) 
            read -p "Restore path:" restore_path
            db_restore $restore_path
            sleep 3
            ;;
        5) 
            echo "Exit"
            exit 0
            ;;
    esac
done
