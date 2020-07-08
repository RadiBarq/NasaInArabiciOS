//
//  WebViewController.swift
//  NasaInArabic
//
//  Created by Radi Barq on 1/23/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    public var url:String?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: url!)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        webView.frame = self.view.frame
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onClickClose))
        self.navigationItem.leftBarButtonItem = closeButton
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func onClickClose()
    {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
