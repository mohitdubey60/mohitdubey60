package domain

import (
	"fmt"
	"hexagonal-architecture/app"
	"hexagonal-architecture/app/logger"
	"strconv"

	"github.com/jmoiron/sqlx"
)

type TransactionRepositoryDB struct {
	client *sqlx.DB
}

func (s TransactionRepositoryDB) NewTransaction(transaction Transaction) (*Transaction, *app.AppError) {
	var account Account
	getAccountQuery := "SELECT account_id, customer_id, opening_date, account_type, amount, status  FROM accounts WHERE account_id=?"
	accountErr := s.client.Get(&account, getAccountQuery, transaction.AccountId)
	if accountErr != nil || account == (Account{}) {
		errorMessage := fmt.Sprint("Account does not exist for this transaction")
		logger.Shared().Logger.Error(accountErr.Error())
		appError := app.IssueInInsert(errorMessage)
		return nil, appError
	}
	if account.Amount < transaction.Amount {
		errorMessage := fmt.Sprint("You account does not have enough balance")
		logger.Shared().Logger.Error("Transaction amount is greater than account balance")
		appError := app.IssueInInsert(errorMessage)
		return nil, appError
	}

	createNewTransactionQuery := "INSERT INTO transactions (account_id, amount, transaction_type, transaction_date) VALUES (?, ?, ?, ?)"
	result, err := s.client.Exec(createNewTransactionQuery, transaction.AccountId, transaction.Amount, transaction.Type, transaction.Date)
	if err != nil {
		logger.Shared().Logger.Error(err.Error())
		appError := app.IssueInInsert("Cannot complete this transaction")
		return nil, appError
	}

	transaction_id, _ := result.LastInsertId()
	transaction.Id = strconv.FormatInt(transaction_id, 10)

	return &transaction, nil
}

func NewTransactionRepositoryDB() TransactionRepositoryDB {
	client, _ := OpenDBConnection()

	return TransactionRepositoryDB{
		client: client,
	}
}
