package domain

import (
	"hexagonal-architecture/app"
	"hexagonal-architecture/dto"
)

type Customer struct {
	Id          string `db:"customer_id"` //db:"<Table column name>" is used to map struct with table
	Name        string
	City        string
	DateOfBirth string `db:"date_of_birth"` //db:"<Table column name>" is used to map struct with table
	Zipcode     string
	Status      string
}

func (c Customer) statusText() string {
	statusText := "active"
	if c.Status == "0" {
		statusText = "inactive"
	}

	return statusText
}
func (c Customer) ToDTO() dto.CustomerResponse {
	customerResponse := dto.CustomerResponse{
		Id:          c.Id,
		Name:        c.Name,
		City:        c.City,
		DateOfBirth: c.DateOfBirth,
		Zipcode:     c.Zipcode,
		Status:      c.statusText(),
	}

	return customerResponse
}

type CustomerRepository interface {
	FindAll(int) ([]Customer, *app.AppError)
	ById(string) (*Customer, *app.AppError)
}
