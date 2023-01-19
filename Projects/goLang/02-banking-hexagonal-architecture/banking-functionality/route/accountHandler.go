package route

import (
	"encoding/json"
	"fmt"
	"hexagonal-architecture/app/logger"
	"hexagonal-architecture/dto"
	"hexagonal-architecture/service"
	"net/http"

	"github.com/gorilla/mux"
)

type AccountHandler struct {
	service service.AccountService
}

func (s AccountHandler) CreateAccount(w http.ResponseWriter, r *http.Request) {
	var accountRequest dto.AccountRequest
	parsingErr := json.NewDecoder(r.Body).Decode(&accountRequest)
	if parsingErr != nil {
		logger.Shared().Logger.Error(parsingErr.Error())
		fmt.Fprint(w, "Error while parsing request object")
		return
	}

	custId := mux.Vars(r)["customer_id"]
	accountRequest.CustomerId = custId
	accResponse, err := s.service.Create(accountRequest)
	if err != nil {
		w.WriteHeader(err.Code)
		fmt.Fprint(w, err.Message)
		return
	}

	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(accResponse)
}
