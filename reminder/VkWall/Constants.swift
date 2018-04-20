import Foundation
struct Constants {
    struct URLs {
        static let login = "\(host)?client_id=6325448&scope=\(rights1)\(rights2)&response_type=token"
        static let host = "https://oauth.vk.com/authorize"
        static let rights1 = "photos,audio,video,docs,notes,pages,status,offers,questions,wall,"
        static let rights2 = "groups,messages,email,notifications,stats,ads,offline,docs,pages,stats,notifications"
        static let logout = "http://api.vk.com/oauth/logout"
        static let forget = "Don't+forget+about"
        static let strTime = "%0ADate+and+time:"
        static let wallPost = "https://api.vk.com/method/wall.post?owner_id"
        static let message = "Try again without something empty"
        static let pulse = "Alert"
        static let pulsar = "Alert"
        static let alertStr = "It's a reminder, not a photo gallery"
    }
}
