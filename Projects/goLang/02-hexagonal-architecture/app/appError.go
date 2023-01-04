package app

import (
	"net/http"
)

type AppError struct {
	Code    int    `json:"code, omitempty"`
	Message string `json:"message"`
}

func NoDataFoundAppError(message string) *AppError {
	return &AppError{
		Code:    http.StatusNotFound,
		Message: message,
	}
}

func InternalIssueAppError(message string) *AppError {
	return &AppError{
		Code:    http.StatusInternalServerError,
		Message: message,
	}
}

func IssueInInsert(message string) *AppError {
	return &AppError{
		Code:    http.StatusUnprocessableEntity,
		Message: message,
	}
}

func (s AppError) ErrorMessage() *AppError {
	appError := AppError{Message: s.Message}

	return &appError
}
