//
//  QuestionFourTVC.swift
//  EduTune
//
//  Created by DH on 18/12/22.
//

import UIKit

class QuestionFourTVC: UITableViewCell {
    
    var viewModel: AssignmentsViewModel?
    var viewController: AssignmentsVC?
    
    let tableView: InnerTableView = {
        let tableView = InnerTableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white
        FileNameTVC.register(for: tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100

        setUpViews()
        setupLayouts()
    }
    
    private func setUpViews(){
        contentView.addSubview(tableView)
    }
    
    private func setupLayouts() {
        
        tableView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuestionFourTVC: AssignmentsDelegate {
   
    func updateUploadedImages() {
        tableView.reloadData()
    }
}
