//
//  BottomSheetVC.swift
//  EduTune
//
//  Created by DH on 11/12/22.
//

import UIKit

class BottomSheetVC: UIViewController {
    
    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var contentViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak private var contentViewHeight: NSLayoutConstraint!
    
    private let viewModel: BRQBottomSheetPresentable
    private let childViewController: UIViewController
    private var originBeforeAnimation: CGRect = .zero
    
    public init(viewModel: BRQBottomSheetPresentable, childViewController: UIViewController) {
        
        self.viewModel = viewModel
        self.childViewController = childViewController
        super.init(
            nibName: String(describing: BottomSheetVC.self),
            bundle: Bundle(for: BottomSheetVC.self)
        )
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    @IBAction private func topViewTap(_ sender: Any) {
        dismissViewController()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BottomSheetVC {
   
   override public func viewDidLoad() {
       super.viewDidLoad()
       
       contentView.alpha = 1
       configureChild()
       contentViewBottomConstraint.constant = -childViewController.view.frame.height
       view.layoutIfNeeded()
   }
    
   override public func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)

       contentViewHeight.isActive = false
       contentViewBottomConstraint.constant = 0
       UIView.animate(withDuration: viewModel.animationTransitionDuration) {
           self.view.backgroundColor = self.viewModel.backgroundColor
           self.view.layoutIfNeeded()
       }
   }
   
   override public func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
       contentView.roundCorners([.topLeft, .topRight], radius: viewModel.cornerRadius)
       originBeforeAnimation = contentView.frame
   }
}

extension BottomSheetVC {
    
    public func dismissViewController() {
        contentViewBottomConstraint.constant = -childViewController.view.frame.height
        UIView.animate(withDuration: viewModel.animationTransitionDuration, animations: {
            self.view.layoutIfNeeded()
            self.view.backgroundColor = .clear
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
        })
    }
}


private extension BottomSheetVC {
    
    private func configureChild() {
        
        addChild(childViewController)
        contentView.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
        
        guard let childSuperView = childViewController.view.superview else { return }

        NSLayoutConstraint.activate([
            childViewController.view.bottomAnchor.constraint(equalTo: childSuperView.bottomAnchor),
            childViewController.view.topAnchor.constraint(equalTo: childSuperView.topAnchor),
            childViewController.view.leftAnchor.constraint(equalTo: childSuperView.leftAnchor),
            childViewController.view.rightAnchor.constraint(equalTo: childSuperView.rightAnchor)
            ])
        
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
    }
}
