package app

type AppRoles struct {
	role map[string][]string
}

func NewAppRole(user string) *AppRoles {
	return &AppRoles{
		role: map[string][]string{
			"admin": {GET_ALL_CUSTOMER, GET_CUSTOMER, NEW_ACCOUNT, NEW_TRANSACTION},
			"user":  {GET_CUSTOMER, NEW_TRANSACTION},
		},
	}
}
