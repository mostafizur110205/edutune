//
//  DVExtensions.swift
//  BOOM SOCCER
//
//  Created by Mostafizur Rahman on 26/5/20.
//  Copyright © 2020 PEEMZ. All rights reserved.


import UIKit
import Photos
import UserNotifications

class Extensions{
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func removeFileAtURL(_ file: URL){
        DispatchQueue.main.async {
            do{
                try FileManager.default.removeItem(at: file)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    class func getLabelHeight(_ forText: String, font: UIFont, width: CGFloat, numberOfLines: Int = 0) -> CGFloat{
        let label: UILabel = UILabel()
        label.numberOfLines = numberOfLines
        label.font = font
        label.text = forText
        return label.sizeThatFits(CGSize(width: width, height: CGFloat(MAXFLOAT))).height
    }
    
    class func getLabelWidth(_ forText: String, font: UIFont, height: CGFloat, numberOfLines: Int = 0) -> CGFloat{
        let label: UILabel = UILabel()
        label.numberOfLines = numberOfLines
        label.font = font
        label.text = forText
        return label.sizeThatFits(CGSize(width: CGFloat(MAXFLOAT), height: height)).width
    }
    
    class func getLabelHeight(_ forAttributedText: NSAttributedString, width: CGFloat, numberOfLines: Int = 0) -> CGFloat{
        let label: UILabel = UILabel()
        label.numberOfLines = numberOfLines
        label.attributedText = forAttributedText
        return label.sizeThatFits(CGSize(width: width, height: CGFloat(MAXFLOAT))).height
    }
    
    class func getLabelWidth(_ forAttributedText: NSAttributedString, height: CGFloat, numberOfLines: Int = 0) -> CGFloat{
        let label: UILabel = UILabel()
        label.numberOfLines = numberOfLines
        label.attributedText = forAttributedText
        return label.sizeThatFits(CGSize(width: CGFloat(MAXFLOAT), height: height)).width
    }
    
    
    static var isKeyboardPresented: Bool {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"), UIApplication.shared.windows.contains(where: { $0.isKind(of: keyboardWindowClass) }) {
            return true
        } else {
            return false
        }
    }
    
    class func getTimeFrom24Time(timeStr: String?) -> String {
        if let timeS = timeStr {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let date = dateFormatter.date(from: timeS)
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: date!)
        }
        return ""
    }
}

// MARK: - UIApplication
extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

// MARK: - UIImageView
extension UIImageView {
    func downloadedFrom(link:String, contentMode mode: UIView.ContentMode) {
        guard
            let url = URL(string: link)
        else {return}
        contentMode = mode
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? HTTPURLResponse , httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType , mimeType.hasPrefix("image"),
                let data = data , error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async { () -> Void in
                self.image = image
            }
        })
        task.priority = 1.0
        task.resume()
    }
    
    @IBInspectable var imageRenderingMode: Int{
        get {
            if let image: UIImage = self.image{
                return image.renderingMode.rawValue
            }
            return 0
        }
        set {
            if let image: UIImage = self.image{
                self.image = image.withRenderingMode(UIImage.RenderingMode(rawValue: newValue)!)
            }
        }
    }
}

