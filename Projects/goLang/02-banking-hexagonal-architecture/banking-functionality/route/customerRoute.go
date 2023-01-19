package route

import (
	"encoding/json"
	"encoding/xml"
	"fmt"
	"hexagonal-architecture/service"
	"net/http"

	"hexagonal-architecture/app/logger"

	"github.com/gorilla/mux"
)

type CustomerHandler struct {
	service service.CustomerService
}

func (s *CustomerHandler) GetAllCustomers(w http.ResponseWriter, r *http.Request) {
	var status int
	if r.URL.Query().Has("status") {
		if r.URL.Query().Get("status") == "active" {
			status = 1
		} else {
			status = 0
		}
	} else {
		status = 2
	}
	customers, err := s.service.GetAllCustomers(status)

	if err != nil {
		message := fmt.Sprintf("Error in getting customers Error: %v", err.Message)
		logger.Shared().Logger.Error(message)
		fmt.Fprintf(w, message)
		return
	}

	//Keeping xml as I find it useful
	if r.Header.Get("Content-Type") == "application/xml" {
		w.Header().Add("Content-Type", "application/xml")
		xml.NewEncoder(w).Encode(customers)
	} else {
		w.Header().Add("Content-Type", "application/json")
		json.NewEncoder(w).Encode(customers)
	}
}
func (s *CustomerHandler) GetCustomers(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	customerId := vars["customer_id"]

	customer, err := s.service.GetCustomer(customerId)

	if err != nil {
		message := fmt.Sprintf("Error in getting customer with id %v Error: %v", customerId, err.Message)
		logger.Shared().Logger.Error(message)
		w.WriteHeader(http.StatusNotFound)
		fmt.Fprintf(w, message)
		return
	} else if customer == nil {
		message := fmt.Sprintf("No customer found with id %v", customerId)
		logger.Shared().Logger.Error(message)
		w.WriteHeader(http.StatusNoContent)
		fmt.Fprintf(w, message)
		return
	}

	if r.Header.Get("Content-Type") == "application/xml" {
		w.Header().Add("Content-Type", "application/xml")
		w.WriteHeader(http.StatusOK)
		xml.NewEncoder(w).Encode(customer)
	} else {
		w.Header().Add("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(customer)
	}
}
