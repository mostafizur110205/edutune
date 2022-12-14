//
//  ReferralVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 30/10/22.
//

import UIKit

class ReferralVC: UIViewController {
    
    @IBOutlet weak var imgViewTop: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblPointMessage: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var buttonTopRight: UIButton!
    @IBOutlet weak var buttonShare: UIButton!
    
    var referral: Referral?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonTopRight.tintColor = UIColor.orange
        getReferrals()
    }
    
    func getReferrals() {
        
        if AppUserDefault.getIsLoggedIn() {
            var params = [String: Any]()
            params["user_id"] = AppUserDefault.getUserId()
            APIService.shared.getReferrals(params: params, completion: {refData  in
                if let referralData = refData {
                    self.referral = referralData;
                    self.updateView()
                }
            })
        }
    }
    
    func updateView(){
        lblPointMessage.text = "You will get \(self.referral?.perSignupPoint ?? 0) points on every sign up"
        
    }
    
    
    @IBAction func btnCopy(_ sender: Any) {
        UIPasteboard.general.string = self.lblCode.text

    }
    
    @IBAction func topRightButtonAction(_ sender: Any) {
//        if let viewC: MyPointsVC = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "MyPointsVC") as? MyPointsVC {
//            self.navigationController?.pushViewController(viewC, animated: true)
//        }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let text = "Edutue app store url"
        let activityViewController = UIActivityViewController(activityItems: [ text ], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ReferralVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
