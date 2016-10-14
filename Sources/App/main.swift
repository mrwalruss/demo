import Vapor
import Console
import VaporMySQL

if let mysql = try? VaporMySQL.Provider(host: "localhost", user: "root", password: "", database: "dba") {
    let drop = Droplet(
        environment: .development,
        preparations: [User.self],
        providers: [VaporMySQL.Provider]
    )

    drop.get("hello") { req in
        let db = drop.database
        let lang = "en"
        return try drop.view.make("welcome", [
            "message": Node.string("\(drop.localization[lang, "welcome", "title"])</br>\(db?.driver)")
        ])
    }

    drop.resource("user", UserController())

    drop.run()
}
