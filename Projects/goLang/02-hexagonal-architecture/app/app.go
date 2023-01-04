package app

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

type Config struct {
	host string
	port string
}

const GET_ALL_CUSTOMER = "GET_ALL_CUSTOMER"
const GET_CUSTOMER = "GET_CUSTOMER"
const NEW_ACCOUNT = "NEW_ACCOUNT"
const NEW_TRANSACTION = "NEW_TRANSACTION"

// Start server at port
func StartServer(router *mux.Router) {
	config := Config{
		host: "localhost",
		port: "8000",
	}
	hostAndPort := fmt.Sprintf("%v:%v", config.host, config.port)

	//Start server at port
	log.Fatal(http.ListenAndServe(hostAndPort, router))
}
