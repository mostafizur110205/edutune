//
//  FormValidation.swift
//  BOOM SOCCER
//
//  Created by Mostafizur Rahman on 26/5/20.
//  Copyright © 2020 PEEMZ. All rights reserved.


import UIKit

class FormValidation: NSObject {
    class func isValidEmail(_ candidate:String) -> Bool {
        //println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: candidate)
        return result
    }
    class func isValidZip(_ candidate:String) -> Bool {
        let zipRegEx = "^(\\d{5}(-\\d{4})?|[a-z]\\d[a-z][- ]*\\d[a-z]\\d)$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", zipRegEx)
        let result = emailTest.evaluate(with: candidate)
        return result
    }
    class func isValidCity(_ candidate:String) -> Bool {
        let zipRegEx = "^[A-Za-z]+(\\s[A-Za-z]+)?$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", zipRegEx)
        let result = emailTest.evaluate(with: candidate)
        return result
    }
    class func isValidNumber(_ candidate:String) -> Bool {
        let regex = "^[0-9]+$"
        let numberTest = NSPredicate(format:"SELF MATCHES %@", regex)
        let result = numberTest.evaluate(with: candidate)
        return result
    }
    class func isValidPhone(_ candidate:String, minLength: NSNumber?, maxLength: NSNumber?, country: String?) -> Bool {
        var regex = "^(\\+[1-9]{1,4})?[0-9]{3,}$"
        
        if let minL: NSNumber = minLength{
            regex = "^(\\+[1-9]{1,4})?[0-9]{" + minL.stringValue + ",}$"
            if let maxL: NSNumber = maxLength{
                regex = "^(\\+[1-9]{1,4})?[0-9]{" + minL.stringValue + "," + maxL.stringValue + "}$"
            }
        }
        
        //print(regex)
        let phoneText = NSPredicate(format:"SELF MATCHES %@", regex)
        let result = phoneText.evaluate(with: candidate)
        //print(result)
        return result
    }
}
