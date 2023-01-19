package main

import (
	"fmt"

	"hexagonal-architecture/app"
	"hexagonal-architecture/app/logger"
	"hexagonal-architecture/domain"
	"hexagonal-architecture/route"

	"github.com/gorilla/mux"
)

func main() {
	fmt.Println("This is hexagonal-architecture")
	logger.Shared().Init()

	router := mux.NewRouter()

	authMiddleware := domain.AppAuthMiddleware{
		Repo: domain.NewAuthRepository(),
	}
	router.Use(authMiddleware.AuthorizationHandler())

	route.SetupCustomerRouter(router)
	route.SetupAccountRouter(router)
	route.SetupTransactionRouter(router)

	app.StartServer(router)
}
