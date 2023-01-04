package booking

import (
	"encoding/json"
	"encoding/xml"
	"fmt"
	"net/http"

	"github.com/gorilla/mux"
)

type Customers struct {
	FirstName       string `json:"first_name" xml:"first_name"`
	LastName        string `json:"last_name"  xml:"last_name"`
	Email           string `json:"email_name" xml:"email_name"`
	NumberOfTickets uint   `json:"tickets"    xml:"tickets"`
}

const TotalBookingsCount uint = 50

func getCustomers() []Customers {
	// using slice
	var customers = []Customers{{FirstName: "Mohit", LastName: "Dubey", Email: "mkd@mkd.com", NumberOfTickets: 10}, {FirstName: "Rohit", LastName: "Dubey", Email: "rd@mkd.com", NumberOfTickets: 2}}
	// append helps to add a new value to slice
	customers = append(customers, Customers{FirstName: "Sohit", LastName: "Dubey", Email: "sd@mkd.com", NumberOfTickets: 5})
	return customers
}

func TotalBookings(w http.ResponseWriter, r *http.Request) {
	var returnString string = fmt.Sprintf("Total bookings count is %v", TotalBookingsCount)
	fmt.Fprint(w, returnString)
}

func AllCustomers(w http.ResponseWriter, r *http.Request) {

	customers := getCustomers()

	if r.Header.Get("Content-Type") == "application/xml" {
		w.Header().Add("Content-Type", "application/xml")
		xml.NewEncoder(w).Encode(customers)
	} else {
		w.Header().Add("Content-Type", "application/json")
		json.NewEncoder(w).Encode(customers)
	}
}

func GetCustomer(w http.ResponseWriter, r *http.Request) {
	customers := getCustomers()
	allVars := mux.Vars(r)
	customerEmail := allVars["customer_email"]

	var customer Customers

	for _, item := range customers {
		if item.Email == customerEmail {
			customer = item
		}
	}

	if customer != (Customers{}) {
		w.Header().Add("content-Type", "application/json")
		json.NewEncoder(w).Encode(customer)
	} else {
		fmt.Fprintf(w, "Customer not found")
	}
}
