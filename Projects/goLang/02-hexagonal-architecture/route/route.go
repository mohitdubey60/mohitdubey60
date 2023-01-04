package route

import (
	"hexagonal-architecture/app"
	"hexagonal-architecture/domain"
	"hexagonal-architecture/service"
	"net/http"

	"github.com/gorilla/mux"
)

func SetupCustomerRouter(router *mux.Router) {
	//Mock repo
	// customerHandler := CustomerHandler{
	// 	service: service.NewCustomerService(
	// 		domain.NewCustomerRepositoryStub())}

	//Repo from DB
	customerHandler := CustomerHandler{
		service: service.NewCustomerService(
			domain.NewCustomerRepositoryDB())}

	//Routers
	router.HandleFunc("/allCustomers", customerHandler.GetAllCustomers).
		Methods(http.MethodGet).
		Name(app.GET_ALL_CUSTOMER)

	router.HandleFunc("/allCustomers/{customer_id:[0-9]+}", customerHandler.GetCustomers).
		Methods(http.MethodGet).
		Name(app.GET_CUSTOMER)
}

func SetupAccountRouter(router *mux.Router) {
	//Repo from DB
	accountHandler := AccountHandler{
		service: service.DefaultAccountService{
			Repo: domain.NewAccountRepositoryDB(),
		},
	}

	//Routers
	router.HandleFunc("/allCustomers/{customer_id:[0-9]+}/newaccount", accountHandler.CreateAccount).
		Methods(http.MethodPost).
		Name(app.NEW_ACCOUNT)
}

func SetupTransactionRouter(router *mux.Router) {
	//Repo from DB
	transactionHandler := TransactionHandler{
		service: service.DefaultTransactionService{
			Repo: domain.NewTransactionRepositoryDB(),
		},
	}

	//Routers
	router.HandleFunc("/transactions/{account_id:[0-9]+}/new", transactionHandler.NewTransaction).
		Methods(http.MethodPost).
		Name(app.NEW_TRANSACTION)
}

func SetupUserLoginRouter(router *mux.Router) {
	//Repo from DB
	userLoginHandler := UserLoginHandler{
		service: service.DefaultUserLoginService{
			Repo: domain.NewUserLoginRepositryDB(),
		},
	}

	//Routers
	router.HandleFunc("/auth/login", userLoginHandler.ValidateUser).Methods(http.MethodPost)
}
