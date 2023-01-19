package domain

import (
	"banking-auth/app"
	"banking-auth/app/logger"
	"database/sql"
	"fmt"

	"github.com/jmoiron/sqlx"
)

type UserLoginRepositoryDB struct {
	Client *sqlx.DB
}

func (s UserLoginRepositoryDB) FindBy(username string, password string) (*UserLogin, *app.AppError) {
	var userLogin UserLogin
	getAuthUserQuery := `SELECT u.username as username , u.role as role, a.customer_id as customerid, GROUP_CONCAT(a.account_id) as accountids 
	FROM users u LEFT JOIN accounts a ON u.customer_id = a.customer_id 
	WHERE u.username =? AND u.password = ? 
	GROUP BY a.customer_id`
	err := s.Client.Get(&userLogin, getAuthUserQuery, username, password)
	if err != nil {
		logger.Shared().Logger.Error(err.Error())
		var appError *app.AppError
		if sql.ErrNoRows == err {
			errMessage := fmt.Sprintf("%v is not authorised for this request", username)
			appError = app.UnauthorisedUser(errMessage)
		} else {
			appError = app.InternalIssueAppError("Something is wrong, please try in sometime")
		}
		return nil, appError
	}

	return &userLogin, nil
}

func NewUserLoginRepositryDB() UserLoginRepositoryDB {
	client, _ := OpenDBConnection()

	return UserLoginRepositoryDB{
		Client: client,
	}
}
