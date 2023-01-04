package dto

type TransactionRequest struct {
	AccountId string  `json:"account_id"`
	Amount    float64 `json:"amount"`
	Type      string  `json:"transaction_type"`
	Date      string  `json:"transaction_date"`
}
