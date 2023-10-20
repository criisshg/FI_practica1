#!/bin/bash

CADENA='(("\w+( +\w+)+")|\w+)'

codi_p_anterior='XX'
codi_e_anterior='XX'

x="R"
while [ $x != "q" ]; do
        read x
        case $x in
                "q")
                        echo "Sortint de l'aplicació"
                        exit
                        ;;
	
                "lp")
                        cut -d',' -f7,8 cities.csv | uniq
                        ;;
	
                "sc")
                        read -p "Introdueix un país: " CADENA
                        codi_p=$(awk -F',' -v CADENA="$CADENA" ' $8==CADENA {print $7} ' cities.csv | uniq)
                        if [ -z "$codi_p" ]; then
                                codi_p=$codi_p_anterior
                                echo "S'ha guardat el valor anterior. En cas de no haver cap valor anteriorment, se li ha assignat 'XX'"
                        else
                                echo "El codi de $CADENA es $codi_p"
                                codi_p_anterior=$codi_p
                        fi
                        ;;
