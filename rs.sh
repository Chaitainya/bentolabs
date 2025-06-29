#!/bin/bash
#Author Chaitanya Geddam

echo "Issue found: JavaScript heap out of memory."

if sudo lsof -i :3030 > /dev/null 2>&1; then
    echo "Port 3030 is in use so killing the port."
    npx kill-port 3030
else
    echo "Port 3030 is not in use."
fi

echo "Resetting heap memory: "
node --max-old-space-size=4096 ./node_modules/@angular/cli/bin/ng serve --port 3030 --configuration=local
