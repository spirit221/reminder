import UIKit
class TableViewCell: UITableViewCell {
    @IBOutlet weak var remindName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func commonInit(title: String) {
        remindName.text = title
    }
}