// MARK: - UIImage
extension UIImage {
    func resizeWith(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 1)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWith(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 1)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    func resizeWith(height: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: CGFloat(ceil(height * size.width / size.height)), height: height)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 1)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    enum ImageFormat: Int{
        case png = 0, jpeg
    }
    
    
    func imageInRect(rect: CGRect)->UIImage{
        UIGraphicsBeginImageContext(rect.size)
        let imageRect: CGRect = CGRect(
            x: (rect.width - self.size.width) / 2,
            y: (rect.height - self.size.height) / 2,
            width: self.size.width,
            height: self.size.height)
        self.draw(in: imageRect)
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    struct RotationOptions: OptionSet {
        let rawValue: Int
        
        static let flipOnVerticalAxis = RotationOptions(rawValue: 1)
        static let flipOnHorizontalAxis = RotationOptions(rawValue: 2)
    }
    
    @available(iOS 10.0, *)
    func rotated(by rotationAngle: Measurement<UnitAngle>, options: RotationOptions = []) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        
        let rotationInRadians = CGFloat(rotationAngle.converted(to: .radians).value)
        let transform = CGAffineTransform(rotationAngle: rotationInRadians)
        var rect = CGRect(origin: .zero, size: self.size).applying(transform)
        rect.origin = .zero
        
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        return renderer.image { renderContext in
            renderContext.cgContext.translateBy(x: rect.midX, y: rect.midY)
            renderContext.cgContext.rotate(by: rotationInRadians)
            
            let x = options.contains(.flipOnVerticalAxis) ? -1.0 : 1.0
            let y = options.contains(.flipOnHorizontalAxis) ? 1.0 : -1.0
            renderContext.cgContext.scaleBy(x: CGFloat(x), y: CGFloat(y))
            
            let drawRect = CGRect(origin: CGPoint(x: -self.size.width/2, y: -self.size.height/2), size: self.size)
            renderContext.cgContext.draw(cgImage, in: drawRect)
        }
    }
    
    func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
        /*let radiansToDegrees: (CGFloat) -> CGFloat = {
         return $0 * (180.0 / CGFloat(Double.pi))
         }*/
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(Double.pi)
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees))
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap!.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)
        
        //   // Rotate the image context
        bitmap!.rotate(by: degreesToRadians(degrees))
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        bitmap!.scaleBy(x: yFlip, y: -1.0)
        bitmap!.draw(self.cgImage!, in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
    func overlayImage(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        
        color.setFill()
        
        context!.translateBy(x: 0, y: self.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        
        context!.setBlendMode(CGBlendMode.colorBurn)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context!.draw(self.cgImage!, in: rect)
        
        context!.setBlendMode(CGBlendMode.sourceIn)
        context!.addRect(rect)
        context!.drawPath(using: CGPathDrawingMode.fill)
        
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return coloredImage
    }
}

// MARK: - UIColor
extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    class func imageWithColor(_ color: UIColor, size: CGSize? = nil) -> UIImage{
        var height: CGFloat = 1.0
        var width: CGFloat = 1.0
        
        if size != nil{
            height = size!.height
            width = size!.width
        }
        
        let rect: CGRect = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    static func randomColor() -> UIColor{
        return UIColor(red:   0.62,
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

// MARK: - CGFloat
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

// MARK: - Int

extension Int {
    
    var ordinal: String {
        var suffix: String
        let ones: Int = self % 10
        let tens: Int = (self/10) % 10
        if tens == 1 {
            suffix = "th"
        } else if ones == 1 {
            suffix = "st"
        } else if ones == 2 {
            suffix = "nd"
        } else if ones == 3 {
            suffix = "rd"
        } else {
            suffix = "th"
        }
        return "\(self)\(suffix)"
    }
    
    static func random() -> Int {
        return Int(arc4random()) / Int.max
    }
    static func randomNumber(range: ClosedRange<Int>) -> Int {
        let min = range.lowerBound
        let max = range.upperBound
        return Int(arc4random_uniform(UInt32(1 + max - min))) + min
    }
    static func randomNumber(min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(1 + max - min))) + min
    }
    
    var decimal: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let value = numberFormatter.string(from: NSNumber(value:self))!
        return value
    }
}


extension Float {
    var decimal: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let value = numberFormatter.string(from: NSNumber(value:self))!
        return value
    }
}

// MARK: - Character

extension Character {
    var asciiValue: UInt32? {
        return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }
}

// MARK: - String

extension String {
    
    var formattedPrice: String {
        return self.replacingOccurrences(of: ".", with: ",")
    }
    
    var removeAccents: String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
    
    subscript(value: CountableClosedRange<Int>) -> Substring {
        get {
            return self[index(at: value.lowerBound)...index(at: value.upperBound)]
        }
    }
    
