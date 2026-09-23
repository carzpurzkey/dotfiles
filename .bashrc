if [ -d /workspaces/System/go ]; then
  export PATH=$PATH:/workspaces/System/go/bin
  export GOCACHE='/workspaces/Library/cache/go-build'
  export GOENV='/workspaces/Library/config/go/env'
  GOTELEMETRYDIR='/workspaces/Library/config/go/telemetry'
fi
