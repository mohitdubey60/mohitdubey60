package dto

type AccountRequest struct {
	CustomerId string  `json:"customer_id" xml:"customer_id"`
	Amount     float64 `json:"amount" xml:"amount"`
	Type       string  `json:"account_type" xml:"account_type"`
}
