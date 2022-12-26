//
//  InvoiceVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 25/12/22.
//

import UIKit
import WebKit

class InvoiceVC: UIViewController {
    @IBOutlet weak var contentView: UIView!
    
    var invoice: Invoice?
    var invoiceHtml: String?
    var webPageView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInvoice()
        
    }
    
    func getInvoice() {
        let params = ["user_id": AppUserDefault.getUserId(), "invoice_id": invoice?.id ?? -1]
        APIService.shared.getInvoice(params: params, completion: { invoice in
            self.invoiceHtml = invoice
            self.loadHTML(invoice)
        })
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onExportButtonTap(_ sender: Any) {
       
        let data = createPDF(html: invoiceHtml ?? "", formmatter: webPageView.viewPrintFormatter(), filename: "\(invoice?.id ?? 0)")

        let activityViewController = UIActivityViewController(activityItems: [ data ], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func loadHTML(_ html: String) {
        
        let topPadding = AppDelegate.shared().topInset
        let bottomPadding = AppDelegate.shared().bottomInset
        
        let screenSize = UIScreen.main.bounds.size
        
        let frame = CGRect(x: 0, y: 0, width: screenSize.width-32, height: screenSize.height-topPadding-bottomPadding-150);

        let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width', shrink-to-fit=YES); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        let wkUScript = WKUserScript(source: jScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let wkUController = WKUserContentController()
        wkUController.addUserScript(wkUScript)
        
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        
        webPageView = WKWebView(frame: frame, configuration: wkWebConfig)
        
        self.contentView.addSubview(webPageView)
        
        webPageView.loadHTMLString(html, baseURL: nil)
        
    }
    
    func createPDF(html: String, formmatter: UIViewPrintFormatter, filename: String) -> NSMutableData {
            let render = UIPrintPageRenderer()
            render.addPrintFormatter(formmatter, startingAtPageAt: 0)

            let page = CGRect(x: 15, y: 40, width: 595.2, height: 841.8) // A4, 72 dpi
            let printable = page.insetBy(dx: 0, dy: 0)

            render.setValue(NSValue(cgRect: page), forKey: "paperRect")
            render.setValue(NSValue(cgRect: printable), forKey: "printableRect")

            let pdfData = NSMutableData()
            UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)

            for i in 1...render.numberOfPages {
                UIGraphicsBeginPDFPage();
                let bounds = UIGraphicsGetPDFContextBounds()
                render.drawPage(at: i - 1, in: bounds)
            }

            UIGraphicsEndPDFContext();
            return pdfData
        }
    
}
