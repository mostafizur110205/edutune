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
    
    @IBOutlet weak var tutionFeesDueLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var fineLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    var dueFees = [DueFees]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
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
        totalDueHeaderLabel.text = self.dueFees.first?.total_due_amount
       
        tutionFeesDueLabel.text = self.dueFees.first?.total_due_amount
        subtotalLabel.text = self.dueFees.first?.total_due_amount
        fineLabel.text = self.dueFees.first?.total_fine_due
        discountLabel.text = self.dueFees.first?.total_discount
        totalLabel.text = self.dueFees.first?.total_due_amount

    }

    @IBAction func onPaymentButtonTap(_ sender: Any) {
   
    }
    
}
