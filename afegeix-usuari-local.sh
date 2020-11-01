#!/bin/bash
#DaniPerezLlurba
#https://github.com/a18danperllu/Practica15/afegeix-usuari-local.sh                   
# 1-Asegurar que el script lo ejecuta el superusuario
if [[ "${UID}" -eq 0 ]]
then
# 2-Pide el nombre del usuario.
        echo "Introduce el nombre de usuario: "
        read  nombre_usuari
        # 3-Pide el nombre real del usuarios (se introducira en el campo de lo comentarios).
        echo "Introduce el nombre real: "
        read  nombre_real
        # 4-Pide la contraseña.
        echo "Introduce la contraseña que quieres tener: "
        read -s contra
        # 5-Crea el usuario.
        useradd -c ${nombre_real} -m ${nombre_usuari}
        # 6-Comprueba que el usuario ha sido creado correctamente.
        cat /etc/passwd | grep ${nombre_usuari}
        if [[ $? -eq 0 ]]
        then
                echo "Comprovación de que el usario se ha creado correctamente"
        else
                echo "ha ocurrido un error"
                exit 1
        fi
        # 7-Establece la contraseña al usuario.
        echo ${nombre_usuari}":"${contra} | chpasswd
        # 8-Comprueba si la contraseña se le ha otorgado de manera correcta.
        if [[ $? -eq 0 ]]
        then
                echo "Comprovación de que la contraseña se le ha dado correctamente"
        else
                echo "ha ocurrido un error"
                exit 1
        fi
        # 9-Fuerza a cambiar la contraseña.
        echo "En el primer Sign In se te obliga a cambiar la contraseña, porfavor introduzca la contraseña otra vez"
        read -s contra2
        passwd -e ${nombre_usuari}
        echo ${nombre_usuari}":"${contra2} | chpasswd
        # 10-Muestra el usuario, la contraseña y desde que host se ha creado.
        echo "El resumen final es:"
        echo "- El usuario es: "${nombre_usuari}
        echo "- La contraseña es: "${contra2}
        echo "- El Host desde donde se ha creado es: "${HOSTNAME}
else
        echo "No puedes ejecutar este script, intentalo mas tarde con el usuario root"
fi

