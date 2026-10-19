#!/bin/sh
set -e

if [ -n "$TUNNEL_GATEWAY" ]; then
  echo "Waiting for tunnel gateway $TUNNEL_GATEWAY..."
  until ip route get "$TUNNEL_GATEWAY" >/dev/null 2>&1; do
    sleep 1
  done

  ip route replace default via "$TUNNEL_GATEWAY"
  echo "Default route via $TUNNEL_GATEWAY set."
else
  echo "TUNNEL_GATEWAY not set, skipping route setup."
fi

# Run VS Code Tunnel in background
# Required VSCODE_TUNNEL_NAME and VSCODE_CLI_ACCESS_TOKEN (GitHub Personal Token)
if [ -n "$VSCODE_TUNNEL_NAME" ]; then

  export VSCODE_CLI_USE_FILE_KEYCHAIN=true
  export VSCODE_CLI_DISABLE_KEYCHAIN_ENCRYPT=true
  export VSCODE_CLI_DATA_DIR=/root/.vscode-cli

  code tunnel user login --provider github

  echo "Starting VS Code Tunnel: $VSCODE_TUNNEL_NAME"
  code tunnel \
    --name "$VSCODE_TUNNEL_NAME" \
    --accept-server-license-terms \
    --no-sleep \
    --log info \
    --log-to-file /var/log/vscode-tunnel.log &
else
  echo "VSCODE_TUNNEL_NAME not set, skipping VS Code Tunnel."
fi

exec "$@"