    subscript(value: CountableRange<Int>) -> Substring {
        get {
            return self[index(at: value.lowerBound)..<index(at: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        get {
            return self[..<index(at: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeThrough<Int>) -> Substring {
        get {
            return self[...index(at: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeFrom<Int>) -> Substring {
        get {
            return self[index(at: value.lowerBound)...]
        }
    }
    
    func index(at offset: Int) -> String.Index {
        return index(startIndex, offsetBy: offset)
    }
    

    
    var trim: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    var hasText: Bool {
        return self != ""
    }
    
    var lines: [String] {
        var result: [String] = []
        enumerateLines { line, _ in result.append(line) }
        return result
    }
    
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
    
    var asciiArray: [UInt32] {
        return unicodeScalars.filter{$0.isASCII}.map{$0.value}
    }
    
    // formatting text for currency textField
    func currencyFormattingRightToLeft() -> String? {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return nil
        }
        
        return formatter.string(from: number)
    }
    
    func currencyFromFormattedString()->Double{
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        return NSNumber(value: (double / 100)).doubleValue
    }
    
    func heightOfLabel(font:UIFont, width:CGFloat, numberOfLines: Int = 0) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        
        label.sizeToFit()
        return label.frame.height
    }
    
    func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
    
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
    
    func matches(_ with: String)->Float{
        var matchingCount: Int = 0
        
        for c in self.lowercased(){
            for c1 in with.lowercased(){
                if c == c1{
                    matchingCount += 1
                    break
                }
            }
        }
        
        return 100.0 * (Float(matchingCount)/Float(with.count))
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var dateStringToDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        return date ?? Date()
    }
    
    var newsDateStringToDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = dateFormatter.date(from: self)
        return date ?? Date()
    }
    
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string
        
        return decoded ?? self
    }
    
}

// MARK: - UIView

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func removeAllSubviews(){
        for __view in self.subviews{
            __view.removeFromSuperview()
        }
    }
    
    func addBorder(edges: UIRectEdge, color: UIColor = UIColor.white, thickness: CGFloat = 1) -> [UIView]{
        
        var borders = [UIView]()
        
        func border() -> UIView {
            let border = UIView(frame: CGRect.zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            return border
        }
        
        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            addSubview(top)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["top": top]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[top]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["top": top]))
            borders.append(top)
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            addSubview(left)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["left": left]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[left]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["left": left]))
            borders.append(left)
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            addSubview(right)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["right": right]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[right]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["right": right]))
            borders.append(right)
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            addSubview(bottom)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["bottom": bottom]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[bottom]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["bottom": bottom]))
            borders.append(bottom)
        }
        
        return borders
    }
    
    func removeBorder(borders: [UIView]){
        for _view in borders{
            _view.removeFromSuperview()
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func addDropShadow(_ color: UIColor? = nil, shadowRadius: CGFloat? = nil, shadowOffset: CGSize? = nil, shadowOpacity: Float? = nil) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color != nil ? color!.cgColor : UIColor.black.cgColor
        self.layer.shadowOpacity = shadowOpacity != nil ? shadowOpacity! : 0.5
        self.layer.shadowOffset = shadowOffset != nil ? shadowOffset! : CGSize(width: 0, height: 1)
        self.layer.shadowRadius = shadowRadius != nil ? shadowRadius! : 1.0
        
        //self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shouldRasterize = false
    }
    
    func startSpinning() {
        let spinAnimation = CABasicAnimation()
        spinAnimation.fromValue = 0
        spinAnimation.toValue = Double.pi * 2
        spinAnimation.duration = 2.5
        spinAnimation.repeatCount = Float.infinity
        spinAnimation.isRemovedOnCompletion = false
        layer.add(spinAnimation, forKey: "transform.rotation.z")
    }
    
    func stopSpinning() {
        layer.removeAllAnimations()
    }
    
    
    func unlock() {
        if let lockView = viewWithTag(10) {
            UIView.animate(withDuration: 0.2, animations: {
                lockView.alpha = 0.0
            }, completion: { finished in
                lockView.removeFromSuperview()
            })
        }
    }
    
    func fadeOut(_ duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
    func fadeIn(_ duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    class func viewFromNibName(_ name: String) -> UIView? {
        let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        return views?.first as? UIView
    }
    
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
    
    func animationRoted(angle : CGFloat) {
        self.transform = self.transform.rotated(by: angle)
    }
    
    var globalPoint :CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }
    
    var globalFrame :CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
}

// MARK: - UINavigationBar

extension UINavigationBar {
    
    func setBottomBorderColor(_ color: UIColor, height: CGFloat) {
        if let bottomBorderView: UIView = self.viewWithTag(268866){
            bottomBorderView.backgroundColor = color
            var oldFrame: CGRect = bottomBorderView.frame
            oldFrame.size.height = height
            bottomBorderView.frame = oldFrame
        }else{
            let bottomBorderRect = CGRect(x: 0, y: frame.height, width: 10000, height: height)
            let bottomBorderView = UIView(frame: bottomBorderRect)
            bottomBorderView.tag = 268866
            bottomBorderView.backgroundColor = color
            addSubview(bottomBorderView)
        }
    }
    
    func removeBottomBorderColor(){
        if let bottomBorderView: UIView = self.viewWithTag(268866){
            bottomBorderView.removeFromSuperview()
        }
    }
    
    func makeTransTransparent(){
        self.setBackgroundImage(UIImage(named: "img_bg_common"), for: UIBarMetrics.default)
//        self.barTintColor = .clear //UIColor.init(hex: "1B142E", alpha: 1)
        self.shadowImage = UIImage()
        self.isTranslucent = false
        setBottomBorderColor(.clear, height: 1)
    }
}

// MARK: - CALayer borderColorFromUIColor
extension CALayer{
    func setBorderColorFromUIColor(_ color: UIColor){
        self.borderColor = color.cgColor
    }
    
    func addGradientBorder(colors:[UIColor] = [UIColor.red,UIColor.blue], width:CGFloat = 1, isHorizontal: Bool = true) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame =  CGRect(origin: CGPoint.zero, size: self.bounds.size)
        if isHorizontal{
            gradientLayer.startPoint = CGPoint(x:0.0, y:0.5)
            gradientLayer.endPoint = CGPoint(x:1.0, y:0.5)
        }
        gradientLayer.colors = colors.map({$0.cgColor})
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = width
        shapeLayer.path = UIBezierPath(rect: self.bounds).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        gradientLayer.mask = shapeLayer
        
        self.addSublayer(gradientLayer)
    }
    
    func addGradientBorderShape(colors:[UIColor] = [UIColor.red,UIColor.blue], width:CGFloat = 1, isHorizontal: Bool = true, frame: CGRect? = nil, path: CGPath? = nil) {
        let gradientLayer = CAGradientLayer()
        if frame != nil{
            gradientLayer.frame = frame!
        }else{
            gradientLayer.frame =  CGRect(origin: CGPoint.zero, size: self.bounds.size)
        }
        
        if isHorizontal{
            gradientLayer.startPoint = CGPoint(x:0.0, y:0.5)
            gradientLayer.endPoint = CGPoint(x:1.0, y:0.5)
        }
        gradientLayer.colors = colors.map({$0.cgColor})
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = width
        if path != nil{
            shapeLayer.path = path!
        }else{
            shapeLayer.path = UIBezierPath(rect: self.frame).cgPath
        }
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        gradientLayer.mask = shapeLayer
        
        self.addSublayer(gradientLayer)
    }
    
    func addGradientBackground(colors: [CGColor], isSquare: Bool = false, isHorizontal: Bool = false){
        let gradient = CAGradientLayer()
        
        if isSquare{
            let maxWidth = max(self.bounds.size.height,self.bounds.size.width)
            let squareFrame = CGRect(origin: self.bounds.origin, size: CGSize(width: maxWidth, height: maxWidth))
            gradient.frame = squareFrame
        }else{
            gradient.frame = self.bounds
        }
        
        gradient.colors = colors
        
        if isHorizontal{
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        self.insertSublayer(gradient, at: 0)
    }
    
    func addGradientBackgroundShape(colors: [UIColor], isHorizontal: Bool = false, frame: CGRect? = nil, path: CGPath? = nil) -> CALayer {
        let gradientLayer = CAGradientLayer()
        if frame != nil{
            gradientLayer.frame = frame!
        }else{
            gradientLayer.frame =  self.frame
        }
        if isHorizontal{
            gradientLayer.startPoint = CGPoint(x:0.0, y:0.5)
            gradientLayer.endPoint = CGPoint(x:1.0, y:0.5)
        }
        gradientLayer.colors = colors.map({$0.cgColor})
        
        let shapeLayer = CAShapeLayer()
        //shapeLayer.lineWidth = 1.0
        if path != nil{
            shapeLayer.path = path!
        }else{
            shapeLayer.path = UIBezierPath(rect: self.frame).cgPath
        }
        gradientLayer.mask = shapeLayer
        
        self.insertSublayer(gradientLayer, at: 0)
        
        return gradientLayer
    }
}

// MARK: - NSTextAttachment

extension NSTextAttachment {
    func setImageHeight(_ height: CGFloat) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height
        
        bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: ratio * height, height: height)
    }
}

