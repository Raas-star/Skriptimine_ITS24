#!/bin/bash
# Skript: faili olemasolu, faili tüübi ja õiguste kontroll

if [ $# -ne 2 ]; then
    echo "Kasutamine: $0 fail_soovitud_oigused"
    echo "Näide: $0 /etc/passwd 644"
    exit 1
fi

FAIL=$1
OIGUS=$2

if [ ! -e "$FAIL" ]; then
    echo "Hoiatus: Fail $FAIL ei eksisteeri!"
    exit 1
fi

if [ ! -f "$FAIL" ]; then
    echo "Hoiatus: $FAIL ei ole tavaline fail!"
    exit 1
fi

OLEMAS_OIGUS=$(stat -c %a "$FAIL")

if [ "$OLEMAS_OIGUS" -eq "$OIGUS" ]; then
    echo "Fail $FAIL on olemas ja õigustega korrektselt määratud ($OLEMAS_OIGUS)."
else
    echo "Hoiatus: faili $FAIL õigused on $OLEMAS_OIGUS, peaksid olema $OIGUS!"
fi

