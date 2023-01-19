#Command to create a go project:-> go mod init <FolderName>
Eg: go mod init booking-app

#Command to run a file:-> go run <FileName>.go
Eg: go run main.go

Adding dependencies or helper libraries go get -u <Library>
#Gorilla mux:   go get github.com/gorilla/mux
#UberGo Logger: go get -u go.uber.org/zap 
#Sql helper:    go get -u github.com/jmoiron/sqlx

#jwt token: go get -u github.com/golang-jwt/jwt/v4
https://jwt.io/
https://github.com/golang-jwt/jwt


mysql: 
In case getting this group error "Error 1055 (42000): Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column '<column name>' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by"}" 
then switch off ONLY_FULL_GROUP_BY by running below Command in mySQL query editor
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

