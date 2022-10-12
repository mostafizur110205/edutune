//
//  OTPTextView.swift
//  OTPTextView
//
//  Created by Ehsanomid on 5/27/18..
//  Copyright © 2018 Ehsan Omid. All rights reserved.
// GitHub : https://github.com/ehsanomid  Email : imehsan@icloud.com

import UIKit

public protocol OTPTextViewDelegate {
    
    func OTPTextViewResult( number:String?)
}

@IBDesignable
public class OTPTextView: UIView {
    
    public var delegate:OTPTextViewDelegate!
    
    // All textfield are generated and stored here
    public  var textfieldContainer = [UITextField]()
    
    // Cursert Defailt tint-color
    public var cursorColor =  UIColor.init(hex: "335EF7", alpha: 1)
    
    private var firstTxt = UITextField()
    
    // the moving line underneath of textfields
    public var underLineIndicator = UIView() // Small one
    public var UnderLineHighlight = UIView() // Big one
    
    public var isPasswordProtected : Bool = false
    {
        didSet
        {
            refresh()
        }
    }
    
    public enum indicatorStyleMode
    {
        case none
        case underline
        case underlineProgress
        
    }
    
    
    public var indicatorStyle = indicatorStyleMode.none
    {
        didSet
        {
            refresh()
        }
    }
    
    
    
    // All boarders' Attributes
    
    public var onErrorBorderColor:UIColor      = .red
    public var borderCColor:UIColor             =  UIColor.init(hex: "EEEEEE", alpha: 1)
    public var onEnterBoarderColor:UIColor     =  UIColor.init(hex: "335EF7", alpha: 1)
    public var onLeaveBoarderColor:UIColor     = UIColor.init(hex: "EEEEEE", alpha: 1)
    public var onFilledBorderColor:UIColor     = UIColor.init(hex: "EEEEEE", alpha: 1)
    public var onSuccessBoarderColor:UIColor   = UIColor.init(hex: "EEEEEE", alpha: 1)
    public var onAllFilledBoarderColor:UIColor = UIColor.init(hex: "EEEEEE", alpha: 1)
    
    public var indicatorColor:UIColor =  UIColor.init(hex: "335EF7", alpha: 1)
    {
        didSet
        {
            refresh()
        }
    }
    
    
    public var txtColor:UIColor = .black
    
    
    public var IndicatorGapeFromTop:CGFloat = 0
    {
        didSet
        {
            refresh()
        }
    }
    
    public var middleGape:CGFloat = 8
    {
        didSet
        {
            MiddleGapeToggle(with: middleGape)
            refresh()
            
        }
    }
    public var forceCompletion:Bool = true
    public var callOnCompleted:Bool = true
    public var AutoArrange:Bool = true
    {
        didSet
        {
            refresh()
        }
    }
    
    
    public var isBorderHidden:Bool = false
    {
        didSet
        {
            refresh()
        }
    }
    
    public var onEnterBorderWidth:CGFloat = 2
    {
        didSet
        {
            refresh()
        }
    }
    public var onLeaveBorderWidth:CGFloat = 1
    {
        didSet
        {
            refresh()
        }
    }
    
    
    public var borderSize:CGFloat = 1
    {
        didSet
        {
            refresh()
        }
    }
    public var BorderRadius:CGFloat = 5
    {
        didSet
        {
            refresh()
        }
    }
    public var isFirstResponser:Bool = true
    {
        didSet
        {
            
            refresh()
        }
        
    }
    public var BlockSize:CGSize = CGSize(width: 40, height: 65)
    {
        didSet
        {
            reCreate()
            
        }
    }
    
    public var BlocksNo:Int = 4
    {
        didSet
        {
            generateTextfields()
        }
    }
    
    func generateTextfields()
    {
        reCreate()
    }
    
    
    public var gape:CGFloat = 8
    {
        didSet
        {
            refresh()
        }
    }
    
    
    
    public var showCursor:Bool = true
    {
        didSet
        {
            cursorColor =  UIColor.init(hex: "335EF7", alpha: 1)
            refresh()
        }
    }
    
    
    public var fontSize:CGFloat = 20
    {
        didSet
        {
            refresh()
        }
    }
    
    public var placeHolder:String = ""
    {
        didSet
        {
            refresh()
        }
    }
    
    
    func reCreate()
    {
        self.subviews.forEach { $0.removeFromSuperview() }
        textfieldContainer.removeAll()
        setup()
    }
    
    
    public func AutoFillByFrameSize()
    {
        for i in 0...textfieldContainer.count - 1
        {
            let txt = textfieldContainer[i] as! EOTextfield
            txt.frame = CGRect(x: (BlockSize.width * CGFloat(i)) + (CGFloat(i) * 100), y: 0, width: BlockSize.width, height: BlockSize.height-10)
            self.addSelectedShadow(txt)
            
        }
    }
    
