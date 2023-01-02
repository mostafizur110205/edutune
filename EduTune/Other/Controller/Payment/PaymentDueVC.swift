//
//  PaymentDueVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 26/12/22.
//

import UIKit

class PaymentDueVC: UIViewController {

    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet var tableView: UITableView!

    @IBOutlet weak var totalDueHeaderLabel: UILabel!
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var fineLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    var dueFees: DueFees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDueFees()

    }
    
    func getDueFees() {
        let params = ["user_id": AppUserDefault.getUserId()]
        APIService.shared.getDuePayment(params: params, completion: { dueFees in
            self.tableView.isHidden = false
            self.dueFees = dueFees
            self.updateUI()
        })
    }
    
    func updateUI() {
        
        let subTotal = (dueFees?.total_due ?? 0) - (dueFees?.total_paid ?? 0)
        let total = subTotal - (dueFees?.discount ?? 0) + (dueFees?.fine ?? 0)
        
        totalDueHeaderLabel.text = "\(total)"
       
        subtotalLabel.text = "\(subTotal)"
        fineLabel.text = "\(self.dueFees?.fine ?? 0)"
        discountLabel.text = "\(self.dueFees?.discount ?? 0)"
        totalLabel.text = "\(total)"
        
        tableView.reloadData()

    }

    @IBAction func onPaymentButtonTap(_ sender: Any) {
   
    }
    
}

extension PaymentDueVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dueFees?.fees_heads.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "DueFeesTVCell") as? DueFeesTVCell else {return UITableViewCell()}
        
        cell.head = dueFees?.fees_heads[indexPath.row]
        
        return cell
        
    }
    
}
