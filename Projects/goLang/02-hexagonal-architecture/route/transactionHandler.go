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

type TransactionHandler struct {
	service service.TransactionService
}

func (s TransactionHandler) NewTransaction(w http.ResponseWriter, r *http.Request) {
	var transactionRequest dto.TransactionRequest
	parsingErr := json.NewDecoder(r.Body).Decode(&transactionRequest)
	if parsingErr != nil {
		logger.Shared().Logger.Error(parsingErr.Error())
		fmt.Fprint(w, "Error while parsing request object")
		return
	}

	accId := mux.Vars(r)["account_id"]
	transactionRequest.AccountId = accId
	transResponse, err := s.service.NewTransaction(transactionRequest)
	if err != nil {
		w.WriteHeader(err.Code)
		fmt.Fprint(w, err.Message)
		return
	}

	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(transResponse)
}
