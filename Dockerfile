FROM mcr.microsoft.com/mssql/server

CMD mkdir -p /app
WORKDIR /app

ADD --chown=mssql:root https://raw.githubusercontent.com/microsoft/sql-server-samples/master/samples/databases/northwind-pubs/instnwnd.sql .
ADD entrypoint.sh .

ENTRYPOINT ./entrypoint.sh
