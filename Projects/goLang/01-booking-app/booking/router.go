package booking

import (
	"net/http"

	"github.com/gorilla/mux"
)

func SetupBookingRouter(router *mux.Router) {
	//Routers
	router.HandleFunc("/totalBookings", TotalBookings).Methods(http.MethodGet)
	router.HandleFunc("/allCustomers", AllCustomers).Methods(http.MethodGet)
	router.HandleFunc("/allCustomers/{customer_email}", GetCustomer).Methods(http.MethodGet)
}
