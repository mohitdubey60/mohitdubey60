package domain

import (
	"hexagonal-architecture/app"
	"hexagonal-architecture/dto"
)

type Account struct {
	Id          string  `db:"account_id"`
	C_Id        string  `db:"customer_id"`
	OpeningDate string  `db:"opening_date"`
	Type        string  `db:"account_type"`
	Amount      float64 `db:"amount"`
	Status      string  `db:"status"`
}

func (s Account) ToResponseDTO() dto.AccountResponse {
	return dto.AccountResponse{
		AccountId: s.Id,
	}
}

type AccountRepository interface {
	Create(Account) (*Account, *app.AppError)
}
