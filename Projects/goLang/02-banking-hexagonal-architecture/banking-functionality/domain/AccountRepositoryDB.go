package domain

import (
	"hexagonal-architecture/app"
	"hexagonal-architecture/app/logger"
	"strconv"

	"github.com/jmoiron/sqlx"
)

type AccountRepositoryDB struct {
	client *sqlx.DB
}

func (s AccountRepositoryDB) Create(account Account) (*Account, *app.AppError) {
	createAccountQuery := "INSERT INTO accounts (customer_id, opening_date, account_type, amount, status) VALUES (?, ?, ?, ?, ?)"
	result, err := s.client.Exec(createAccountQuery, account.C_Id, account.OpeningDate, account.Type, account.Amount, account.Status)
	if err != nil {
		var appError *app.AppError
		logger.Shared().Logger.Error(err.Error())
		appError = app.IssueInInsert("Cannot create the account at this moment")
		return nil, appError
	}

	account_id, _ := result.LastInsertId()
	account.Id = strconv.FormatInt(account_id, 10)
	return &account, nil
}

func NewAccountRepositoryDB() AccountRepositoryDB {
	client, _ := OpenDBConnection()

	return AccountRepositoryDB{client: client}
}
