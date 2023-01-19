package route

import (
	"banking-auth/app"
	"banking-auth/app/logger"
	"banking-auth/domain"
	"banking-auth/service"
	"encoding/json"
	"net/http"

	"github.com/gorilla/mux"
)

func SetupUserLoginRouter(router *mux.Router) {
	//Repo from DB
	userLoginHandler := UserLoginHandler{
		service: service.DefaultUserLoginService{
			Repo:            domain.NewUserLoginRepositryDB(),
			RolePermissions: app.GetRolePermissions(),
		},
	}

	//Routers
	router.HandleFunc("/auth/login", userLoginHandler.ValidateUser).
		Methods(http.MethodPost)

	router.HandleFunc("/auth/verify", userLoginHandler.Verify).
		Methods(http.MethodGet)
}

func writeResponse(w http.ResponseWriter, code int, data interface{}) {
	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(code)
	if err := json.NewEncoder(w).Encode(data); err != nil {
		logger.Shared().Logger.Error("writeResponse Reached panic. " + err.Error())
		panic(err)
	}
}
