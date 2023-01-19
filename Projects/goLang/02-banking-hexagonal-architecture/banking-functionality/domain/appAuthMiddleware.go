package domain

import (
	"encoding/json"
	"hexagonal-architecture/app"
	"net/http"
	"strings"

	"github.com/gorilla/mux"
)

type AppAuthMiddleware struct {
	Repo UserAuthRepository
}

func (s AppAuthMiddleware) AuthorizationHandler() func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			currentRoute := mux.CurrentRoute(r)
			currentRouteVars := mux.Vars(r)
			authHeader := r.Header.Get("Authorization")

			token := getTokenFromHeader(authHeader)
			if authHeader != "" && token != "" {
				isAuthorized := s.Repo.IsAuthorized(token, currentRoute.GetName(), currentRouteVars)

				if isAuthorized {
					next.ServeHTTP(w, r)
				} else {
					appError := app.AppError{Code: http.StatusForbidden, Message: "Unauthorized"}
					writeResponse(w, appError.Code, appError.Message)
				}
			} else {
				appError := app.AppError{Code: http.StatusUnauthorized, Message: "missing token"}
				writeResponse(w, appError.Code, appError.Message)
			}
		})
	}
}
func getTokenFromHeader(header string) string {
	/*
		token is coming in the format as below
		"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2NvdW50cyI6W.yI5NTQ3MCIsIjk1NDcyIiw"
	*/
	splitToken := strings.Split(header, "Bearer")
	if len(splitToken) == 2 {
		return strings.TrimSpace(splitToken[1])
	}
	return ""
}
func writeResponse(w http.ResponseWriter, code int, data interface{}) {
	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(code)
	if err := json.NewEncoder(w).Encode(data); err != nil {
		panic(err)
	}
}
