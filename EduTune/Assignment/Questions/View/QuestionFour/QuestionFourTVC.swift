//
//  QuestionFourTVC.swift
//  EduTune
//
//  Created by DH on 18/12/22.
//

import Aztec
import Foundation
import MobileCoreServices
import Photos
import UIKit

class QuestionFourTVC: UITableViewCell {
    
    var viewModel: AssignmentsViewModel?
    var viewController: AssignmentsVC?
    
    lazy var optionsTablePresenter = OptionsTablePresenter(presentingViewController: viewController ?? UIViewController(), presentingTextView: richTextView)
    
    var richTextView: TextView{get{return editorView.richTextView}}
    var htmlTextView: UITextView {get{return editorView.htmlTextView}}
    
    let tableView: InnerTableView = {
        let tableView = InnerTableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    var defaultMissingImage: UIImage = {
        if #available(iOS 13.0, *) {
            return UIImage.init(systemName: "photo")!.withTintColor(.label)
        } else {
            return UIImage.init(systemName: "photo")!
        }
    }()
    
    fileprivate(set) lazy var editorView: Aztec.EditorView = {
        let defaultHTMLFont: UIFont
        defaultHTMLFont = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 14))
        let editorView = Aztec.EditorView(
            defaultFont: UIFont.systemFont(ofSize: 14),
            defaultHTMLFont: defaultHTMLFont,
            defaultParagraphStyle: .default,
            defaultMissingImage: defaultMissingImage)
        
        //editorView.backgroundColor = .yellow
        editorView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        editorView.clipsToBounds = true
        editorView.layer.borderColor = UIColor.lightGray.cgColor
        editorView.layer.borderWidth = 1
        editorView.layer.cornerRadius = 10
        setupHTMLTextView(editorView.htmlTextView)
        setupRichTextView(editorView.richTextView)
        return editorView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        MediaAttachment.defaultAppearance.progressColor = UIColor.blue
        MediaAttachment.defaultAppearance.progressBackgroundColor = UIColor.lightGray
        MediaAttachment.defaultAppearance.progressHeight = 2.0
        MediaAttachment.defaultAppearance.overlayColor = UIColor(red: CGFloat(46.0/255.0), green: CGFloat(69.0/255.0), blue: CGFloat(83.0/255.0), alpha: 0.6)
        
        backgroundColor = UIColor.white
        FileNameTVC.register(for: tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
   
        setUpViews()
        setupLayouts()
        
        editorView.richTextView.textContainer.lineFragmentPadding = 0
        
        if #available(iOS 13.0, *) {
            editorView.htmlTextView.textColor = UIColor.label
            editorView.richTextView.textColor = UIColor.label
            editorView.richTextView.blockquoteBackgroundColor = UIColor.secondarySystemBackground
            editorView.richTextView.preBackgroundColor = UIColor.secondarySystemBackground
            editorView.richTextView.blockquoteBorderColors = [.secondarySystemFill, .systemTeal, .systemBlue]
            var attributes = editorView.richTextView.linkTextAttributes
            attributes?[.foregroundColor] =  UIColor.link
        } else {
            backgroundColor = UIColor.white
        }
        
        editorView.becomeFirstResponder()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        addGestureRecognizer(tap)
        
    }
    
    private func setUpViews(){
        contentView.addSubview(editorView)
        contentView.addSubview(tableView)
    }
    
    private func setupLayouts() {
        
        editorView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        editorView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        editorView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        editorView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        tableView.topAnchor.constraint(equalTo: editorView.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    
    @objc func dismissKeyboard() {
        endEditing(true)
    }
    
    private func setupRichTextView(_ textView: TextView) {
        
        let accessibilityLabel = NSLocalizedString("Rich Content", comment: "Post Rich content")
        self.configureDefaultProperties(for: textView, accessibilityLabel: accessibilityLabel)
        
        textView.delegate = self
        textView.formattingDelegate = self
        textView.accessibilityIdentifier = "richContentView"
        textView.clipsToBounds = false
        textView.smartDashesType = .no
        textView.smartQuotesType = .no
        textView.backgroundColor = .white
        textView.isScrollEnabled = true
    }
    
    private func setupHTMLTextView(_ textView: UITextView) {
        let accessibilityLabel = NSLocalizedString("HTML Content", comment: "Post HTML content")
        self.configureDefaultProperties(htmlTextView: textView, accessibilityLabel: accessibilityLabel)
        
        textView.isHidden = true
        textView.delegate = self
        textView.accessibilityIdentifier = "HTMLContentView"
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.clipsToBounds = false
        textView.adjustsFontForContentSizeCategory = true
        textView.smartDashesType = .no
        textView.smartQuotesType = .no
        textView.backgroundColor = .white
        textView.isScrollEnabled = true
    }
    
    private func configureDefaultProperties(for textView: TextView, accessibilityLabel: String) {
        
        textView.accessibilityLabel = accessibilityLabel
        textView.font = Constants.defaultContentFont
        textView.keyboardDismissMode = .interactive
        
        if #available(iOS 13.0, *) {
            textView.textColor = UIColor.label
            textView.defaultTextColor = UIColor.label
        } else {
            // Fallback on earlier versions
            textView.textColor = UIColor(red: 0x1A/255.0, green: 0x1A/255.0, blue: 0x1A/255.0, alpha: 1)
            textView.defaultTextColor = UIColor(red: 0x1A/255.0, green: 0x1A/255.0, blue: 0x1A/255.0, alpha: 1)
        }
        textView.linkTextAttributes = [.foregroundColor: UIColor(red: 0x01 / 255.0, green: 0x60 / 255.0, blue: 0x87 / 255.0, alpha: 1), NSAttributedString.Key.underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)]
    }
    
    private func configureDefaultProperties(htmlTextView textView: UITextView, accessibilityLabel: String) {
        
        textView.accessibilityLabel = accessibilityLabel
        textView.font = Constants.defaultContentFont
        textView.keyboardDismissMode = .interactive
        
        if #available(iOS 13.0, *) {
            textView.textColor = UIColor.label
            if let htmlStorage = textView.textStorage as? HTMLStorage {
                htmlStorage.textColor = UIColor.label
            }
        } else {
            // Fallback on earlier versions
            textView.textColor = UIColor(red: 0x1A/255.0, green: 0x1A/255.0, blue: 0x1A/255.0, alpha: 1)
        }
        textView.linkTextAttributes = [.foregroundColor: UIColor(red: 0x01 / 255.0, green: 0x60 / 255.0, blue: 0x87 / 255.0, alpha: 1), NSAttributedString.Key.underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)]
    }
    
    fileprivate(set) lazy var formatBar: Aztec.FormatBar = {
        return self.createToolbar()
    }()
    
    
    func createToolbar() -> Aztec.FormatBar {
        
        //let mediaItem = makeToolbarButton(identifier: .media)
        let scrollableItems = scrollableItemsForToolbar
        let overflowItems = overflowItemsForToolbar
        
        let toolbar = Aztec.FormatBar()
        
        if #available(iOS 13.0, *) {
            toolbar.backgroundColor = UIColor.systemGroupedBackground
            toolbar.tintColor = UIColor.secondaryLabel
            toolbar.highlightedTintColor = UIColor.systemBlue
            toolbar.selectedTintColor = UIColor.systemBlue
            toolbar.disabledTintColor = .systemGray4
            toolbar.dividerTintColor = UIColor.separator
        } else {
            toolbar.tintColor = .gray
            toolbar.highlightedTintColor = .blue
            toolbar.selectedTintColor = .tintColor
            toolbar.disabledTintColor = .lightGray
            toolbar.dividerTintColor = .gray
        }
        
        toolbar.overflowToggleIcon = UIImage.init(systemName: "ellipsis")!
        toolbar.frame = CGRect(x: 0, y: 0, width: frame.width, height: 44.0)
        toolbar.autoresizingMask = [ .flexibleHeight ]
        toolbar.formatter = self
        
        //toolbar.leadingItem = mediaItem
        toolbar.setDefaultItems(scrollableItems,
                                overflowItems: overflowItems)
        
        toolbar.barItemHandler = { [weak self] item in
            self?.handleAction(for: item)
        }
        return toolbar
    }
    
    func updateFormatBar() {
        
        guard let toolbar = richTextView.inputAccessoryView as? Aztec.FormatBar else {
            return
        }
        
        let identifiers: Set<FormattingIdentifier>
        if richTextView.selectedRange.length > 0 {
            identifiers = richTextView.formattingIdentifiersSpanningRange(richTextView.selectedRange)
        } else {
            identifiers = richTextView.formattingIdentifiersForTypingAttributes()
        }
        
        toolbar.selectItemsMatchingIdentifiers(identifiers.map({ $0.rawValue }))
    }
    
    private func makeToolbarButton(identifier: FormattingIdentifier) -> FormatBarItem {
        
        let button = FormatBarItem(image: identifier.iconImage, identifier: identifier.rawValue)
        button.accessibilityLabel = identifier.accessibilityLabel
        button.accessibilityIdentifier = identifier.accessibilityIdentifier
        return button
    }
    
    private var scrollableItemsForToolbar: [FormatBarItem] {
        
        let headerButton = makeToolbarButton(identifier: .p)
        let listButton = makeToolbarButton(identifier: .unorderedlist)
        var listIcons = [String: UIImage]()
        for list in Constants.lists {
            listIcons[list.formattingIdentifier.rawValue] = list.iconImage
        }
        listButton.alternativeIcons = listIcons
        
        return [
            headerButton,
            listButton,
            //makeToolbarButton(identifier: .blockquote),
            makeToolbarButton(identifier: .bold),
            makeToolbarButton(identifier: .italic),
            makeToolbarButton(identifier: .link)
        ]
    }
    
    private var overflowItemsForToolbar: [FormatBarItem] {
        return [
            makeToolbarButton(identifier: .underline),
            makeToolbarButton(identifier: .strikethrough),
            //makeToolbarButton(identifier: .code),
            //makeToolbarButton(identifier: .horizontalruler),
            //makeToolbarButton(identifier: .more),
            //makeToolbarButton(identifier: .sourcecode)
        ]
    }
    
    @objc func alertTextFieldDidChange(_ textField: UITextField) {
        guard
            let alertController = viewController?.presentedViewController as? UIAlertController,
            let urlFieldText = alertController.textFields?.first?.text,
            let insertAction = alertController.actions.first
        else {
            return
        }
        insertAction.isEnabled = !urlFieldText.isEmpty
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuestionFourTVC: AssignmentsDelegate {
    
    func setHtmlTextAsAnswer() {
        
        editorView.toggleEditingMode()
        let htmlText = viewModel?.getHtmlTextFrom(richText: htmlTextView.text)
   
        guard let model = viewModel else {return}
        viewModel?.questionsModel?.questionItems?[model.questionIndex].answer = htmlText ?? ""
        dismissKeyboard()
    }
    func updateUploadedImages() {
        tableView.reloadData()
    }
}



extension QuestionFourTVC : Aztec.TextViewFormattingDelegate {
    func textViewCommandToggledAStyle() {
        updateFormatBar()
    }
}

extension  QuestionFourTVC {
    
    static var tintedMissingImage: UIImage = {
        if #available(iOS 13.0, *) {
            return UIImage.init(systemName: "photo")!.withTintColor(.label)
        } else {
            // Fallback on earlier versions
            return UIImage.init(systemName: "photo")!
        }
    }()
    
    struct Constants {
        static let defaultContentFont   = UIFont.systemFont(ofSize: 14)
        static let defaultHtmlFont      = UIFont.systemFont(ofSize: 24)
        static let defaultMissingImage  = tintedMissingImage
        static let formatBarIconSize    = CGSize(width: 20.0, height: 20.0)
        static let headers              = [Header.HeaderType.none, .h1, .h2, .h3, .h4, .h5, .h6]
        static let lists                = [TextList.Style.unordered, .ordered]
        static let moreAttachmentText   = "more"
        static let titleInsets          = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        static var mediaMessageAttributes: [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15, weight: .semibold),
                                                             .paragraphStyle: paragraphStyle,
                                                             .foregroundColor: UIColor.white]
            return attributes
        }
    }
}

