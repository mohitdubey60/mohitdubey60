package service

import (
	"hexagonal-architecture/app"
	"hexagonal-architecture/dto"
)

type UserLoginService interface {
	ValidateUser(dto.UserLoginRequest) (*string, *app.AppError)
}
