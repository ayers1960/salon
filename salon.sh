#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Barber Shop ~~~~~\n"

MAIN_MENU() {
  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")


    echo "$SERVICES" | while read SERVICE_ID BAR SERVICE
    do
      echo "$SERVICE_ID) $SERVICE"
    done
  echo ""
  echo -n "====>"
  read MAIN_MENU_SELECTION

  case $MAIN_MENU_SELECTION in
    1) RENT_MENU ;;
    2) RETURN_MENU ;;
    3) EXIT ;;
    *) MAIN_MENU "Please enter a valid option." ;;
  esac
}

MAIN_MENU