package domain

import (
	"encoding/json"
	"fmt"
	"hexagonal-architecture/app/logger"
	"net/http"
	"net/url"
)

type UserAuthRepository interface {
	IsAuthorized(token string, routeName string, vars map[string]string) bool
}

type RemoteUserAuthRepository struct {
}

func (s RemoteUserAuthRepository) IsAuthorized(token string, routeName string, vars map[string]string) bool {
	u := buildVerifyUrl(token, routeName, vars)

	logger.Shared().Logger.Info(u)
	if response, err := http.Get(u); err != nil {
		logger.Shared().Logger.Error(err.Error())
		return false
	} else {
		m := map[string]bool{}
		// fmt.Printf("\n%v\n", printResponse(response))
		// printResponse(response)
		if err := json.NewDecoder(response.Body).Decode(&m); err != nil {
			logger.Shared().Logger.Error("Error while decoding response from auth server. " + err.Error())
			return false
		}

		logger.Shared().Logger.Info(fmt.Sprintf("%v", m))
		return m["isAuthorized"]
	}
}
func buildVerifyUrl(token string, routeName string, vars map[string]string) string {
	u := url.URL{
		Host:   "localhost:8001",
		Path:   "/auth/verify",
		Scheme: "http",
	}
	q := u.Query()
	q.Add("token", token)
	q.Add("routeName", routeName)
	for k, v := range vars {
		q.Add(k, v)
	}
	u.RawQuery = q.Encode()

	return u.String()
}

func NewAuthRepository() RemoteUserAuthRepository {
	return RemoteUserAuthRepository{}
}
