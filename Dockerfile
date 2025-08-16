FROM clickhouse/clickhouse-server:22.3.12.19

# cài deps
RUN apt-get update \
    && apt-get install -y curl unzip unixodbc tdsodbc libaio1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Oracle Instant Client Basic
RUN curl -fSL https://download.oracle.com/otn_software/linux/instantclient/instantclient-basic-linuxx64.zip -o /tmp/instantclient.zip \
    && unzip -o /tmp/instantclient.zip -d /opt/oracle \
    && rm /tmp/instantclient.zip

# Oracle Instant Client ODBC
RUN curl -fSL https://download.oracle.com/otn_software/linux/instantclient/instantclient-odbc-linuxx64.zip -o /tmp/instantclient-odbc.zip \
    && unzip -o /tmp/instantclient-odbc.zip -d /opt/oracle \
    && rm /tmp/instantclient-odbc.zip

# cấu hình LD_LIBRARY_PATH
# ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_23_9:$LD_LIBRARY_PATH

# copy driver vào thư mục system lib
RUN cp /opt/oracle/instantclient_23_9/*so* /usr/lib \
    && cp /opt/oracle/instantclient_23_9/*so* /usr/lib64 \
    && cp /opt/oracle/instantclient_23_9/*so* /lib

ENTRYPOINT ["/usr/bin/clickhouse-odbc-bridge", "--listen-host", "0.0.0.0", "--http-port", "9018"]
EXPOSE 9018
