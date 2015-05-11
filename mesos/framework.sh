#!/bin/sh

if test -z "ARANGODB_WEBUI_PORT" -o "$ARANGODB_WEBUI_PORT" -eq 0;  then
  ARANGODB_WEBUI_PORT="${PORT0}"
fi

if test -z "$ARANGODB_WEBUI_HOST";  then
  if test "$ARANGODB_WEBUI_USE_HOSTNAME" = "yes";  then
    ARANGODB_WEBUI=http://${HOSTNAME}:${ARANGODB_WEBUI_PORT}/
  else
    ARANGODB_WEBUI=http://${HOST}:${ARANGODB_WEBUI_PORT}/
  fi
else
  ARANGODB_WEBUI="http://${ARANGODB_WEBUI_HOST}:${ARANGODB_WEBUI_PORT}/"
fi

env

echo "ARANGODB_WEBUI_PORT: $ARANGODB_WEBUI_PORT"
echo "ARANGODB_WEBUI_HOST: $ARANGODB_WEBUI_HOST"

cd /mesos
exec ./arangodb-framework "--http_port=${ARANGODB_WEBUI_PORT}" "--webui=${ARANGODB_WEBUI}" "$@"
