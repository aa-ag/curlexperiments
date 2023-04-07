#!/bin/bash
dialog --checklist "Choose toppings:" 10 40 3 \
        1 setup off \
        2 database off \
        3 import off
# sh setup.sh
# sh db.sh
# sh import.sh