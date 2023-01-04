package main

import (
	"fmt"

	"hexagonal-architecture/app"
	"hexagonal-architecture/app/logger"
	"hexagonal-architecture/route"

	"github.com/gorilla/mux"
)

func main() {
	fmt.Println("This is hexagonal-architecture")
	logger.Shared().Init()

	router := mux.NewRouter()

	route.SetupCustomerRouter(router)
	route.SetupAccountRouter(router)
	route.SetupTransactionRouter(router)
	route.SetupUserLoginRouter(router)

	app.StartServer(router)
}
