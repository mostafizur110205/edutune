//
//  PaymentPaidVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 26/12/22.
//

import UIKit

class PaymentPaidVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var invoices = [Invoice]()
    
    var currentPage = 1
    var lastPage = 1
    var isAPICalling: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getPaidFees(page: currentPage)
        
    }
    
    func getPaidFees(page: Int) {
        if isAPICalling {
            return
        }
        let params = ["user_id": AppUserDefault.getUserId()]
        
        isAPICalling = true
        APIService.shared.getPaidPayment(page: page, params: params, completion: { invoices, currentPage, lastPage in
            
            self.currentPage = currentPage
            self.lastPage = lastPage
            
            self.isAPICalling = false
            
            if page == 1 {
                self.invoices = invoices
            } else {
                self.invoices += invoices
            }
            
            self.tableView.reloadData()
        })
    }
}

extension PaymentPaidVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoices.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "InvoiceTVCell") as? InvoiceTVCell else {return UITableViewCell()}
        
        cell.invoice = invoices[indexPath.row]
        
        if indexPath.row == invoices.count-1 && currentPage < lastPage {
            getPaidFees(page: currentPage + 1)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
