import Vapor
import HTTP

final class UserController: ResourceRepresentable {
    
    func index(request: Request) throws -> ResponseRepresentable {
//        return try User.find(1)!.converted(to: JSON.self)
        let db = User.database
        return try User.all().makeNode().converted(to: JSON.self)
    }

    func create(request: Request) throws -> ResponseRepresentable {
        var todo = try request.post()
        try todo.save()
        return todo
    }

    func show(request: Request, post: User) throws -> ResponseRepresentable {
        return post
    }

//    func delete(request: Request, post: User) throws -> ResponseRepresentable {
//        try post.delete()
//        return JSON([:])
//    }

    func clear(request: Request) throws -> ResponseRepresentable {
        try User.query().delete()
        return JSON([])
    }

//    func update(request: Request, post: User) throws -> ResponseRepresentable {
//        let new = try request.post()
//        var post = post
//        post.username = new.name
//        try post.save()
//        return post
//    }

//    func replace(request: Request, post: User) throws -> ResponseRepresentable {
//        try post.delete()
//        return try create(request: request)
//    }

    func makeResource() -> Resource<User> {
        return Resource(
            index: index,
            store: create,
            show: show,
//            replace: replace,
//            modify: update,
//            destroy: delete,
            clear: clear
        )
    }
}

extension Request {
    func post() throws -> User {
        guard let json = json else { throw Abort.badRequest }
        return try User(node: json)
    }
}
