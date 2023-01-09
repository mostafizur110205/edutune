//
//  OptionsTableViewController.swift
//  EduTune
//
//  Created by DH on 10/1/23.
//

import UIKit


public class OptionsTableViewController: UITableViewController {
    
    enum Constants {
        static var cellBackgroundColor: UIColor = {
            if #available(iOS 13.0, *) {
                return .systemBackground
            } else {
                return .white
            }
        }()
        
        static var cellSelectedBackgroundColor: UIColor = {
            if #available(iOS 13.0, *) {
                return .secondarySystemBackground
            } else {
                return .lightGray
            }
        }()
    }
    
    private static let rowHeight: CGFloat = 44.0
    
    public typealias OnSelectHandler = (_ selected: Int) -> Void
    
    public var options = [OptionsTableViewOption]()
    
    public var onSelect: OnSelectHandler?
    
    public var cellBackgroundColor: UIColor = Constants.cellBackgroundColor {
        didSet {
            tableView.backgroundColor = cellBackgroundColor
            tableView?.reloadData()
        }
    }
    
    public var cellSelectedBackgroundColor: UIColor = Constants.cellSelectedBackgroundColor
    
    public var cellDeselectedTintColor: UIColor? {
        didSet {
            tableView?.reloadData()
        }
    }
    
    public init(options: [OptionsTableViewOption]) {
        self.options = options
        super.init(style: .plain)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = cellBackgroundColor
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: OptionsTableViewCell.reuseIdentifier)
        
        preferredContentSize = CGSize(width: 0, height: min(CGFloat(options.count), 7.5) * OptionsTableViewController.rowHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func selectRow(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
    }
}

extension OptionsTableViewController {
    
    public override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        cell.accessoryType = .none
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        cell.accessoryType = .checkmark
        onSelect?(indexPath.row)
    }
    
    public override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = cellBackgroundColor
        
        let selectedView = UIView()
        selectedView.backgroundColor = cellSelectedBackgroundColor
        cell.selectedBackgroundView = selectedView
    }
}

extension OptionsTableViewController {
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = tableView.dequeueReusableCell(withIdentifier: OptionsTableViewCell.reuseIdentifier, for: indexPath) as! OptionsTableViewCell
        
        let option = options[indexPath.row]
        reuseCell.textLabel?.attributedText = option.title
        reuseCell.imageView?.image = option.image
        
        reuseCell.deselectedTintColor = cellDeselectedTintColor
        reuseCell.accessibilityLabel = option.accessibilityLabel
        
        let isSelected = indexPath.row == tableView.indexPathForSelectedRow?.row
        reuseCell.isSelected = isSelected
        
        return reuseCell
    }
}
