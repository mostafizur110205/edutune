//
//  ClassDetailsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 22/10/22.
//

import UIKit
import SJSegmentedScrollView
import UICollectionViewLeftAlignedLayout
//import SSLCommerzSDK

class ClassDetailsVC: SJSegmentedViewController {

    @IBOutlet weak var enrolButton: UIButton!
    @IBOutlet weak var featureCV: UICollectionView!

    var selectedSegment: SJSegmentTab?
    var selectedSegmentIndex: Int = 0
    
    var classDetail: ClassDetail?
    var features = [Feature]()

    var transactionId: String?
    
    override func viewDidLoad() {
        guard let viewC = UIStoryboard(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "ClassAboutVC") as? ClassAboutVC else {return}
        viewC.title = "About"
        viewC.classDetail = self.classDetail

        guard let viewC2 = UIStoryboard(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "ClassLessonsVC") as? ClassLessonsVC else {return}
        viewC2.title = "Lessons"
        viewC2.classDetail = self.classDetail

        guard let viewC3 = UIStoryboard(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "ClassReviewsVC") as? ClassReviewsVC else {return}
        viewC3.title = "Reviews"
        viewC3.classDetail = self.classDetail

        guard let headerVC = UIStoryboard(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "ClassHeaderVC") as? ClassHeaderVC else {return}
        headerVC.classDetail = self.classDetail

        headerViewController = headerVC
        segmentControllers = [viewC, viewC2, viewC3]
        
        let cvHeight = getCollectionViewHeight()
        let imageHeight = ScreenSize.SCREEN_WIDTH/1.5
        
        print(cvHeight)

        headerViewHeight = imageHeight+cvHeight+164
        segmentViewHeight = 48
        segmentShadow = .light()
        selectedSegmentViewHeight = 2
        selectedSegmentViewColor = UIColor.init(hex: "335EF7", alpha: 1)
        segmentTitleColor = UIColor.init(hex: "9E9E9E", alpha: 1)
        segmentTitleFont = UIFont.urbanist(style: .semiBold, ofSize: 18)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        headerViewOffsetHeight = AppDelegate.shared().topInset
        segmentBackgroundColor = .clear
        segmentedScrollViewColor = .white
        
        delegate = self
        
        super.viewDidLoad()
        
        self.view.bringSubviewToFront(enrolButton)
        self.enrolButton.setTitle("Enroll Course - ৳\(classDetail?.current_price ?? 0)", for: .normal)
    }
    
    func getCollectionViewHeight() -> CGFloat {
        
        featureCV.delegate = self
        featureCV.dataSource = self
        
        let layout = UICollectionViewLeftAlignedLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        featureCV.collectionViewLayout = layout
        
        features = classDetail?.get_features ?? []
        return featureCV.collectionViewLayout.collectionViewContentSize.height
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func onEnrolButtonTap(_ sender: Any) {
        showPaymentView()
    }
    
    func showPaymentView(){
        
//        let SSLCOMMERZ_SANDBOX_STORE_ID = "aitl620755582ff0b"
//        let SSLCOMMERZ_SANDBOX_STORE_PASSWORD = "aitl620755582ff0b@ssl";
//
//        let sslCom = SSLCommerz.init(integrationInformation: IntegrationInformation.init(storeID: SSLCOMMERZ_SANDBOX_STORE_ID, storePassword: SSLCOMMERZ_SANDBOX_STORE_PASSWORD, totalAmount: Double(classDetail?.current_price ?? 0), currency: "BDT", transactionId: "\(classDetail?.id ?? -1)", productCategory: "1"))
//
//        sslCom.customerInformation = CustomerInformation(customerName: AppDelegate.shared().user?.username ?? "", customerEmail: AppDelegate.shared().user?.email ?? "", customerAddressOne: "", customerCity: "", customerPostCode: "", customerCountry: "Bangladesh", customerPhone: AppDelegate.shared().user?.phone ?? "")
//
//        sslCom.delegate = self
//        sslCom.start(in: self, shouldRunInTestMode: true)
    }
    
//    func purchaseCourse(_ transactionDetails: TransactionDetails?) {
//
//        let val_A = "{\"is_successful\":\"true\",\"cid\":\"\(classDetail?.id ?? -1)\",\"pid\":\"4\",\"userId\":\"\(AppUserDefault.getUserId())\",\"iid\":\"206\"}"
//        let params = [
//            "APIConnect": transactionDetails?.apiConnect as Any,
//            "amount": transactionDetails?.amount as Any,
//            "bank_tran_id": transactionDetails?.bank_tran_id as Any,
//            "base_fair": transactionDetails?.base_fair as Any,
//            "card_brand": transactionDetails?.card_brand as Any,
//            "card_issuer": transactionDetails?.card_issuer as Any,
//            "card_issuer_country": transactionDetails?.card_issuer_country as Any,
//            "card_issuer_country_code": transactionDetails?.card_issuer_country_code as Any,
//            "card_no": transactionDetails?.card_no as Any,
//            "card_type": transactionDetails?.card_type as Any,
//            "currency_amount": transactionDetails?.currency_amount as Any,
//            "currency_rate": transactionDetails?.currency_rate as Any,
//            "currency_type": transactionDetails?.currency_type as Any,
//            "gw_version": transactionDetails?.gw_version as Any,
//            "risk_level": transactionDetails?.risk_level as Any,
//            "risk_title": transactionDetails?.risk_title as Any,
//            "sessionkey": transactionDetails?.sessionkey as Any,
//            "status": transactionDetails?.status as Any,
//            "store_amount": transactionDetails?.store_amount as Any,
//            "tran_date": transactionDetails?.tran_date as Any,
//            "tran_id": transactionDetails?.tran_id as Any,
//            "val_id": transactionDetails?.val_id as Any,
//            "validated_on": transactionDetails?.validated_on as Any,
//            "value_a": val_A,
//            "value_b": "",
//            "value_c": "",
//            "value_d": transactionDetails?.value_d as Any
//        ]
//
//        APIService.shared.purchaseCourse(params: params) { success in
//
//        }
//    }
    
}

//extension ClassDetailsVC: SSLCommerzDelegate {
//    func transactionCompleted(withTransactionData transactionData: TransactionDetails?){
//        if transactionData?.status == "VALID" || transactionData?.status == "VALIDATED"{
//            purchaseCourse(transactionData)
//            print("Success")
//        }else{
//            print("Fained")
//        }
//    }
//}



extension ClassDetailsVC: SJSegmentedViewControllerDelegate {
    
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        if !segments.isEmpty {
            
            selectedSegment?.titleColor(UIColor.init(hex: "9E9E9E", alpha: 1))

            selectedSegment = segments[index]
            
            selectedSegment?.titleColor(UIColor.init(hex: "335EF7", alpha: 1))
            
            if index != selectedSegmentIndex {
                selectedSegmentIndex = index
            }
        }
    }
}

extension ClassDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return features.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CategoryCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVCell", for: indexPath) as? CategoryCVCell else {return UICollectionViewCell()}
        let category = (features[indexPath.item].name ?? "") + ": " + (features[indexPath.item].value ?? "")
        cell.tagNameLabel.text = category
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var textWidth: CGFloat = 0.0
        let text = (features[indexPath.item].name ?? "") + ": " + (features[indexPath.item].value ?? "")
        textWidth = text.widthWithConstrainedHeight(height: 26, font: UIFont.urbanist(style: .medium, ofSize: 16)) + 38
        return CGSize(width: textWidth, height: 26)
    }
    
}

