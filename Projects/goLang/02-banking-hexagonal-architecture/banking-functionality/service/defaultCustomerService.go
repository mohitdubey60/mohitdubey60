package service

import (
	"hexagonal-architecture/app"
	"hexagonal-architecture/domain"
	"hexagonal-architecture/dto"
)

type DefaultCustomerService struct {
	Repo domain.CustomerRepository
}

func (s DefaultCustomerService) GetAllCustomers(status int) ([]dto.CustomerResponse, *app.AppError) {
	cs, err := s.Repo.FindAll(status)
	if err != nil {
		return nil, err
	}

	customers := make([]dto.CustomerResponse, 0)
	for _, c := range cs {
		customers = append(customers, c.ToDTO())
	}

	return customers, nil
}
func (s DefaultCustomerService) GetCustomer(id string) (*dto.CustomerResponse, *app.AppError) {
	c, err := s.Repo.ById(id)
	if err != nil {
		return nil, err
	}

	customer := c.ToDTO()

	return &customer, nil
}

func NewCustomerService(repo domain.CustomerRepository) DefaultCustomerService {
	return DefaultCustomerService{Repo: repo}
}
