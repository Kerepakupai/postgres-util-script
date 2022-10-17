#!/bin/bash

opcion=0

echo "1) Validar procesos"
echo "2) Validar memoria"
echo "3) Listar archivos"
read -n1 -p "Opcion:" opcion
echo -e "\n"

echo "Opcion seleccionada $opcion"
case $opcion in
    1) ps -fea;;
    2) free -m;;
    3) ls -ltr;;
    *) echo "Opcion incorrecta"
esac
    