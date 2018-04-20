import UIKit
class DetailReminder: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var time: UILabel!
    var labelName: String = ""
    var labelText: String = ""
    var labelTime: Date = Date()
    var indexSingle = 0
    var dateFromPicker: Date = Date()
    let stringEditor = StringEditor()
    let session = Session()
    let format = "d MMM yyyy г., HH:mm" //change
    let dateFormatter = DateFormatter()
    var flag: Int = 0
    weak var delegate: EditingReminderProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = labelName
        text.text = labelText
        dateFormatter.dateFormat = format
        time.text = dateFormatter.string(from: labelTime)
    }
    func commonInit(labelName: String, labelText: String, labelTime: Date, index: Int) {
        self.labelText = labelText
        self.labelTime = labelTime
        self.labelName = labelName
        indexSingle = index
    }
    @IBAction func editName(_ sender: Any) {
        labelName = name.text!
        guard !labelName.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        labelText = text.text ?? ""
        labelTime = dateFromPicker
        delegate?.editReminder(name: labelName, description: labelText, date: labelTime, indexOfReminders: indexSingle)
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
        time.text = dateFormatter.string(from: sender.date)
    }
    @IBAction func shareToVk(_ sender: UIButton) {
        postToVK()
    }
    @IBAction func photoButtom(_ sender: UIButton) {
        let viewPhoto = PhotoCollection(nibName: "PhotoCollection", bundle: nil)
        viewPhoto.commonInit(index: indexSingle)
        navigationController?.pushViewController(viewPhoto, animated: true)
    }
    func postToVK() {
        flag = session.getFlag()
        if flag == 0 {
            let vc = VkWall(nibName: "VkWall", bundle: nil)
            vc.commonInit(labelName: labelName, labelText: labelText, labelTime: labelTime)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let postVk = PostingVk()
            postVk.wall(name: self.labelName, text: self.labelText, time: self.labelTime)
        }
    }
}

protocol EditingReminderProtocol: class {
    func editReminder(name: String, description: String, date: Date, indexOfReminders: Int)
}
