package app

import (
	"strings"
)

type AppRoles struct {
	role map[string][]string
}

func GetRolePermissions() AppRoles {
	return AppRoles{map[string][]string{
		"admin": {GET_ALL_CUSTOMER, GET_CUSTOMER, NEW_ACCOUNT, NEW_TRANSACTION},
		"user":  {GET_CUSTOMER, NEW_TRANSACTION},
	}}
}
func (p AppRoles) IsAuthorizedFor(role string, routeName string) bool {
	perms := p.role[role]
	for _, r := range perms {
		if r == strings.TrimSpace(routeName) {
			return true
		}
	}
	return false
}
