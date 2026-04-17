#!/bin/bash
set -e

# Remove o pids se existir
rm -f /app/tmp/pids/server.pid

# Executa o processo principal
exec "$@"