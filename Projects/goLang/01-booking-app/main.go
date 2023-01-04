package main

import (
	"fmt"

	"github.com/gorilla/mux"

	"booking-app/app"
	"booking-app/booking"
	"booking-app/timezone"
)

const totalBookingsCount uint = 50

func main() {
	fmt.Println("Go app starts here...")
	router := mux.NewRouter()

	//Setup routers
	booking.SetupBookingRouter(router)
	timezone.SetupTimezoneRouter(router)

	//Start server at port
	app.StartServer(router)
}
