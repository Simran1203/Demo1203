//
//  PortalWebViewController.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 13/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit

class PortalWebViewController: UIViewController,UIWebViewDelegate {

    // MARK: - Outlets
    @IBOutlet var webView: UIWebView!
   
    // MARK: - Variables
    var strURl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///*******************************************************
    // MARK: - UINavigation Bar Action Methods
    ///*******************************************************

    func tapLeftBarButton(_ sender:UIButton)  {
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    ///*******************************************************
    // MARK: - WebView Methods
    ///*******************************************************

    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        StaticHelper.sharedInstance.stopLoader()
    }
    
    ///*******************************************************
    // MARK: - Private Methods
    ///*******************************************************
    
    func callWebView() {
        webView.loadRequest(URLRequest(url: URL(string: strURl)!))
    }
    
    func setUpUI(){
        title = "PALACE ELITE UNIVERSITY"
        
        navigationItem.leftBarButtonItem = StaticHelper.sharedInstance.leftNavigationBarButton("back_arrow_white", viewController: self)
        
        if !StaticHelper.sharedInstance.checkNetworkStatus() {
            
            StaticHelper.sharedInstance.showAlertViewWithTitle("", message:"Internet is offline. Please check & try again after Internet is connected.", buttonTitles: ["OK"], viewController: self, completion: nil)
        }
        else {
            StaticHelper.sharedInstance.startLoader(view: view)
            callWebView()
        }
        
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
    }
}
