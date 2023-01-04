package service

import (
	"hexagonal-architecture/app"
	"hexagonal-architecture/dto"
)

type CustomerService interface {
	GetAllCustomers(int) ([]dto.CustomerResponse, *app.AppError)
	GetCustomer(string) (*dto.CustomerResponse, *app.AppError)
}
