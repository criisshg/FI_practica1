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
		"se")
                        read -p "Introdueix l'estat del país: " CADENA
	          codi_e=$(awk -F',' -v CADENA="$CADENA" -v codi_p="$codi_p" '{if ($7==codi_p && $5==CADENA) print $4}' cities.csv | uniq)
                        if [ -z "$codi_e" ]; then
                                 codi_e=$codi_e_anterior
                                 echo "S'ha guardat el valor anterior. En cas de no haver cap valor anteriorment, se li ha assignat 'XX'"
                        else
                                echo "El codi de $CADENA es $codi_e"
                                codi_e_anterior=$codi_e
                        fi
                        ;;

                "le")
                        Cinc=$(awk -F',' -v codi_p="$codi_p" '$7==codi_p {print $4, $5}' cities.csv | uniq)
                        if [ -z "$Cinc" ]; then
                                echo "Hi ha un error, reintenta-ho des del principi"
                        else
                                awk -F',' -v codi_p="$codi_p" '$7==codi_p {print $4, $5}' cities.csv | uniq
                        fi
                        ;;
                "lcp")
                        Sis=$(awk -F',' -v codi_p="$codi_p" '$7==codi_p {print $2, $11}' cities.csv)
                        if [ -z "$Sis" ]; then
                                echo "Hi ha un error, reintenta-ho des del principi"
                        else
                                awk -F',' -v codi_p="$codi_p" '$7==codi_p {print $2, $11}' cities.csv
                        fi
                        ;;

                "ecp")
                        Set=$(awk -F',' -v codi_p="$codi_p" '$7==codi_p {print $2, $11}' cities.csv | uniq)
                        if [ -z "$Set" ]; then
                                echo "Hi ha un error, reintenta-ho des del principi"
                        else
                                awk -F',' -v codi_p="$codi_p" '$7==codi_p {print $2, $11}' cities.csv | uniq > ${codi_p}.csv
                                echo "S'ha guardat a ${codi_p}.csv"
                        fi
                        ;;
                "lce")
                        Vuit=$(awk -F',' -v codi_p="$codi_p" -v codi_e="$codi_e" '{if ($7==codi_p && $4==codi_e) print $2, $11}' cities.csv)
                        if [ -z "$Vuit" ]; then
                                echo "Hi ha un error, reintenta-ho des del principi"
                        else
                                awk -F',' -v codi_p="$codi_p" -v codi_e="$codi_e" '{if ($7==codi_p && $4==codi_e) print $2, $11}' cities.csv
                        fi
                        ;;
                "ej9")
                        Nou=$(awk -F',' -v codi_e="$codi_e" -v codi_p="$codi_p" '{if ($7 == codi_p && $4 == codi_e) print $2, $11}' cities.csv | uniq)
                        if [ -z "$Nou" ]; then
                                echo "Hi ha un error, reintenta-ho des del principi"
                        else
                                awk -F',' -v codi_e="$codi_e" -v codi_p="$codi_p" '{if ($7 == codi_p && $4 == codi_e) print $2, $11}' cities.csv | uniq > ${codi_p}_${codi_e}.csv
                        fi
                        ;;

                "gwd")
                        read -p "Introdueix la població d'un estat: " CADENA
                        wdid=$(awk -F',' -v codi_e="$codi_e" -v codi_p="$codi_p" -v CADENA="$CADENA" '{if ($7 == codi_p && $4 == codi_e && $2 == CADENA ) print $11}' cities.csv | uniq)
                        if [ -z "$wdid" ]; then
                                echo "Hi ha un error, reintenta-ho des del principi"
                        else
                                curl https://www.wikidata.org/wiki/Special:EntityData/$wdid.json > "$wdid".json
                                echo "S'ha guardat a $wdid.json"
                        fi
                        ;;
                "est")
                        V1=0.0
                        V2=0.0
                        V3=0.0
                        V4=0.0
                        V5=0.0
                        V6=0.0
                        awk -F',' -v V1=$V1 -v V2=$V2 -v V3=$V3 -v V4=$V4 -v V5=$V5 -v V6=$V6 '{V1+=($9>0);V2+=($9<0);V3+=($10>0);V4+=($10<0);V5+=($9==0 && $10==0);V6+=($11=="")} END {print "Nord", V1, "Sud", V2, "Est", V3, "Oest", V4, "No ubic", V5, "No WDId", V6}' cities.csv
                        ;;
                *)
                        echo "Opció no vàlida"
                        ;;






        esac

done

