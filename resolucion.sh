#!/bin/bash

# Colores
ROJO='\033[0;31m'
VERDE='\033[0;32m'
AZUL='\033[0;34m'
RESET='\033[0m'

# Función para mostrar el menú de resoluciones
mostrar_menu_resoluciones() {
    echo -e "${AZUL}Selecciona una resolución:${RESET}"
    echo -e "${VERDE}1) 1920x1080${RESET}"
    echo -e "${VERDE}2) 1600x900${RESET}"
    echo -e "${VERDE}3) 1366x768${RESET}"
    echo -e "${VERDE}4) 1280x720${RESET}"
    echo -e "${VERDE}5) 1024x768${RESET}"
    echo -e "${ROJO}0) Salir${RESET}"
}

# Función para mostrar las salidas de pantalla
mostrar_salidas() {
    echo -e "${AZUL}Monitores disponibles:${RESET}"
    xrandr | grep " connected" | awk '{print $1}'
}

# Bucle principal
while true; do
    mostrar_salidas
    read -p "Ingresa el nombre del monitor (o '0' para salir): " SALIDA

    if [[ "$SALIDA" == "0" ]]; then
        echo -e "${ROJO}Saliendo...${RESET}"
        exit 0
    fi

    # Verificar si la salida es válida
    if ! xrandr | grep -q "$SALIDA"; then
        echo -e "${ROJO}Monitor no válido. Intenta de nuevo.${RESET}"
        continue
    fi

    mostrar_menu_resoluciones
    read -p "Ingresa tu opción: " opcion

    case $opcion in
        1)
            RESOLUCION="1920x1080"
            ;;
        2)
            RESOLUCION="1600x900"
            ;;
        3)
            RESOLUCION="1366x768"
            ;;
        4)
            RESOLUCION="1280x720"
            ;;
        5)
            RESOLUCION="1024x768"
            ;;
        0)
            echo -e "${ROJO}Saliendo...${RESET}"
            exit 0
            ;;
        *)
            echo -e "${ROJO}Opción no válida. Intenta de nuevo.${RESET}"
            continue
            ;;
    esac

    # Cambiar la resolución
    if xrandr --output "$SALIDA" --mode "$RESOLUCION"; then
        echo -e "${VERDE}Resolución cambiada a $RESOLUCION en $SALIDA${RESET}"
    else
        echo -e "${ROJO}Error al cambiar la resolución a $RESOLUCION en $SALIDA. Asegúrate de que esté disponible.${RESET}"
    fi
done

