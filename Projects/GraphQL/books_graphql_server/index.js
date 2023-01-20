const { ApolloServer, gql } = require("apollo-server")

const books = [
    {
        id: 1,
        title: "Atomic Habits: An Easy & Proven Way to Build Good Habits & Break Bad Ones",
        author: "James Clear"
    },
    {
        id: 2,
        title: "Hyperfocus: How to Work Less to Achieve More",
        author: "Chris Bailey"
    }
];

const typeDefs = gql`
type Book {
    id: ID!
    title: String!
    author: String
}

type Query {
    books: [Book]
    book(id: ID!): Book
}

type Mutation {
    addBook(title: String, author: String): Book
}
`

const resolvers = {
    Query: {
        books: () => books,
        //book: (parent, args, context, info) => books.find(book => book.id == args.id)
        //above line can be also written as 
        book: (_, {id}) => books.find(book => book.id == id)
    },
    Mutation: {
        addBook: (_, {title, author}) => {
            const book = {
                id: books.length + 1,
                title: title,
                author: author
            }
            books.push(book)
            return book
        }
    }
}

const server = new ApolloServer({typeDefs, resolvers});
server.listen().then(({url}) => {
    console.log(`server is running at ${url}`)
});