// MARK: - ShadowedView
class ShadowedView: UIView{
    @IBInspectable var shadowColor: UIColor?{
        get {
            if self.layer.shadowColor != nil{
                return UIColor(cgColor: self.layer.shadowColor!)
            }else{
                return nil
            }
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowWidthOffset: CGFloat {
        get {
            return layer.shadowOffset.width
        }
        set {
            layer.shadowOffset.width = newValue
        }
    }
    
    @IBInspectable var shadowHeightOffset: CGFloat {
        get {
            return layer.shadowOffset.height
        }
        set {
            layer.shadowOffset.height = newValue
        }
    }
    @IBInspectable var shadowRadius: CGFloat{
        get{
            return self.layer.shadowRadius
        }
        set{
            self.layer.shadowRadius = newValue
        }
    }
    @IBInspectable var shadowOpacity: CGFloat{
        get{
            return CGFloat(self.layer.shadowOpacity)
        }
        set{
            self.layer.shadowOpacity = Float(newValue)
        }
    }
    @IBInspectable var masksToBounds: Bool{
        get{
            return self.layer.masksToBounds
        }
        set{
            self.layer.masksToBounds = newValue
        }
    }
}

// MARK: - UIViewController
extension UIViewController{
    func findParentViewController(_ vc: UIViewController? = nil, searchVC: AnyClass)->UIViewController?{
        let vc: UIViewController = vc == nil ? self : vc!
        guard let parentVC: UIViewController = vc.parent else{
            return nil
        }
        if object_getClass(parentVC) === searchVC{
            return vc.parent
        }else if parentVC.isKind(of: searchVC){
            return vc.parent
        }else{
            return findParentViewController(parentVC, searchVC: searchVC)
        }
    }
}

// MARK: - CollectionViewFlowLayoutMinSpacing
class CollectionViewFlowLayoutMinSpacing : UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) ->     [UICollectionViewLayoutAttributes]? {
        guard let oldAttributes = super.layoutAttributesForElements(in: rect) else {
            return super.layoutAttributesForElements(in: rect)
        }
        let spacing = CGFloat(5)
        var newAttributes = [UICollectionViewLayoutAttributes]()
        var leftMargin = self.sectionInset.left
        for attributes in oldAttributes {
            if (attributes.frame.origin.x == self.sectionInset.left) {
                leftMargin = self.sectionInset.left
            } else {
                var newLeftAlignedFrame = attributes.frame
                newLeftAlignedFrame.origin.x = leftMargin
                attributes.frame = newLeftAlignedFrame
            }
            
            leftMargin += attributes.frame.width + spacing
            newAttributes.append(attributes)
        }
        return newAttributes
    }
}

