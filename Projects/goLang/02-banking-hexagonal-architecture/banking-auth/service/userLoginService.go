package service

import (
	"banking-auth/app"
	"banking-auth/dto"
)

type UserLoginService interface {
	ValidateUser(dto.UserLoginRequest) (*string, *app.AppError)
	Verify(urlParams map[string]string) *app.AppError
}
