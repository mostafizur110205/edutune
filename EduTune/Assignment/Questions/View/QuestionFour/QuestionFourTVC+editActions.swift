//
//  QuestionFourTVC+editActions.swift
//  EduTune
//
//  Created by DH on 10/1/23.
//

import Aztec
import Foundation
import MobileCoreServices

extension QuestionFourTVC {
    
    func handleAction(for barItem: FormatBarItem) {
        
        guard let identifier = barItem.identifier,
              let formattingIdentifier = FormattingIdentifier(rawValue: identifier) else {
            return
        }
        
        switch formattingIdentifier {
        case .bold:
            toggleBold()
        case .italic:
            toggleItalic()
        case .underline:
            toggleUnderline()
        case .strikethrough:
            toggleStrikethrough()
        case .blockquote:
            toggleBlockquote()
        case .unorderedlist, .orderedlist:
            toggleList(fromItem: barItem)
            break
        case .link:
            toggleLink()
        case .media:
            break
        case .sourcecode:
            toggleEditingMode()
            break
        case .p, .header1, .header2, .header3, .header4, .header5, .header6:
            toggleHeader(fromItem: barItem)
            break
        case .more:
            insertMoreAttachment()
        case .horizontalruler:
            insertHorizontalRuler()
        case .code:
            toggleCode()
        default:
            break
        }
        updateFormatBar()
    }
    
    @IBAction func toggleEditingMode() {
        formatBar.overflowToolbar(expand: true)
        editorView.toggleEditingMode()
    }
    
    @objc func toggleBold() {
        richTextView.toggleBold(range: richTextView.selectedRange)
    }
    
    
    @objc func toggleItalic() {
        richTextView.toggleItalic(range: richTextView.selectedRange)
    }
    
    
    func toggleUnderline() {
        richTextView.toggleUnderline(range: richTextView.selectedRange)
    }
    
    
    @objc func toggleStrikethrough() {
        richTextView.toggleStrikethrough(range: richTextView.selectedRange)
    }
    
    @objc func toggleBlockquote() {
        richTextView.toggleBlockquote(range: richTextView.selectedRange)
    }
    
    @objc func toggleCode() {
        richTextView.toggleCode(range: richTextView.selectedRange)
    }
    
    func insertHorizontalRuler() {
        richTextView.replaceWithHorizontalRuler(at: richTextView.selectedRange)
    }
    
    func toggleHeader(fromItem item: FormatBarItem) {
        
        guard !optionsTablePresenter.isOnScreen() else {
            optionsTablePresenter.dismiss()
            return
        }
        
        let options = Constants.headers.map { headerType -> OptionsTableViewOption in
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: CGFloat(headerType.fontSize))
            ]
            
