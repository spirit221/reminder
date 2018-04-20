//
//  VkWall.swift
//  reminder
import UIKit
class VkWall: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    var labelName: String = ""
    var labelText: String = ""
    var labelTime: Date = Date()
    let stringEditor = StringEditor()
    let session = Session()
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        let url = URL(string: Constants.URLs.login)!
        let urlRequest = URLRequest(url: url)
        webView.loadRequest(urlRequest)
    }
    func commonInit(labelName: String, labelText: String, labelTime: Date) {
        self.labelText = labelText
        self.labelTime = labelTime
        self.labelName = labelName
    }
    func webView(_ webView: UIWebView,
                 shouldStartLoadWith request: URLRequest,
                 navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.url, let host = url.host,
            let ref = url.fragment, host == "oauth.vk.com" else {
                return true
        }
        let userId = stringEditor.takeAndCut(str: ref, separated: 3, offset: -6)
        let token = stringEditor.takeAndCut(str: ref, separated: 1, offset: -11)
        session.saveToken(token: token)
        session.saveId(userId: userId)
        session.flag()
        let detailReminder = DetailReminder(nibName: "DetailReminder", bundle: nil)
        detailReminder.commonInit(labelName: labelName, labelText: labelText, labelTime: labelTime, index: 0)
        detailReminder.postToVK()
        navigationController?.popViewController(animated: true)
        return false
    }
}
