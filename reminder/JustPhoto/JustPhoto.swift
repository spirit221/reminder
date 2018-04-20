import UIKit
class JustPhoto: UIViewController {
    @IBOutlet weak var justPhotoView: UIImageView?
    var justImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.justPhotoView?.image = justImage
    }
    func commonInit(image: UIImage) {
        justImage = image
    }
}
