# Start/Manage Development Server

A command to start and manage the development environment server.

## Server Startup Confirmation & Management

Check the server status before starting development, and start it if necessary:

```bash
# Check for an existing Vite server
ps aux | grep -E "vite.*--port 3000" | grep -v grep

# If the server is not running, start a new one
if ! ps aux | grep -E "vite.*--port 3000" | grep -v grep > /dev/null; then
  echo "Server is not running. Starting the development server..."
  npm run dev &
  echo "Starting server... waiting for 5 seconds"
  sleep 5
else
  echo "An existing server was found. Using it as is."
  ps aux | grep -E "vite.*--port 3000" | grep -v grep | awk '{print "PID: " $2 " - Vite server is already running"}'
fi

# Confirm server operation
echo "Confirming server operation..."
curl -s http://localhost:3000 > /dev/null && echo "✅ The server is operating normally" || echo "⚠️ Cannot connect to the server"
```

## Server Management Commands

### Check Server Status

```bash
# Check the currently running server process
ps aux | grep -E "vite.*--port 3000" | grep -v grep

# Check port usage
lsof -i :3000
```

### Stop Server

```bash
# Stop the Vite server
pkill -f "vite.*--port 3000"

# Force stop (if the above does not stop it)
ps aux | grep -E "vite.*--port 3000" | grep -v grep | awk '{print $2}' | xargs kill -9
```

### Restart Server

```bash
# Stop the server
pkill -f "vite.*--port 3000"

# Wait a bit
sleep 2

# Restart the server
npm run dev &

# Confirm startup
sleep 5
curl -s http://localhost:3000 > /dev/null && echo "✅ The server is operating normally" || echo "⚠️ Cannot connect to the server"
```

## Usage Scenarios

- Preparing the environment before starting TDD development
- Recovery when the server has stopped
- When it is necessary to check the server status
- When setting up the development environment

## Points to Note

- If port 3000 is being used by another process, please terminate that process.
- After starting the server, you can check its operation by accessing http://localhost:3000 in your browser.
- It is recommended to properly stop the server started in the background when you have finished your work.
