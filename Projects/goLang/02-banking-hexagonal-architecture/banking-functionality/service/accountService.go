package service

import (
	"hexagonal-architecture/app"
	"hexagonal-architecture/dto"
)

type AccountService interface {
	Create(dto.AccountRequest) (*dto.AccountResponse, *app.AppError)
}