// MARK: - Date
extension Date{
    var toLocalTime: Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        
        return end - start
    }
    
    func getDayOfWeek()->Int? {
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let myComponents = myCalendar?.components(.weekday, from: self)
        let weekDay = myComponents?.weekday
        return weekDay
    }
    
    func dateStringWithFormat(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    
    
    var timeAgoSinceDate: String {
        
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Bundle.main.preferredLocalizations[0]) //--> IF THE USER HAVE THE PHONE IN SPANISH BUT YOUR APP ONLY SUPPORTS I.E. ENGLISH AND GERMAN WE SHOULD CHANGE THE LOCALE OF THE FORMATTER TO THE PREFERRED ONE (IS THE LOCALE THAT THE USER IS SEEING THE APP), IF NOT, THIS ELAPSED TIME IS GOING TO APPEAR IN SPANISH
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1
        formatter.calendar = calendar
        
        var dateString: String?
        
        let interval = calendar.dateComponents([.year, .month, .weekOfYear, .day], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            formatter.allowedUnits = [.year] //2 years
        } else if let month = interval.month, month > 0 {
            formatter.allowedUnits = [.month] //1 month
        } else if let week = interval.weekOfYear, week > 0 {
            formatter.allowedUnits = [.weekOfMonth] //3 weeks
        } else if let day = interval.day, day > 0 {
            formatter.allowedUnits = [.day] // 6 days
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: Bundle.main.preferredLocalizations[0]) //--> IF THE USER HAVE THE PHONE IN SPANISH BUT YOUR APP ONLY SUPPORTS I.E. ENGLISH AND GERMAN WE SHOULD CHANGE THE LOCALE OF THE FORMATTER TO THE PREFERRED ONE (IS THE LOCALE THAT THE USER IS SEEING THE APP), IF NOT, THIS ELAPSED TIME IS GOING TO APPEAR IN SPANISH
            dateFormatter.dateStyle = .medium
            dateFormatter.doesRelativeDateFormatting = true
            
            dateString = dateFormatter.string(from: self) // IS GOING TO SHOW 'TODAY'
        }
        
        if dateString == nil {
            dateString = formatter.string(from: self, to: Date())
        }
        
        return dateString! + " ago"
    }
    
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.locale = Locale(identifier: "en_US")
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    func dateAddingNumberOfDays(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: noon)!
    }
    
    static var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date().noon)!
    }
    static var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date().noon)!
    }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var endOfDay: Date {
        return Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    
    var timeSinceDate:String {
        
        let interval = Calendar.current.dateComponents([.day, .hour, .minute], from: Date(), to: self)
        
        let day = interval.day ?? 0
        let hour = interval.hour ?? 0
        let minute = interval.minute ?? 0
        
        return "\(day)d:\(hour)h:\(minute)m"
    }
    
    var timeSinceDateDateHour:String {
        
        let interval = Calendar.current.dateComponents([.day, .hour, .minute], from: Date(), to: self)
        
        let day = interval.day ?? 0
        let hour = interval.hour ?? 0
        let minute = interval.minute ?? 0
        
        return "\(day)d:\(hour)h"
    }
    
}


