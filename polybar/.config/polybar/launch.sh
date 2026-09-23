#!/usr/bin/env bash


# Termina as instâncias atuais do polybar
killall -q polybar

# Aguarda até que os processos sejam encerrados
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Inicia a barra chamada "minhabarra"
sleep 1
polybar infobar --config=$HOME/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar starting..."
