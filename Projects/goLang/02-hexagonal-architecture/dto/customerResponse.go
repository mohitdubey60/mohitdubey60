package dto

type CustomerResponse struct {
	Id          string `json:"id" xml:"id"`
	Name        string `json:"name" xml:"name"`
	City        string `json:"city" xml:"city"`
	DateOfBirth string `json:"date_of_birth" xml:"date_of_birth"`
	Zipcode     string `json:"zipcode" xml:"zipcode"`
	Status      string `json:"status" xml:"status"`
}
