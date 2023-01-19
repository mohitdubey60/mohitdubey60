package route

import (
	"banking-auth/app/logger"
	"banking-auth/dto"
	"banking-auth/service"
	"encoding/json"
	"fmt"
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

func (h UserLoginHandler) Verify(w http.ResponseWriter, r *http.Request) {
	urlParams := make(map[string]string)

	// converting from Query to map type
	for k := range r.URL.Query() {
		urlParams[k] = r.URL.Query().Get(k)
	}

	if urlParams["token"] != "" {
		appErr := h.service.Verify(urlParams)
		if appErr != nil {
			writeResponse(w, appErr.Code, notAuthorizedResponse(appErr.Message))
		} else {
			response := authorizedResponse()
			writeResponse(w, http.StatusOK, response)
		}
	} else {
		writeResponse(w, http.StatusForbidden, notAuthorizedResponse("missing token"))
	}
}

func notAuthorizedResponse(msg string) map[string]interface{} {
	return map[string]interface{}{
		"isAuthorized": false,
		"message":      msg,
	}
}

func authorizedResponse() map[string]bool {
	return map[string]bool{"isAuthorized": true}
}
