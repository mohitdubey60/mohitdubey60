package service

import (
	"banking-auth/app"
	"banking-auth/app/logger"
	"banking-auth/domain"
	"banking-auth/dto"
	"fmt"

	"github.com/golang-jwt/jwt/v4"
)

type DefaultUserLoginService struct {
	Repo            domain.UserLoginRepository
	RolePermissions app.AppRoles
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

func (s DefaultUserLoginService) Verify(urlParams map[string]string) *app.AppError {
	// convert the string token to JWT struct
	if jwtToken, err := jwtTokenFromString(urlParams["token"]); err != nil {
		return app.NewAuthorizationError(err.Error())
	} else {
		/*
		   Checking the validity of the token, this verifies the expiry
		   time and the signature of the token
		*/
		if jwtToken.Valid {
			// type cast the token claims to jwt.MapClaims
			claims := jwtToken.Claims.(*domain.AccessTokenClaims)
			/* if Role if user then check if the account_id and customer_id
			   coming in the URL belongs to the same token
			*/
			if claims.IsUserRole() {
				if !claims.IsRequestVerifiedWithTokenClaims(urlParams) {
					return app.NewAuthorizationError("request not verified with the token claims")
				}
			}

			// verify of the role is authorized to use the route
			isAuthorized := s.RolePermissions.IsAuthorizedFor(claims.Role, urlParams["routeName"])
			if !isAuthorized {
				errMessage := fmt.Sprintf("%s role is not authorized", claims.Role)
				return app.NewAuthorizationError(errMessage)
			}
			return nil
		} else {
			return app.NewAuthorizationError("Invalid token")
		}
	}
}

func jwtTokenFromString(tokenString string) (*jwt.Token, error) {
	token, err := jwt.ParseWithClaims(tokenString, &domain.AccessTokenClaims{}, func(token *jwt.Token) (interface{}, error) {
		return []byte(domain.SECRET_KEY), nil
	})
	if err != nil {
		logger.Shared().Logger.Error("Error while parsing token: " + err.Error())
		return nil, err
	}
	return token, nil
}