// MARK: - Dictionary
extension Dictionary {
    
    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
    
    func merged(with dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(with: dictionary)
        return dict
    }
}

// MARK: - UILabel
extension UILabel{
    func addImage(name: String, afterText: Bool = false){
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: name)
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        
        if afterText{
            let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
            strLabelText.append(attachmentString)
            
            self.attributedText = strLabelText
        }else{
            let strLabelText: NSAttributedString = NSAttributedString(string: self.text!)
            let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            
            self.attributedText = mutableAttachmentString
        }
    }
    
    func addImage(image: UIImage, afterText: Bool = false){
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = image
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        
        if afterText{
            let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
            strLabelText.append(attachmentString)
            
            self.attributedText = strLabelText
        }else{
            let strLabelText: NSAttributedString = NSAttributedString(string: self.text!)
            let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            
            self.attributedText = mutableAttachmentString
        }
    }
    
    
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        let lines = Int(textSize.height/charSize)
        return lines
    }
    
}

extension UIDevice {
    static var isSimulator: Bool {
        return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
    }
}


@IBDesignable
class CityPickerButton: UIButton {
    
    @IBInspectable var leftHandImage: UIImage? {
        didSet {
            leftHandImage = leftHandImage?.withRenderingMode(.alwaysOriginal)
            setupImages()
        }
    }
    @IBInspectable var rightHandImage: UIImage? {
        didSet {
            rightHandImage = rightHandImage?.withRenderingMode(.alwaysTemplate)
            setupImages()
        }
    }
    
    func setupImages() {
        
        for view in self.subviews{
            if view.tag == 10 {
                view.removeFromSuperview()
            }
        }
        
        if let leftImage = leftHandImage {
            self.setImage(leftImage, for: .normal)
            self.imageView?.contentMode = .scaleAspectFill
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5 , bottom: 0, right: 20)
        }
        
        if let rightImage = rightHandImage {
            let rightImageView = UIImageView(image: rightImage)
            rightImageView.tintColor = .black
            rightImageView.tag = 10
            let height = CGFloat(6)
            let width = CGFloat(10)
            let xPos = self.frame.width - width - 15
            let yPos = (self.frame.height - height) / 2
            
            rightImageView.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
            self.addSubview(rightImageView)
        }
        
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 20)
    }
}

extension UICollectionView {
    
    var centerPoint : CGPoint {
        
        get {
            return CGPoint(x: self.center.x + self.contentOffset.x, y: self.center.y + self.contentOffset.y);
        }
    }
    
    var centerCellIndexPath: IndexPath? {
        
        if let centerIndexPath = self.indexPathForItem(at: self.centerPoint) {
            return centerIndexPath
        }
        return nil
    }
}

extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(Int(round(million*10)/10))M"
        }
        else if thousand >= 1.0 {
            return "\(Int(round(thousand*10)/10))K"
        }
        else {
            return "\(self)"
        }
    }
}

extension Double {

    var formattedPrice: String {
        let doubleString = self.isNaN ? "0.00" : String(format: "%.1f", self)
        return doubleString.replacingOccurrences(of: ".", with: ",")
    }
    
    var roundUpDouble:String {
        var doubleString = self.isNaN ? "0" : String(format: "%.2f", self)
        for i in 0...10{
            doubleString = (doubleString.replacingOccurrences(of: ".0\(i)", with: "") as NSString) as String
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let doubleValue = numberFormatter.string(from: NSNumber(value:Double(doubleString)!))!
        return doubleValue
    }
    
    var roundUpDoubleToThreeDigit:String {
        var doubleString = self.isNaN ? "0.00" : String(format: "%.3f", self)
        doubleString = (doubleString.replacingOccurrences(of: ".000", with: "") as NSString) as String
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:Double(doubleString)!))!
        
    }
    
    var roundUpDoubleToTwoDigit:String {
        
        let doubleString = self.isNaN ? "0.0" : String(format: "%.2f", self)
        //        doubleString = (doubleString.replacingOccurrences(of: ".00", with: "") as NSString) as String
        
        //        let numberFormatter = NumberFormatter()
        //        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return doubleString//numberFormatter.string(from: NSNumber(value:Double(doubleString)!))!
        
    }
    
    var roundUpDoubleToOneDigit:String {
        
        var doubleString = self.isNaN ? "0.0" : String(format: "%.1f", self)
        doubleString = (doubleString.replacingOccurrences(of: ".0", with: "") as NSString) as String
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:Double(doubleString)!))!
        
    }
    
    var checkNullAndFix:Double {
        return self.isNaN ? 0 : self
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}
extension UIPageViewController {
    var isPagingEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
}
extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension UIAlertController {

  //Set background color of UIAlertController
  func setBackgroudColor(color: UIColor) {
    if let bgView = self.view.subviews.first,
      let groupView = bgView.subviews.first,
      let contentView = groupView.subviews.first {
      contentView.backgroundColor = color
    }
  }

  //Set title font and title color
  func setTitle(font: UIFont?, color: UIColor?) {
    guard let title = self.title else { return }
    let attributeString = NSMutableAttributedString(string: title)//1
    if let titleFont = font {
      attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
        range: NSMakeRange(0, title.utf8.count))
    }
    if let titleColor = color {
      attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
        range: NSMakeRange(0, title.utf8.count))
    }
    self.setValue(attributeString, forKey: "attributedTitle")//4
  }

  //Set message font and message color
  func setMessage(font: UIFont?, color: UIColor?) {
    guard let title = self.message else {
      return
    }
    let attributedString = NSMutableAttributedString(string: title)
    if let titleFont = font {
      attributedString.addAttributes([NSAttributedString.Key.font : titleFont], range: NSMakeRange(0, title.utf8.count))
    }
    if let titleColor = color {
      attributedString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor], range: NSMakeRange(0, title.utf8.count))
    }
    self.setValue(attributedString, forKey: "attributedMessage")//4
  }

  //Set tint color of UIAlertController
  func setTint(color: UIColor) {
    self.view.tintColor = color
  }
}

extension String {
    func localized(tableName: String = "Localizable") -> String {
        if let languageCode = Locale.current.languageCode, let preferredLanguagesFirst = Locale.preferredLanguages.first?.prefix(2)  {
            if languageCode != preferredLanguagesFirst {
                if let path = Bundle.main.path(forResource: "en", ofType: "lproj") {
                    let bundle = Bundle.init(path: path)
                    return NSLocalizedString(self, tableName: tableName, bundle: bundle!, value: self, comment: "")
                }
            }
        }
        return NSLocalizedString(self, tableName: tableName, value: self, comment: "")
    }
}

var bundleKey: UInt8 = 0

class AnyLanguageBundle: Bundle {
    
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
              let bundle = Bundle(path: path) else {
            
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    class func setLanguage(_ language: String) {
        defer {
            object_setClass(Bundle.main, AnyLanguageBundle.self)
        }
        
        objc_setAssociatedObject(Bundle.main, &bundleKey,    Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
