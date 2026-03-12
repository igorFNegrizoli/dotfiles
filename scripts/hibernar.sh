#!/bin/bash
# Garante que o sudo valide a senha ANTES de trancar a tela
sudo -v
# Bloqueia a sessão (segurança)
loginctl lock-session
# Pausa curta para garantir que o bloqueio foi aplicado
sleep 1
# Garante o desligamento total e hiberna
sudo bash -c "echo shutdown > /sys/power/disk && echo disk > /sys/power/state"
