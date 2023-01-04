package timezone

import "github.com/gorilla/mux"

func SetupTimezoneRouter(router *mux.Router) {
	//Routers
	router.HandleFunc("/timeZone", GetTimeZone)
}
