import UIKit
class AddReminder: UIViewController {
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldDescription: UITextField!
    @IBOutlet weak var textFieldDate: UILabel!
    var dateFromPicker =  Date()
    weak var delegate: TextChangeProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func addReminderButton(_ sender: UIButton) {
        guard let textName = textFieldName.text, !textName.trimmingCharacters(in: .whitespaces).isEmpty else {
            let message = Constants.URLs.message
            let pulse = Constants.URLs.pulse
            let alert = UIAlertController(title: pulse, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let textDescription = textFieldDescription.text ?? ""
        delegate?.textChange(valueName: textName, valueDescription: textDescription, valueDate: dateFromPicker)
        navigationController?.popViewController(animated: true)
    }
    func closekeyboard() {
        self.view.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closekeyboard()
    }
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFromPicker = sender.date
        textFieldDate.text = dateFormatter.string(from: sender.date)
    }
}
protocol TextChangeProtocol: class {
    func textChange(valueName: String, valueDescription: String, valueDate: Date)
}
