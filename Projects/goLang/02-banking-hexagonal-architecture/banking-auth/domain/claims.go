package domain

import (
	"fmt"
	"time"

	"github.com/golang-jwt/jwt/v4"
)

type AccessTokenClaims struct {
	CustomerId string   `json:"customer_id"`
	Accounts   []string `json:"accounts"`
	Username   string   `json:"username"`
	Role       string   `json:"role"`
	Expiry     int64    `json:"exp"`
	jwt.StandardClaims
}

func (c AccessTokenClaims) IsUserRole() bool {
	return c.Role == "user"
}
func (c AccessTokenClaims) IsValidCustomerId(customerId string) bool {
	return c.CustomerId == customerId
}
func (c AccessTokenClaims) IsRequestVerifiedWithTokenClaims(urlParams map[string]string) bool {
	currentTime := time.Now().Unix()
	fmt.Printf("Expiry for token %v is %v, current time %v is %v\n", c.Expiry, conertUnixTimeToReadable(c.Expiry), currentTime, conertUnixTimeToReadable(currentTime))

	if c.Expiry < currentTime {
		return false
	}

	if c.CustomerId != urlParams["customer_id"] {
		return false
	}

	if !c.IsValidAccountId(urlParams["account_id"]) {
		return false
	}
	return true
}
func (c AccessTokenClaims) IsValidAccountId(accountId string) bool {
	if accountId != "" {
		accountFound := false
		for _, a := range c.Accounts {
			if a == accountId {
				accountFound = true
				break
			}
		}
		return accountFound
	}
	return true
}
func conertUnixTimeToReadable(unixTime int64) string {
	unixTimeUTC := time.Unix(unixTime, 0) //gives unix time stamp in utc
	unitTimeInRFC3339 := unixTimeUTC.Format("2006-01-02 15:04:05")
	return unitTimeInRFC3339
}
