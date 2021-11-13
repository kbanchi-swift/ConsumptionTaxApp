//
//  SumViewController.swift
//  ConsumptionTaxApp
//
//  Created by 伴地慶介 on 2021/11/06.
//

import UIKit

class SumViewController: UIViewController {

    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        sumLabel.text = ""
        var sum = 0.0
        
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "amounts") != nil {
            let amounts = userDefaults.object(forKey: "amounts") as! [String]
            for amount in amounts {
                sum = sum + Double(amount)!
            }
            sumLabel.text = String(sum)
        }
    }
    
    @IBAction func tapShareButton(_ sender: Any) {
//        showAlert(title: "Share", message: "share this consumption tax.")
        let shareText = "#スパルタキャンプやべぇ"
        let shareWebsite = NSURL(string: "http://hachimantai.spartacamp.jp/")!
        
        let activityItems = [shareText, shareWebsite] as [Any]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        let excludeActivityTypes = [
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.postToTwitter,
            UIActivity.ActivityType.message,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.print
        ]
        
        activityVC.excludedActivityTypes = excludeActivityTypes
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }

}
