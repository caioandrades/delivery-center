FROM python:3.10-bullseye

WORKDIR /app

# Configure your application to connect to the SQL Server container
#ENV DB_SERVER=""
#ENV DB_PORT=""
#ENV DB_DATABASE=""
ENV DB_USER="SA"
ENV DB_PASSWORD="Passw0rd123"

# Install dependencies for Oracle Instant Client and MSSQL Server
RUN mkdir /opt/oracle && \
    cd /opt/oracle/ && \
    apt-get update && apt-get install -y libaio1 wget unzip && \
    wget https://download.oracle.com/otn_software/linux/instantclient/218000/instantclient-basic-linux.x64-21.8.0.0.0dbru.zip && \
    unzip instantclient-basic-linux.x64-21.8.0.0.0dbru.zip && \
    rm -f instantclient-basic-linux.x64-21.8.0.0.0dbru.zip && \
    cd instantclient* && \
    sh -c "echo /opt/oracle/instantclient_21_8 > /etc/ld.so.conf.d/oracle-instantclient.conf" && \
    ldconfig && \
    # Install Microsoft SQL Server ODBC driver
    # Microsoft ODBC MSSQL doc: https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server
    curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc && \
    curl https://packages.microsoft.com/config/debian/9/prod.list | tee /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y && \
    apt-get install -y msodbcsql18