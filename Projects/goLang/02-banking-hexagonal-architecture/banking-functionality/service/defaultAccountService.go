package service

import (
	"fmt"
	"hexagonal-architecture/app"
	"hexagonal-architecture/app/logger"
	"hexagonal-architecture/domain"
	"hexagonal-architecture/dto"
	"strings"
	"time"
)

type DefaultAccountService struct {
	Repo domain.AccountRepository
}

func (s DefaultAccountService) Create(accountRequest dto.AccountRequest) (*dto.AccountResponse, *app.AppError) {

	if accountRequest.Amount < 5000 {
		errMessage := fmt.Sprint("Amount should be more than 5000")
		logger.Shared().Logger.Error(errMessage)
		return nil, app.IssueInInsert(errMessage)
	}
	if strings.ToLower(accountRequest.Type) != "savings" && strings.ToLower(accountRequest.Type) != "current" {
		errMessage := fmt.Sprint("Account should be either `savings` or `current`")
		logger.Shared().Logger.Error(errMessage)
		return nil, app.IssueInInsert(errMessage)
	}

	account := domain.Account{
		C_Id:        accountRequest.CustomerId,
		OpeningDate: time.Now().Format("2006-01-02 15:04:05"),
		Amount:      accountRequest.Amount,
		Type:        accountRequest.Type,
		Status:      "1",
	}

	acc, err := s.Repo.Create(account)
	if err != nil {
		return nil, err
	}

	accResponse := acc.ToResponseDTO()

	return &accResponse, nil
}
