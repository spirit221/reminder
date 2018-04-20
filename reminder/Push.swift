import Foundation
import UserNotifications
class Push {
    func registerPush() {
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { (granted, _) in
            if !granted {
                print("Something went wrong")
            }
        }
    }
    func sendPush(name: String, description: String, date: Date, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = name
        content.subtitle = "Don't forget"
        content.body = description
        content.sound = UNNotificationSound.default()
        let trigDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second ], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: trigDate, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    func deletePush(identifier: String) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notifyRequests) in
            var identifiers: [String] = []
            for notification: UNNotificationRequest in notifyRequests where notification.identifier == identifier {
                identifiers.append(notification.identifier)
            }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
        }
    }
}
