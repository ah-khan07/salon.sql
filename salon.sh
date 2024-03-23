#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo "Welcome to My Salon, how can I help you?" 
 
SERVICE_MENU () {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  
  echo -e "\n1) cut \n2) color \n3) perm \n4) style \n5) trim"
    read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) CUT_MENU ;;
    2) COLOR_MENU ;;
    3) PERM_MENU ;;
    4) STYLE_MENU;;
    5) TRIM_MENU ;;
    *) SERVICE_MENU "I could not find that service. What would you like today?" ;;
  esac
}

CUT_MENU () {
# get customer info
 echo -e "What's your phone number?"
 read CUSTOMER_PHONE
 CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  if [[ -z $CUSTOMER_NAME ]]
    then
    # get new customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME

    # insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')") 
  fi
  #Make an appointment
  SERVICE_TYPE=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
  echo -e "\nWhat time would you like your$SERVICE_TYPE,$CUSTOMER_NAME?"
  read SERVICE_TIME
  
 INSERT_APPOINTMENT_DETAILS=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ((SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'), '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")
 echo -e "\nI have put you down for a$SERVICE_TYPE at $SERVICE_TIME, $CUSTOMER_NAME."
  
}

    COLOR_MENU () {
    CUT_MENU
    }

    PERM_MENU () {
    CUT_MENU
    }

    STYLE_MENU () {
    CUT_MENU
    }

    TRIM_MENU () {
    CUT_MENU
    }


SERVICE_MENU