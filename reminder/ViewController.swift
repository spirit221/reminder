import UIKit
import UserNotifications
import WebKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    private var reminders: [Reminder] = []
    let push = Push()
    let saveData = SaveData()
    let session = Session()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My reminders"
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationController?.delegate = self
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "tableViewCell")
        reminders = saveData.loadData()
        reminders.sort { $0.indexGlobalReminder < $1.indexGlobalReminder }
        push.registerPush()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reminders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell
        cell?.commonInit(title: reminders[indexPath.item].nameOfReminder)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailReminder = DetailReminder()
        detailReminder.delegate = self
        detailReminder.commonInit(labelName: reminders[indexPath.item].nameOfReminder,
                                  labelText: reminders[indexPath.item].textOfReminder,
                                  labelTime: reminders[indexPath.item].timeOfReminder,
                                  index: reminders[indexPath.item].indexGlobalReminder)
        self.navigationController?.pushViewController(detailReminder, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func logout(_ sender: UIBarButtonItem) {
        session.logOut()
    }
    @IBAction func addButton(_ sender: UIButton) {
        let addReminder = AddReminder()
        addReminder.delegate = self
        let transition = CATransition()
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(addReminder, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit edit: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let constDelete: UITableViewCellEditingStyle = .delete
        if edit == constDelete {
            saveData.deletePhoto(key: reminders[indexPath.row].indexGlobalReminder)
            saveData.savingData(reminder: reminders)
            push.deletePush(identifier: "\(reminders[indexPath.row].indexGlobalReminder)")
            reminders.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .middle)
            tableView.endUpdates()
        }
    }
}
extension ViewController: TextChangeProtocol {
    func textChange(valueName: String, valueDescription: String, valueDate: Date) {
        saveData.setGlobalIndex(index: saveData.getGlobalIndex() + 1)
        let globalIndex = saveData.getGlobalIndex()
        reminders.append(Reminder(name: valueName, text: valueDescription, time: valueDate, indexGlobal: globalIndex))
        reminders.sort { $0.indexGlobalReminder < $1.indexGlobalReminder }
        tableView.reloadData()
        saveData.savingData(reminder: reminders)
        push.sendPush(name: valueName, description: valueDescription, date: valueDate, identifier: "\(globalIndex)")
    }
}
extension ViewController: EditingReminderProtocol {
    func editReminder(name: String, description: String, date: Date, indexOfReminders: Int) {
        let indexForRemoving = reminders.index { $0.indexGlobalReminder == indexOfReminders}
        if let indexForRemoving = indexForRemoving {
            reminders.remove(at: indexForRemoving)
        }
        reminders.append(Reminder(name: name, text: description, time: date, indexGlobal: indexOfReminders))
        reminders.sort { $0.indexGlobalReminder < $1.indexGlobalReminder }
        tableView.reloadData()
        saveData.savingData(reminder: reminders)
        push.sendPush(name: name, description: description, date: date, identifier: "\(indexOfReminders)")
    }
}
extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
}
