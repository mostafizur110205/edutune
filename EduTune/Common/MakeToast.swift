//
//  MakeToast.swift
//  BOOM SOCCER
//
//  Created by Mostafizur Rahman on 26/5/20.
//  Copyright © 2020 PEEMZ. All rights reserved.


import Foundation
import Toast_Swift

class MakeToast{
    
    static let shared = MakeToast()
    
    func makeNormalToast(_ message:String){
        
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.hideAllToasts()
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.makeToast(message, duration: 2, position: .bottom)
    }
    
    func makeRedToast(_ message:String){
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.hideAllToasts()
        var style = ToastStyle()
        style.messageColor = .white
        style.backgroundColor = .red
        //style.cornerRadius = 20
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.makeToast(message, duration: 2, position: .bottom, style: style)
    }
    
    func makeWhiteToast(_ message:String){
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.hideAllToasts()
        var style = ToastStyle()
        style.messageColor = .black
        style.backgroundColor = .white
        style.cornerRadius = 20
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.makeToast(message, duration: 2, position: .bottom, style: style)
    }
    
    func makeNormalSuccessAlert(_ message: String, viewController: UIViewController){
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func makeNormalErrorAlert(_ message: String, viewController: UIViewController){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
}

