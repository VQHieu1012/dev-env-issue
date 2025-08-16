## Docker compose for testing environment
Clickhouse --> ODBC  --> Oracle

### How to run

#### Requirements
Docker

#### Steps
1. Clone the repository
```
git clone https://github.com/VQHieu1012/dev-env-issue.git
```
2. Up and running
```
cd dev-env-issue
docker compose up -d
```
3. Execute to Oracle and create sample table
```
docker compose exec oracle bash
```
```
sqlplus demo/demo123@localhost:1521/XEPDB1

create table sample (id INT);
insert into sample values (1);
insert into sample values (2);
select * from sample;
```
4. Execute to odbc-bridge and test isql
```
docker compose exec odbc-bridge bash

isql -v oracle_new

select * from sample;

quit
```

5. Execute to clickhouse and test odbc function
```
docker compose exec clickhouse bash
```
```
clickhouse-client

select * from odbc("DSN=oracle_new", "demo", "sample");
```

#### More information
##### Oracle
User: SYS

Password: Oracle123

User: demo

Password:demo123

##### Clickhouse
CLICKHOUSE_USER and CLICKHOUSE_PASSWORD are not set. Cannot connect by user default from remote client.
