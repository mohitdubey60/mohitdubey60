package domain

import (
	"time"

	"github.com/jmoiron/sqlx"
)

func OpenDBConnection() (*sqlx.DB, error) {
	//db, err := sql.Open("mysql", "root:mohit@123@tcp(localhost:3306)/banking")
	db, err := sqlx.Open("mysql", "root:mohit@123@tcp(localhost:3306)/banking")
	if err != nil {
		panic(err)
	}
	// See "Important settings" section.
	db.SetConnMaxLifetime(time.Minute * 3)
	db.SetMaxOpenConns(10)
	db.SetMaxIdleConns(10)

	return db, err
}
