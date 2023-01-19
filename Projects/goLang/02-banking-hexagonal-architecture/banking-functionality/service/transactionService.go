package service

import (
	"hexagonal-architecture/app"
	"hexagonal-architecture/dto"
)

type TransactionService interface {
	NewTransaction(dto.TransactionRequest) (*dto.TransactionResponse, *app.AppError)
}
