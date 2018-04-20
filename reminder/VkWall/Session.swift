import Foundation

final class Session {
    func saveId(userId: String) {
        UserDefaults.standard.set(userId, forKey: "userId")
    }
    func saveToken(token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }
    func restoreID() -> String {
        let userId = UserDefaults.standard.value(forKey: "userId") as? String ?? ""
        return userId
    }
    func restoreToken() -> String {
        let token = UserDefaults.standard.value(forKey: "token") as? String ?? ""
        return token
    }
    func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: "\(key)")
    }
    func flag() {
        UserDefaults.standard.set(1, forKey: "flag")
    }
    func getFlag() -> Int {
        let unFlag = UserDefaults.standard.integer(forKey: "flag")
        return unFlag
    }
    func logOut () {
        let url = URL(string: Constants.URLs.logout)!
        self.remove(key: "userId")
        self.remove(key: "token")
        self.remove(key: "flag")
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { _, _, _  in }
        task.resume()
        WebCacheCleaner.clean()
    }
}
