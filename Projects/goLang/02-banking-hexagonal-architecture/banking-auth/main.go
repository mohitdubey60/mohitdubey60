package main

import (
	"fmt"

	"banking-auth/app"
	"banking-auth/app/logger"
	"banking-auth/route"

	"github.com/gorilla/mux"
)

func main() {
	fmt.Println("This is banking-auth")
	logger.Shared().Init()

	router := mux.NewRouter()

	route.SetupUserLoginRouter(router)

	app.StartServer(router)
}
