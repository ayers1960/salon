#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

function PROCESS_PHONE {
  echo "--->$SERVICE"
  echo -n "ENTER PHONE: "
  read CUSTOMER_PHONE
  Q="SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'"
  echo $Q
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'" )
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -n "What is your name? "
    read  CUSTOMER_NAME
    INSERT_CUSTOMER=$($PSQL "INSERT INTO customers (name,phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
    echo  $INSERT_CUSTOMER    
  fi
  if [[ -n $CUSTOMER_NAME ]]
  then
    echo -n "$CUSTOMER_NAME, What time do you need your $SERVICE? "
    read SERVICE_TIME
    if [[ -n $SERVICE_TIME ]]
    then
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'" )
      INSERT_APPPOINTMENT=$($PSQL "INSERT INTO appointments (customer_id,service_id,time) VALUES('$CUSTOMER_ID', '$SERVICE_ID', '$SERVICE_TIME')")
      echo  $INSERT_APPOINTMENT
      echo "I have put you down for a $SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
      XXX=1
    fi
  fi
    
}

echo -e "\n~~~~~ Salon Barber Shop ~~~~~\n"
XXX=0
  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
while [[ "$XXX" == "0" ]]
  do
    while read SERVICE_ID BAR SERVICE
    do
     echo " $SERVICE_ID) $SERVICE"
    done  < <( echo "$SERVICES" )
    echo ""
    echo -n "====>"
    read SERVICE_ID_SELECTED
    while read SERVICE_ID BAR SERVICE
    do
      if [  "$SERVICE_ID_SELECTED" == "$SERVICE_ID" ]
      then
          break
      fi
    done  < <( echo "$SERVICES" )
    if [[ -n $SERVICE ]]
    then
       PROCESS_PHONE
    fi
  done

  #echo -n "ENTER PHONE NUMBER: "


  #echo $SERVICE
