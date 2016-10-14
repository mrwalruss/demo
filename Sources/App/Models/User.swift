import Vapor
import Fluent

final class User: Model {

    var exists: Bool = false
    static var entity: String = "user"

    var id: Node?
    var userid: Int
    var username: String

    init(userid: Int, username: String) {
        self.userid = userid
        self.username = username
    }

    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        userid = try node.extract("userid")
        username = try node.extract("username")
    }

    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "userid": userid,
            "username": username
            ])
    }

}

extension User: Preparation {
    static func prepare(_ database: Database) throws {
        try? database.create(entity) { users in
            users.id()
            users.int("userid")
            users.string("username")
        }
    }

    static func revert(_ database: Database) throws {
        try database.delete(entity)
    }
}
