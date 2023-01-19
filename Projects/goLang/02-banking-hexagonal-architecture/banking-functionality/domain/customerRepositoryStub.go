package domain

type CustomerRepositoryStub struct {
	Customers []Customer
}

func (s CustomerRepositoryStub) FindAll(status int) ([]Customer, error) {
	if status > 1 {
		return s.Customers, nil
	} else {
		var customers = make([]Customer, 0)
		for _, customer := range s.Customers {
			if customer.Status == customer.Status {
				customers = append(customers, customer)
			}
		}
		return customers, nil
	}
}
func (s CustomerRepositoryStub) ById(id string) (*Customer, error) {
	for _, customer := range s.Customers {
		if customer.Id == id {
			return &customer, nil
		}
	}

	return nil, nil
}

func instantiateCustomers() CustomerRepositoryStub {
	cusomers := []Customer{{Id: "1001", Name: "Mohit", City: "Bangalore", DateOfBirth: "20/03/1989", Zipcode: "560100", Status: "1"},
		{Id: "1002", Name: "Rohit", City: "Kanpur", DateOfBirth: "08/08/1985", Zipcode: "208010", Status: "1"}}
	cusomerStub := CustomerRepositoryStub{Customers: cusomers}

	return cusomerStub
}
func NewCustomerRepositoryStub() CustomerRepositoryStub {
	customerStub := instantiateCustomers()

	return customerStub
}
