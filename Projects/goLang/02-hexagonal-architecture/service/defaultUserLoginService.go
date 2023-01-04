package service

import (
	"hexagonal-architecture/app"
	"hexagonal-architecture/app/logger"
	"hexagonal-architecture/domain"
	"hexagonal-architecture/dto"
)

type DefaultUserLoginService struct {
	Repo domain.UserLoginRepository
}

func (s DefaultUserLoginService) ValidateUser(request dto.UserLoginRequest) (*string, *app.AppError) {
	userLogin, authErr := s.Repo.FindBy(request.UserName, request.Password)
	if authErr != nil {
		return nil, authErr
	}
	authString, tokenErr := userLogin.GenerateToken()
	if tokenErr != nil {
		return nil, tokenErr
	}

	logger.Shared().Logger.Info(*authString)

	return authString, nil
}
