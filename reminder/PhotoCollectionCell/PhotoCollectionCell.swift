import UIKit
class PhotoCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func commonInit(image: UIImage) {
        imageView.image = image
    }
}