    func addSelectedShadow(_ view: UITextField?) {
        view?.backgroundColor = .clear
        view?.layer.shadowColor = UIColor.init(hex: "335EF7", alpha: 1).cgColor
        view?.layer.shadowOffset = CGSize(width: 1, height: 2)
        view?.layer.shadowRadius = 2
        view?.layer.shadowOpacity = 0.5
        view?.layer.masksToBounds = false
    }
    
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        refresh()
    }
    
    
    func refresh() {
        if bounds.width <  (CGFloat(BlocksNo) * BlockSize.width)
        {
            print("OTPTextView: ( You don't have ample space for showing all )")
        }
        
        let CG = (bounds.width - (CGFloat(BlocksNo) * BlockSize.width)) / CGFloat(BlocksNo)
        
        
        for i in 0...textfieldContainer.count - 1
        {
            let txt = textfieldContainer[i] as! EOTextfield
            if AutoArrange
            {
                txt.frame = CGRect(x: ((BlockSize.width + CG) * CGFloat(i)) + (CG / 2), y: 0, width: BlockSize.width, height: BlockSize.height-10)
            } else
            {
                txt.frame = CGRect(x: (BlockSize.width * CGFloat(i)) + (CGFloat(i) * gape), y: 0, width: BlockSize.width, height: BlockSize.height-10)
                
            }
            
            txt.center = CGPoint(x: txt.center.x , y: frame.height / 2)
            self.addSelectedShadow(txt)
            
            if isBorderHidden
            {
                
                txt.layer.borderWidth = 0
                
            } else
            {
                txt.layer.borderWidth = borderSize
                txt.layer.borderColor = borderCColor.cgColor
                txt.layer.cornerRadius = BorderRadius
            }
            
            
            txt.placeholder = placeHolder
            txt.tintColor = cursorColor
            txt.keyboardType = .numberPad
            txt.textAlignment = .center
            txt.font = UIFont(name: "Roboto-Medium", size: 20)!
            txt.textColor = txtColor
            txt.isSecureTextEntry = isPasswordProtected
            
            
        }
        
        UnderLineHighlight.backgroundColor = indicatorColor
        underLineIndicator.backgroundColor = indicatorColor
        
        firstTxt = textfieldContainer[0] // it keeps the first Textfield
        underLineIndicator.center = CGPoint(x: firstTxt.center.x, y: firstTxt.center.y + firstTxt.frame.height / 2 + IndicatorGapeFromTop )
        
        UnderLineHighlight.center = CGPoint(x: 0 + firstTxt.frame.width / 2, y: firstTxt.center.y + firstTxt.frame.height / 2 + IndicatorGapeFromTop )
        
        switch self.indicatorStyle
        {
            
        case .none:
            
            self.UnderLineHighlight.isHidden = true
            self.underLineIndicator.isHidden = true
            
        case .underline:
            self.underLineIndicator.isHidden = false
            self.UnderLineHighlight.isHidden = true
            
        case .underlineProgress:
            self.UnderLineHighlight.isHidden = false
            self.underLineIndicator.isHidden = true
            
        }
        
        if isFirstResponser
        {
            firstTxt.becomeFirstResponder()
        }
        
    }
    
    private func MiddleGapeToggle(with Gape:CGFloat)
    {
        if (BlocksNo  % 2 == 0)
        {
            let midSide = BlocksNo / 2
            
            
            for i in 0...textfieldContainer.count - 1
            {
                let txt = textfieldContainer[i] as! EOTextfield
                
                if i < midSide
                {
                    txt.center.x = txt.center.x - Gape
                    
                } else
                {
                    txt.center.x = txt.center.x + Gape
                }
                
            }
        }
    }
    
    func setup()
    {
        for i in 0...BlocksNo - 1
        {
            let txt = EOTextfield()
            addSubview(txt)
            
            // All delegation are defined here
            txt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            txt.addTarget(self, action: #selector(textFieldShouldBeginEditing(_:)), for: .editingDidBegin)
            txt.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
            
            
            // Initial Properties
            txt.placeholder = placeHolder
            txt.tintColor = cursorColor
            txt.keyboardType = .numberPad
            txt.textAlignment = .center
            txt.font = UIFont(name: "Urbanist-Bold", size: 24)!
            txt.textColor = txtColor
            
            txt.flag = i //
            
            textfieldContainer.append(txt)
        }
        
        underLineIndicator = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 2))
        addSubview(underLineIndicator)
        
        UnderLineHighlight = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 2))
        
        addSubview(UnderLineHighlight)
        
        UnderLineHighlight.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        if isFirstResponser
        {
            firstTxt.becomeFirstResponder()
            firstTxt.text = ""
            
        }
        
        refresh()
    }
    
    
    @objc func textFieldDidChange(_ textField: EOTextfield) {
        
        
        textField.text = textField.text!.EOreplace(target: " ", withString: "")
        
        if (textField.text!.count == 1) {
            let ff = textField.text
            textField.text =  String(ff!.prefix(1))
        }
            
        else if (textField.text!.count == 2) {
            let ff = textField.text
            textField.text =  String(ff!.suffix(1))
        }
        
        
        if textField.text == "" && textField.flag > 0
        {
            
            textfieldContainer[textField.flag - 1].becomeFirstResponder()
            textfieldContainer[textField.flag].layer.borderColor = borderCColor.cgColor
        }
        else
        {
            if textField.text!.utf16.count == 1 && textField.flag < textfieldContainer.count - 1
            {
                textfieldContainer[textField.flag + 1].becomeFirstResponder()
                if Int(textField.text!) == nil{
                    
                    textField.text = ""
                }
            }
        }
        
        var sum = 0
        
        for tx in textfieldContainer
        {
            
            if tx.text != ""
            {
                sum += 1
            }
            
        }
        
        if sum == BlocksNo
        {
            for txt in textfieldContainer
            {
                
                txt.layer.borderColor = onAllFilledBoarderColor.cgColor
                
            }
            
            if callOnCompleted
            {
                delegate?.OTPTextViewResult(number: getNumber())
            }
        }
        
    }
    
    
    
    @objc  func textFieldShouldBeginEditing(_ textField: EOTextfield) {
        
        for tx in textfieldContainer
        {
            if !isBorderHidden
            {
                tx.layer.borderColor = onFilledBorderColor.cgColor
                tx.layer.borderWidth = onLeaveBorderWidth
            }
        }
        
        if !isBorderHidden
        {
            textField.layer.borderColor = onEnterBoarderColor.cgColor
            textField.layer.borderWidth = onEnterBorderWidth
        }
        
        UIView.animate(withDuration: 0.3) {
            
            switch self.indicatorStyle
            {
                
            case .none:
                break
                
            case .underline:
                self.UnderLineHighlight.isHidden = true
                self.underLineIndicator.center = CGPoint(x: textField.center.x , y: self.underLineIndicator.center.y)
                
            case .underlineProgress:
                self.underLineIndicator.isHidden = true
                self.UnderLineHighlight.frame.size = CGSize(width: (self.firstTxt.center.x + textField.center.x) - textField.frame.width, height: 2)
            }
        }
        
        if textField.text == ""
        {
            textField.text = ""
        }
 
    }
    
    @objc func textFieldDidEndEditing(_ textField: EOTextfield) {
        
        if textField.text == ""
        {
            if !isBorderHidden
            {
                textField.layer.borderColor = borderCColor.cgColor
            }
            
        }
        
    }
    
    public func getNumber() -> String?
    {
        var number = ""
        for txt in textfieldContainer
        {
            if (txt.text == "") && forceCompletion
            {
                txt.becomeFirstResponder()
                txt.layer.borderColor = onErrorBorderColor.cgColor
                
                flash(from: textfieldContainer.index(of:txt)!, to: textfieldContainer.count - 1, speed: 1)
                return nil
            }
            number += txt.text!
        }
        return number
    }
    
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    
    public func clearAll()
    {
        for txt in textfieldContainer
        {
            txt.text = ""
            becomeResponserAt(at: 0)
        }
    }
    
    func becomeResponserAt(at index:Int)
    {
        if index < textfieldContainer.count && index >= 0
        {
            textfieldContainer[index].becomeFirstResponder()
        } else
        {
            print("out of range")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    public func onSuccess()
    {
        for txt in textfieldContainer
        {
            txt.resignFirstResponder()
            if !isBorderHidden
            {
                txt.layer.borderColor = onSuccessBoarderColor.cgColor
                txt.layer.borderWidth = 0
            }
        }
    }
    
    public  func flash(from:Int, to:Int, speed:Double)
    {
        for i in from...to
        {
            
            textfieldContainer[i].alpha = 0
            UIView.animate(withDuration: speed) {
                self.textfieldContainer[i].alpha = 1
            }
        }
    }
    
    public func flashAll(speed:Double)
    {
        for txt in textfieldContainer
        {
            txt.alpha = 0
            UIView.animate(withDuration: speed) {
                txt.alpha = 1
            }
        }
    }
    
}

class EOTextfield: UITextField {
    
    var flag:Int = Int()
    
}


extension String
{
    func EOreplace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
