import UIKit
import Foundation
class SaveData {
    private var reminders: [Reminder] = []
    func loadData() -> [Reminder] {
        if let data = UserDefaults.standard.value(forKey: "reminder") as? Data {
            do {
                reminders = try PropertyListDecoder().decode(Array<Reminder>.self, from: data)
            } catch {
                print(error)
            }
        }
        return reminders
    }
    func savingData(reminder: [Reminder]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(reminder), forKey: "reminder")
        UserDefaults.standard.synchronize()
    }
    func deletePhoto(key: Int) {
        let indexForSaving = UserDefaults.standard.value(forKey: "reminder\(key)") as? Int ?? 0
        for i in 10*key...10*key+indexForSaving {
            UserDefaults.standard.removeObject(forKey: "\(i)")
        }
        UserDefaults.standard.removeObject(forKey: "reminder\(key)")
    }
    func loadIndex(indexOfReminder: Int) -> Int {
        let indexForSaving = UserDefaults.standard.value(forKey: "reminder\(indexOfReminder)") as? Int ?? 0
        return indexForSaving
    }
    func loadPhoto(indexOfReminder: Int, indexForSaving: Int) -> [UIImage] {
        var objects: [UIImage] = []
        for i in 10*indexOfReminder...10*indexOfReminder+indexForSaving {
            if let imageData = UserDefaults.standard.value(forKey: "\(i)") as? Data {
                let imageFromData = UIImage(data: imageData)
                objects.append(imageFromData!)
            }
        }
        return objects
    }
    func savePhoto(iOfReminder: Int, forSaving: Int, chosenImage: UIImage) {
        UserDefaults.standard.set(UIImageJPEGRepresentation(chosenImage, 100), forKey: "\(10*iOfReminder+forSaving)")
    }
    func saveIndex(indexOfReminder: Int, indexForSaving: Int) {
        UserDefaults.standard.set(indexForSaving, forKey: "reminder\(indexOfReminder)")
    }
    func setGlobalIndex(index: Int) {
        UserDefaults.standard.set(index, forKey: "global")
    }
    func getGlobalIndex() -> Int {
        let index = UserDefaults.standard.value(forKey: "global") as? Int ?? 0
        return index
    }
}
