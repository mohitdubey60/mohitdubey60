package route

import (
	"encoding/json"
	"fmt"
	"hexagonal-architecture/app/logger"
	"hexagonal-architecture/dto"
	"hexagonal-architecture/service"
	"net/http"
)

type UserLoginHandler struct {
	service service.UserLoginService
}

func (s UserLoginHandler) ValidateUser(w http.ResponseWriter, r *http.Request) {
	var userLoginRequest dto.UserLoginRequest
	parsingErr := json.NewDecoder(r.Body).Decode(&userLoginRequest)
	if parsingErr != nil {
		w.WriteHeader(http.StatusUnprocessableEntity)
		logger.Shared().Logger.Error(parsingErr.Error())
		fmt.Fprint(w, "Error while parsing request object")
		return
	}

	authString, authErr := s.service.ValidateUser(userLoginRequest)
	if authErr != nil {
		w.WriteHeader(authErr.Code)
		fmt.Fprint(w, "User cannot be validate. Invalid user!")
		return
	}

	fmt.Printf("Auth string %v", *authString)
	fmt.Fprint(w, *authString)
}
