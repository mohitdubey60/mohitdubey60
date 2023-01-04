package domain

import (
	"hexagonal-architecture/app"
	"hexagonal-architecture/dto"
)

type Transaction struct {
	Id        string  `db:"transaction_id"`
	AccountId string  `db:"account_id"`
	Amount    float64 `db:"amount"`
	Type      string  `db:"transaction_type"`
	Date      string  `db:"transaction_date"`
}

func (s Transaction) ToResponseDTO() dto.TransactionResponse {
	return dto.TransactionResponse{
		Id: s.Id,
	}
}

type TransactionRepository interface {
	NewTransaction(Transaction) (*Transaction, *app.AppError)
}
