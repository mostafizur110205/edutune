//
//  CheckoutVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 16/11/22.
//

import UIKit
import FittedSheets
import SSLCommerzSDK

class CheckoutVC: UIViewController {
    
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var coursePriceLabel: UILabel!
    @IBOutlet weak var promoLabel: UILabel!
    @IBOutlet weak var promoPriceLabel: UILabel!
    @IBOutlet weak var finalPriceLabel: UILabel!
    @IBOutlet weak var applyPromoButton: UIButton!
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var promoStackView: UIStackView!
   
    var classDetail: ClassDetail?
    
    var finalPrice = 0
    var couponCode = ""
    
    // get live payment credintials 
    //https://api.npoint.io/95352dec1b6a18eee2e8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        finalPrice = classDetail?.current_price ?? 0
        courseNameLabel.text = classDetail?.name
        coursePriceLabel.text = "৳\(classDetail?.current_price ?? 0)"
        promoStackView.isHidden = true
    }
    
    func applyPromo(_ code: String) {
        let params = ["coupon": code, "user_id": AppUserDefault.getUserId(), "class_id": classDetail?.id ?? -1, "current_price": classDetail?.current_price ?? 0] as [String: Any]
        APIService.shared.applyPromo(params: params) { coupon in
           
            if let coupon = coupon {
                self.finalPrice = coupon.set_cart_amount ?? 0
                self.couponCode = code
                self.promoStackView.isHidden = false
                self.promoLabel.text = coupon.discount_message
                self.promoPriceLabel.text = "৳\(coupon.discount ?? 0)"
                self.finalPriceLabel.text = "৳\(coupon.set_cart_amount ?? 0)"
                self.applyPromoButton.setTitle("Promo Applied", for: .normal)
            } else {
                self.finalPrice = self.classDetail?.current_price ?? 0
                self.couponCode = ""
                self.promoStackView.isHidden = true
                self.promoLabel.text = ""
                self.promoPriceLabel.text = ""
                self.finalPriceLabel.text = ""
                self.applyPromoButton.setTitle("Apply promo", for: .normal)
            }

        }
    }
    
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onContinueButtonTap(_ sender: Any) {
        showPaymentView()
    }
    
    @IBAction func inputPromo() {
        if let viewC: InputPromoVC = UIStoryboard(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "InputPromoVC") as? InputPromoVC {
            viewC.delegate = self
            let options = SheetOptions (
                shrinkPresentingViewController: false
            )
            let sheetController = SheetViewController(controller: viewC, sizes: [.fixed(232)], options: options)
            sheetController.didDismiss = { _ in
                print("Sheet dismissed")
                
            }
            sheetController.gripColor = UIColor(white: 0.5, alpha: 1)
            
            self.present(sheetController, animated: true, completion: nil)
        }
    }
    
    func showPaymentView(){
        
        let SSLCOMMERZ_SANDBOX_STORE_ID = "aitl620755582ff0b"
        let SSLCOMMERZ_SANDBOX_STORE_PASSWORD = "aitl620755582ff0b@ssl";
        
        let sslCom = SSLCommerz.init(integrationInformation: IntegrationInformation.init(storeID: SSLCOMMERZ_SANDBOX_STORE_ID, storePassword: SSLCOMMERZ_SANDBOX_STORE_PASSWORD, totalAmount: Double(finalPrice), currency: "BDT", transactionId: "\(classDetail?.id ?? -1)", productCategory: "1"))
        
        sslCom.customerInformation = CustomerInformation(customerName: AppDelegate.shared().user?.username ?? "", customerEmail: AppDelegate.shared().user?.email ?? "", customerAddressOne: "", customerCity: "", customerPostCode: "", customerCountry: "Bangladesh", customerPhone: AppDelegate.shared().user?.phone ?? "")
        
        sslCom.delegate = self
        sslCom.start(in: self, shouldRunInTestMode: true)
    }
    
    
    func purchaseCourse(_ transactionDetails: TransactionDetails?) {
        
        let val_A = "{\"is_successful\":\"true\",\"cid\":\"\(classDetail?.id ?? -1)\",\"pid\":\"4\",\"userId\":\"\(AppUserDefault.getUserId())\",\"iid\":\"206\"}"
        let params = [
            "APIConnect": transactionDetails?.apiConnect as Any,
            "amount": transactionDetails?.amount as Any,
            "bank_tran_id": transactionDetails?.bank_tran_id as Any,
            "base_fair": transactionDetails?.base_fair as Any,
            "card_brand": transactionDetails?.card_brand as Any,
            "card_issuer": transactionDetails?.card_issuer as Any,
            "card_issuer_country": transactionDetails?.card_issuer_country as Any,
            "card_issuer_country_code": transactionDetails?.card_issuer_country_code as Any,
            "card_no": transactionDetails?.card_no as Any,
            "card_type": transactionDetails?.card_type as Any,
            "currency_amount": transactionDetails?.currency_amount as Any,
            "currency_rate": transactionDetails?.currency_rate as Any,
            "currency_type": transactionDetails?.currency_type as Any,
            "gw_version": transactionDetails?.gw_version as Any,
            "risk_level": transactionDetails?.risk_level as Any,
            "risk_title": transactionDetails?.risk_title as Any,
            "sessionkey": transactionDetails?.sessionkey as Any,
            "status": transactionDetails?.status as Any,
            "store_amount": transactionDetails?.store_amount as Any,
            "tran_date": transactionDetails?.tran_date as Any,
            "tran_id": transactionDetails?.tran_id as Any,
            "val_id": transactionDetails?.val_id as Any,
            "validated_on": transactionDetails?.validated_on as Any,
            "value_a": val_A,
            "value_b": "",
            "value_c": self.couponCode,
            "value_d": transactionDetails?.value_d as Any
        ]
        
        APIService.shared.purchaseCourse(params: params) { success in
            if success {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
    }
    
}
extension CheckoutVC: SSLCommerzDelegate {
    func transactionCompleted(withTransactionData transactionData: TransactionDetails?){
        if transactionData?.status == "VALID" || transactionData?.status == "VALIDATED"{
            purchaseCourse(transactionData)
            print("Success")
        }else{
            print("Fained")
        }
    }
}


extension CheckoutVC: InputPromoVCDelegate {
    func didApplyButtonTap(_ code: String) {
        applyPromo(code)
    }
}
