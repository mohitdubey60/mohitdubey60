package domain

import (
	"database/sql"
	"fmt"

	"hexagonal-architecture/app"
	"hexagonal-architecture/app/logger"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
)

type CustomerRepositoryDB struct {
	client *sqlx.DB
}

func (s CustomerRepositoryDB) FindAll(status int) ([]Customer, *app.AppError) {
	var getAllCustomersQuery string
	if status > 1 {
		getAllCustomersQuery = "SELECT customer_id, name, date_of_birth, city, zipcode, status FROM customers"
	} else {
		getAllCustomersQuery = "SELECT customer_id, name, date_of_birth, city, zipcode, status FROM customers where status=?"
	}

	// var rows *sql.Rows
	customers := make([]Customer, 0)
	var err error
	if status > 1 {
		// rows, err = s.client.Query(getAllCustomersQuery)
		err = s.client.Select(&customers, getAllCustomersQuery)
	} else {
		// rows, err = s.client.Query(getAllCustomersQuery, status)
		err = s.client.Select(&customers, getAllCustomersQuery, status)
	}

	if err != nil {
		logger.Shared().Logger.Error("Error while querying the customer table" + err.Error())
		appError := app.NoDataFoundAppError("Issue while querying from table")
		return nil, appError
	}

	//Boiler plate way of using native sql
	// customers := make([]Customer, 0)
	// for rows.Next() {
	// 	var customer Customer
	// 	err := rows.Scan(&customer.Id, &customer.Name, &customer.DateOfBirth, &customer.City, &customer.Zipcode, &customer.Status)
	// 	if err != nil {
	// 		logger.Shared().Logger.Error("Error while scanning the table " + err.Error())

	// 		var appError *app.AppError
	// 		if err == sql.ErrNoRows {
	// 			appError = app.NoDataFoundAppError("No Customer records found")
	// 		} else {
	// 			appError = app.InternalIssueAppError("Something is wrong at our end.")
	// 		}
	// 		return nil, appError
	// 	}

	// 	customers = append(customers, customer)
	// }

	message := fmt.Sprintf("Fetched %v rows from DB", len(customers))
	logger.Shared().Logger.Info(message)
	return customers, nil
}
func (s CustomerRepositoryDB) ById(id string) (*Customer, *app.AppError) {
	var customer Customer
	getCustomersQuery := "SELECT customer_id, name, date_of_birth, city, zipcode, status FROM customers where customer_id=?"

	//Boiler plate code
	// row := s.client.QueryRow(getCustomersQuery, id)
	// err := row.Scan(&customer.Id, &customer.Name, &customer.DateOfBirth, &customer.City, &customer.Zipcode, &customer.Status)

	err := s.client.Get(&customer, getCustomersQuery, id)
	if err != nil {
		logger.Shared().Logger.Error("Error while scanning the table " + err.Error())
		var appError *app.AppError
		if err == sql.ErrNoRows {
			appError = app.NoDataFoundAppError("No Customer records found")
		} else {
			appError = app.InternalIssueAppError("Something is wrong at our end.")
		}
		return nil, appError
	}

	message := fmt.Sprintf("Fetched %v from DB", customer)
	logger.Shared().Logger.Info(message)
	return &customer, nil
}

func NewCustomerRepositoryDB() CustomerRepositoryDB {
	client, _ := OpenDBConnection()

	return CustomerRepositoryDB{client: client}
}
