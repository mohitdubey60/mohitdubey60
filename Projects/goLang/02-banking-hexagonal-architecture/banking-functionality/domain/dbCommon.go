package domain

import (
	"fmt"
	"time"

	"github.com/jmoiron/sqlx"
)

type DBConfig struct {
	username string
	password string
	host     string
	port     string
	dbName   string
}

func OpenDBConnection() (*sqlx.DB, error) {
	dbConfig := DBConfig{
		username: "root",
		password: "mohit@123",
		host:     "localhost",
		port:     "3306",
		dbName:   "banking",
	}
	//Eg string: "root:mohit@123@tcp(localhost:3306)/banking"
	dbString := fmt.Sprintf("%v:%v@tcp(%v:%v)/%v", dbConfig.username, dbConfig.password, dbConfig.host, dbConfig.port, dbConfig.dbName)

	//db, err := sql.Open("mysql", "root:mohit@123@tcp(localhost:3306)/banking")
	db, err := sqlx.Open("mysql", dbString)
	if err != nil {
		panic(err)
	}
	// See "Important settings" section.
	db.SetConnMaxLifetime(time.Minute * 3)
	db.SetMaxOpenConns(10)
	db.SetMaxIdleConns(10)

	return db, err
}