extension UIImage {
    
    static func systemImage(_ name: String) -> UIImage {
        guard let image = UIImage(systemName: name) else {
            assertionFailure("Missing system image: \(name)")
            return UIImage()
        }
        
        return image
    }
}

extension QuestionFourTVC  : Aztec.FormatBarDelegate {
    
    func formatBarTouchesBegan(_ formatBar: FormatBar) {}
    
    func formatBar(_ formatBar: FormatBar, didChangeOverflowState state: FormatBarOverflowState) {
        switch state {
        case .hidden:
            print("Format bar collapsed")
        case .visible:
            print("Format bar expanded")
        }
    }
}
extension TextList.Style {
    
    var formattingIdentifier: FormattingIdentifier {
        switch self {
        case .ordered:   return FormattingIdentifier.orderedlist
        case .unordered: return FormattingIdentifier.unorderedlist
        }
    }
    
    var description: String {
        switch self {
        case .ordered: return "Ordered List"
        case .unordered: return "Unordered List"
        }
    }
    
    var iconImage: UIImage? {
        return formattingIdentifier.iconImage
    }
}
extension Header.HeaderType {
    
    var formattingIdentifier: FormattingIdentifier {
        switch self {
        case .none: return FormattingIdentifier.p
        case .h1:   return FormattingIdentifier.header1
        case .h2:   return FormattingIdentifier.header2
        case .h3:   return FormattingIdentifier.header3
        case .h4:   return FormattingIdentifier.header4
        case .h5:   return FormattingIdentifier.header5
        case .h6:   return FormattingIdentifier.header6
        }
    }
    
    var description: String {
        switch self {
        case .none: return NSLocalizedString("Default", comment: "Description of the default paragraph formatting style in the editor.")
        case .h1: return "Heading 1"
        case .h2: return "Heading 2"
        case .h3: return "Heading 3"
        case .h4: return "Heading 4"
        case .h5: return "Heading 5"
        case .h6: return "Heading 6"
        }
    }
    var iconImage: UIImage? {
        return formattingIdentifier.iconImage
    }
}



