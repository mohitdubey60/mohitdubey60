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

type DefaultTransactionService struct {
	Repo domain.TransactionRepository
}

func (s DefaultTransactionService) NewTransaction(request dto.TransactionRequest) (*dto.TransactionResponse, *app.AppError) {
	if request.Amount < 0 {
		errorMessage := fmt.Sprint("Transaction amount cannot be less than zero")
		logger.Shared().Logger.Error(errorMessage)
		appError := app.IssueInInsert(errorMessage)
		return nil, appError
	}
	if strings.ToLower(request.Type) != "withdrawl" && strings.ToLower(request.Type) != "deposit" {
		errorMessage := fmt.Sprint("Transaction type should be either `withdrawl` or `deposit`")
		logger.Shared().Logger.Error(errorMessage)
		appError := app.IssueInInsert(errorMessage)
		return nil, appError
	}

	transaction := domain.Transaction{
		AccountId: request.AccountId,
		Amount:    request.Amount,
		Type:      request.Type,
		Date:      time.Now().Format("2006-01-02 15:04:05"),
	}

	tr, err := s.Repo.NewTransaction(transaction)
	if err != nil {
		return nil, err
	}

	transactionResponse := tr.ToResponseDTO()

	return &transactionResponse, nil
}
