import Vapor
import Console

let drop = Droplet()

drop.get { req in
    let lang = "en"
    return try drop.view.make("welcome", [
    	"message": Node.string(drop.localization[lang, "welcome", "title"])
    ])
}

drop.resource("posts", PostController())

drop.run()
