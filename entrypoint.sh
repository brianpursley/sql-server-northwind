#!/bin/sh
/opt/mssql/bin/sqlservr & 
pid=$!

# Wait for SQL Server to become ready
i=0
while [ $i -lt 120 ]; do
  echo "Waiting for SQL Server to become ready..."
  /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "${SA_PASSWORD}" -d tempdb -Q "select 1" > /dev/null 2>&1 && break
  sleep 1
  i=$(( $i + 1 ))
done

# Run script to create Northwind database
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "${SA_PASSWORD}" -d tempdb -i instnwnd.sql

echo "Northwind is ready"

# Wait for SQL Server process to end (prevents container from exiting)
wait $pid