import Foundation
struct Reminder: Codable {
    let nameOfReminder: String
    let textOfReminder: String
    let timeOfReminder: Date
    let indexGlobalReminder: Int
    init(name: String, text: String, time: Date, indexGlobal: Int) {
        self.nameOfReminder = name
        self.textOfReminder = text
        self.timeOfReminder = time
        self.indexGlobalReminder = indexGlobal
    }

}