            let title = NSAttributedString(string: headerType.description, attributes: attributes)
            return OptionsTableViewOption(image: headerType.iconImage, title: title)
        }
        
        let selectedIndex = Constants.headers.firstIndex(of: headerLevelForSelectedText())
        let optionsTableViewController = OptionsTableViewController(options: options)
        optionsTableViewController.cellDeselectedTintColor = .gray
        
        optionsTablePresenter.present(
            optionsTableViewController,
            fromBarItem: item,
            selectedRowIndex: selectedIndex,
            onSelect: { [weak self] selected in
                guard let range = self?.richTextView.selectedRange else {
                    return
                }
                
                self?.richTextView.toggleHeader(Constants.headers[selected], range: range)
                self?.optionsTablePresenter.dismiss()
            })
    }
    
    func toggleList(fromItem item: FormatBarItem) {
        
        guard !optionsTablePresenter.isOnScreen() else {
            optionsTablePresenter.dismiss()
            return
        }
        
        let options = Constants.lists.map { (listType) -> OptionsTableViewOption in
            return OptionsTableViewOption(image: listType.iconImage, title: NSAttributedString(string: listType.description, attributes: [:]))
        }
        
        var index: Int? = nil
        if let listType = listTypeForSelectedText() {
            index = Constants.lists.firstIndex(of: listType)
        }
        
        let optionsTableViewController = OptionsTableViewController(options: options)
        optionsTableViewController.cellDeselectedTintColor = .gray
        
        optionsTablePresenter.present(
            optionsTableViewController,
            fromBarItem: item,
            selectedRowIndex: index,
            onSelect: { [weak self] selected in
                guard let range = self?.richTextView.selectedRange else { return }
                
                let listType = Constants.lists[selected]
                switch listType {
                case .unordered:
                    self?.richTextView.toggleUnorderedList(range: range)
                case .ordered:
                    self?.richTextView.toggleOrderedList(range: range)
                }
                
                self?.optionsTablePresenter.dismiss()
            })
    }
    
    
    @objc func toggleUnorderedList() {
        richTextView.toggleUnorderedList(range: richTextView.selectedRange)
    }
    
    @objc func toggleOrderedList() {
        richTextView.toggleOrderedList(range: richTextView.selectedRange)
    }
    
    func changeRichTextInputView(to: UIView?) {
        if richTextView.inputView == to {
            return
        }
        
        richTextView.inputView = to
        richTextView.reloadInputViews()
    }
    
    func headerLevelForSelectedText() -> Header.HeaderType {
        var identifiers = Set<FormattingIdentifier>()
        if (richTextView.selectedRange.length > 0) {
            identifiers = richTextView.formattingIdentifiersSpanningRange(richTextView.selectedRange)
        } else {
            identifiers = richTextView.formattingIdentifiersForTypingAttributes()
        }
        let mapping: [FormattingIdentifier: Header.HeaderType] = [
            .header1 : .h1,
            .header2 : .h2,
            .header3 : .h3,
            .header4 : .h4,
            .header5 : .h5,
            .header6 : .h6,
        ]
        for (key,value) in mapping {
            if identifiers.contains(key) {
                return value
            }
        }
        return .none
    }
    
    func listTypeForSelectedText() -> TextList.Style? {
        var identifiers = Set<FormattingIdentifier>()
        if (richTextView.selectedRange.length > 0) {
            identifiers = richTextView.formattingIdentifiersSpanningRange(richTextView.selectedRange)
        } else {
            identifiers = richTextView.formattingIdentifiersForTypingAttributes()
        }
        let mapping: [FormattingIdentifier: TextList.Style] = [
            .orderedlist : .ordered,
            .unorderedlist : .unordered
        ]
        for (key,value) in mapping {
            if identifiers.contains(key) {
                return value
            }
        }
        
        return nil
    }
    
    @objc func toggleLink() {
        var linkTitle = ""
        var linkURL: URL? = nil
        var linkRange = richTextView.selectedRange
        // Let's check if the current range already has a link assigned to it.
        if let expandedRange = richTextView.linkFullRange(forRange: richTextView.selectedRange) {
            linkRange = expandedRange
            linkURL = richTextView.linkURL(forRange: expandedRange)
        }
        let target = richTextView.linkTarget(forRange: richTextView.selectedRange)
        linkTitle = richTextView.attributedText.attributedSubstring(from: linkRange).string
        let allowTextEdit = !richTextView.attributedText.containsAttachments(in: linkRange)
        showLinkDialog(forURL: linkURL, text: linkTitle, target: target, range: linkRange, allowTextEdit: allowTextEdit)
    }
    
    func insertMoreAttachment() {
        richTextView.replace(richTextView.selectedRange, withComment: Constants.moreAttachmentText)
    }
    
    func showLinkDialog(forURL url: URL?, text: String?, target: String?, range: NSRange, allowTextEdit: Bool = true) {
        
        let isInsertingNewLink = (url == nil)
        var urlToUse = url
        
        if isInsertingNewLink {
            let pasteboard = UIPasteboard.general
            if let pastedURL = pasteboard.value(forPasteboardType:String(kUTTypeURL)) as? URL {
                urlToUse = pastedURL
            }
        }
        
        let insertButtonTitle = isInsertingNewLink ? NSLocalizedString("Insert Link", comment:"Label action for inserting a link on the editor") : NSLocalizedString("Update Link", comment:"Label action for updating a link on the editor")
        let removeButtonTitle = NSLocalizedString("Remove Link", comment:"Label action for removing a link from the editor");
        let cancelButtonTitle = NSLocalizedString("Cancel", comment:"Cancel button")
        
        let alertController = UIAlertController(title:insertButtonTitle,
                                                message:nil,
                                                preferredStyle:UIAlertController.Style.alert)
        alertController.view.accessibilityIdentifier = "linkModal"
        
        alertController.addTextField(configurationHandler: { [weak self]textField in
            textField.clearButtonMode = UITextField.ViewMode.always;
            textField.placeholder = NSLocalizedString("URL", comment:"URL text field placeholder");
            textField.keyboardType = .URL
            textField.textContentType = .URL
            textField.text = urlToUse?.absoluteString
            
            textField.addTarget(self,
                                action:#selector(QuestionFourTVC.alertTextFieldDidChange),
                                for:UIControl.Event.editingChanged)
            
            textField.accessibilityIdentifier = "linkModalURL"
        })
        
        if allowTextEdit {
            alertController.addTextField(configurationHandler: { textField in
                textField.clearButtonMode = UITextField.ViewMode.always
                textField.placeholder = NSLocalizedString("Link Text", comment:"Link text field placeholder")
                textField.isSecureTextEntry = false
                textField.autocapitalizationType = UITextAutocapitalizationType.sentences
                textField.autocorrectionType = UITextAutocorrectionType.default
                textField.spellCheckingType = UITextSpellCheckingType.default
                
                textField.text = text;
                
                textField.accessibilityIdentifier = "linkModalText"
                
            })
        }
        
        alertController.addTextField(configurationHandler: { textField in
            textField.clearButtonMode = UITextField.ViewMode.always
            textField.placeholder = NSLocalizedString("Target", comment:"Link text field placeholder")
            textField.isSecureTextEntry = false
            textField.autocapitalizationType = UITextAutocapitalizationType.sentences
            textField.autocorrectionType = UITextAutocorrectionType.default
            textField.spellCheckingType = UITextSpellCheckingType.default
            
            textField.text = target;
            
            textField.accessibilityIdentifier = "linkModalTarget"
            
        })
        
        let insertAction = UIAlertAction(title:insertButtonTitle,
                                         style:UIAlertAction.Style.default,
                                         handler:{ [weak self]action in
            
            self?.richTextView.becomeFirstResponder()
            guard let textFields = alertController.textFields else {
                return
            }
            let linkURLField = textFields[0]
            let linkTextField = textFields[1]
            let linkTargetField = textFields[2]
            let linkURLString = linkURLField.text
            var linkTitle = linkTextField.text
            let target = linkTargetField.text
            
            if  linkTitle == nil  || linkTitle!.isEmpty {
                linkTitle = linkURLString
            }
            
            guard
                let urlString = linkURLString,
                let url = URL(string:urlString)
            else {
                return
            }
            if allowTextEdit {
                if let title = linkTitle {
                    self?.richTextView.setLink(url, title: title, target: target, inRange: range)
                }
            } else {
                self?.richTextView.setLink(url, target: target, inRange: range)
            }
        })
        
        insertAction.accessibilityLabel = "insertLinkButton"
        
        let removeAction = UIAlertAction(title:removeButtonTitle,
                                         style:UIAlertAction.Style.destructive,
                                         handler:{ [weak self] action in
            self?.richTextView.becomeFirstResponder()
            self?.richTextView.removeLink(inRange: range)
        })
        
        let cancelAction = UIAlertAction(title: cancelButtonTitle,
                                         style:UIAlertAction.Style.cancel,
                                         handler:{ [weak self]action in
            self?.richTextView.becomeFirstResponder()
        })
        
        alertController.addAction(insertAction)
        if !isInsertingNewLink {
            alertController.addAction(removeAction)
        }
        alertController.addAction(cancelAction)
        
        // Disabled until url is entered into field
        if let text = alertController.textFields?.first?.text {
            insertAction.isEnabled = !text.isEmpty
        }
        
        viewController?.present(alertController, animated:true, completion:nil)
    }
}
