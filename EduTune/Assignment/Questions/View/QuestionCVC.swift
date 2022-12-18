//
//  QuestionCVC.swift
//  EduTune
//
//  Created by DH on 11/12/22.
//

import Foundation
import UIKit

extension UICollectionViewCell {

    static func register(for collectionView: UICollectionView)  {
        let cellName = String(describing: self)
        let cellIdentifier = cellName
        collectionView.register(self, forCellWithReuseIdentifier: cellIdentifier)
    }
}


class QuestionCVC: UICollectionViewCell {
    
    var questionItem: QuestionItemModel? {
        didSet{
            guard let model = questionItem else {return}
            marksLabel.text = "\(model.point ?? 0) Marks"
            tableView.reloadData()
        }
    }

    let marksLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()



    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        QuestionOneTVC.register(for: tableView)
        QuestionTwoTVC.register(for: tableView)
        QuestionFourTVC.register(for: tableView)
        QuestionSevenTVC.register(for: tableView)
        QuestionNineTVC.register(for: tableView)
        QuestionElevenTVC.register(for: tableView)

        setUpViews()
        setupLayouts()
    }
    
    private func setUpViews(){
        
        addSubview(marksLabel)
        addSubview(tableView)
    }
    
    private func setupLayouts() {
        
        marksLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        marksLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        marksLabel.rightAnchor.constraint(equalTo: rightAnchor, constant:-20).isActive = true
        marksLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        tableView.topAnchor.constraint(equalTo: marksLabel.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
