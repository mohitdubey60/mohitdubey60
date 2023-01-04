package domain

import (
	"database/sql"
	"hexagonal-architecture/app"
	"hexagonal-architecture/app/logger"
	"strings"
	"time"

	"github.com/golang-jwt/jwt/v4"
)

const TOKEN_DURATION = time.Hour
const SECRET_KEY = "@@##SECRET_KEY##@@"

type UserLogin struct {
	// Password   string         `db:"password"`
	UserName   string         `db:"username"`
	CustomerId sql.NullString `db:"customerid"`
	AccountIds sql.NullString `db:"accountids"`
	Role       string         `db:"role"`
}

func (s UserLogin) GenerateToken() (*string, *app.AppError) {
	var jwtClaims jwt.MapClaims
	if s.CustomerId.Valid && s.AccountIds.Valid {
		jwtClaims = s.claimForUser()
	} else {
		jwtClaims = s.claimForAdmin()
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwtClaims)
	signedTokenString, err := token.SignedString([]byte(SECRET_KEY))
	if err != nil {
		logger.Shared().Logger.Error(err.Error())
		return nil, app.UnauthorisedUser("Unable to sign token. Looks like it is invalid")
	}

	return &signedTokenString, nil
}
func (s UserLogin) claimForUser() jwt.MapClaims {
	accounts := strings.Split(s.AccountIds.String, ",")
	return jwt.MapClaims{
		"customer_id": s.CustomerId,
		"role":        s.Role,
		"username":    s.UserName,
		"accounts":    accounts,
		"exp":         time.Now().Add(TOKEN_DURATION).Unix(),
	}
}
func (s UserLogin) claimForAdmin() jwt.MapClaims {
	return jwt.MapClaims{
		"role":     s.Role,
		"username": s.UserName,
		"exp":      time.Now().Add(TOKEN_DURATION).Unix(),
	}
}

type UserLoginRepository interface {
	FindBy(string, string) (*UserLogin, *app.AppError)
}
