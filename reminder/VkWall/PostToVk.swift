import Foundation
class PostingVk {
    let session = Session()
    let stringEditor = StringEditor()
    func wall (name: String, text: String, time: Date) {
        let token = session.restoreToken()
        let userID = session.restoreID()
        let nameOfReminder = stringEditor.removeSpases(str: name, offset: 0)
        let description = stringEditor.removeSpases(str: text, offset: 0)
        let timeOfReminder = stringEditor.removeSpases(str: "\(time)", offset: -4)
        let forget = Constants.URLs.forget
        let strTime = Constants.URLs.strTime
        let wallPost = Constants.URLs.wallPost
        let textTime = "\(forget)+\(nameOfReminder)+%0ADescription:+\(description)+\(strTime)+\(timeOfReminder)"
        guard let urlWall = URL(string: "\(wallPost)=\(userID)&access_token=\(token)&message=\(textTime)") else {
            return
        }
        let urlRequest = URLRequest(url: urlWall)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, _  in
            print(String(describing: data))
        }
        task.resume()
    }
}
