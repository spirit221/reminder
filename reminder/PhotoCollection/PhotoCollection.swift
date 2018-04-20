import UIKit
class PhotoCollection: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var cView: UICollectionView!
    let cellID = "photoCollectionCell"
    var objects: [UIImage] = []
    var indexOfReminder = 0
    var indexForSaving = 0
    let imagePicker = UIImagePickerController()
    let saveData = SaveData()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cView.register(UINib(nibName: "PhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        self.cView.delegate = self
        self.cView.dataSource = self
        imagePicker.delegate = self
        indexForSaving = saveData.loadIndex(indexOfReminder: indexOfReminder)
        objects = saveData.loadPhoto(indexOfReminder: indexOfReminder, indexForSaving: indexForSaving)
    }
    func commonInit(index: Int) {
        indexOfReminder = index
    }
    func collectionView(_ cView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    func collectionView(_ cView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? PhotoCollectionCell
        cell?.commonInit(image: objects[indexPath.item])
        return cell!
    }
    func collectionView(_ cView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let justPhoto = JustPhoto()
        justPhoto.commonInit(image: objects[indexPath.item])
        self.navigationController?.pushViewController(justPhoto, animated: true)
    }
    @IBAction func addPhoto(_ sender: UIButton) {
        guard indexForSaving < 5 else {
            let pulsar = Constants.URLs.pulsar
            let alertString = Constants.URLs.alertStr
            let alert = UIAlertController(title: pulsar, message: alertString,
                                          preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func openCamera() {
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    func openGallary() {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage ?? #imageLiteral(resourceName: "picture1")
        objects.append(chosenImage)
        saveData.savePhoto(iOfReminder: indexOfReminder, forSaving: indexForSaving, chosenImage: chosenImage)
        indexForSaving += 1
        saveData.saveIndex(indexOfReminder: indexOfReminder, indexForSaving: indexForSaving)
        cView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
