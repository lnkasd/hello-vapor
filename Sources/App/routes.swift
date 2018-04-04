import Routing
import Vapor
import Foundation

public func routes(_ router: Router) throws {

    router.get("hello") { req in
        return "Hello, vapor!"
    }

    router.get("hello", String.parameter) { req -> String in
        let name = try req.parameter(String.self)
        return "Hello \(name)"
    }

    router.get("date") { req in
        return Date().description
    }

    router.get("counter", Int.parameter) { req -> CountJson in
        let count = try req.parameter(Int.self)
        return CountJson(count: count)
    }

    router.post(User.self, at: "user") { req, user -> UserJsonResponse in
        return UserJsonResponse(user: user)
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

/// 
struct User: Content {
    let name: String
}

struct UserJsonResponse: Content {
    let user: User
}

struct CountJson: Content {
    let count: Int
}



