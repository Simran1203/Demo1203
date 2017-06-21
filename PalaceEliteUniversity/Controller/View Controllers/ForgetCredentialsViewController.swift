//
//  ForgetCredentialsViewController.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 12/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit
import Alamofire

class ForgetCredentialsViewController: UIViewController,UIGestureRecognizerDelegate {
    
    // MARK: - Outlets
    @IBOutlet var txtField: UITextField!
    @IBOutlet var imgTxtField: UIImageView!
    @IBOutlet var lblHeading: UILabel!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var transparentView: UIView!
    @IBOutlet var btnForgot: UIButton!
    
    @IBOutlet var btnUsername: UIButton!
    
    @IBOutlet var btnPassword: UIButton!
    
    // MARK: - Variables
    var viewType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        viewType = "Username"
        
        txtField.textColor = UIColor(red: (4.0/255.0), green: (220.0/255.0), blue: (244.0/255.0), alpha: 1.0)
        txtField.tintColor = .white
        
        // Set Font
        lblHeading.font = UIFont.getCustomFont_ForSize(size: 19.0)
        lblDesc.font = UIFont.getCustomFont_ForSize(size: 12.0)
        btnForgot.titleLabel?.font = UIFont.getCustomFont_ForSize(size: 13.0)
        
        updateUI()
        
        //Tap on Screen hides keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    ///*******************************************************
    // MARK: - UITextField Delegate Methods
    ///*******************************************************
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        
        txtField.resignFirstResponder()
    }
    
    
    ///*******************************************************
    // MARK: - Private  Methods
    ///*******************************************************
    func updateUI(){
        
        transparentView.layer.cornerRadius = 6.0
        transparentView.layer.masksToBounds = true
        
        txtField.text = ""
        txtField.font = UIFont.getCustomFont_ForSize(size: 9.0)
        
        //Set Up Get Username Screen
        if viewType == "Username" {
            lblDesc.text = "Enter your email we’ll validate it and send  your Username to the address we have for your account"
            lblHeading.text = "Get Username"
            txtField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName: UIColor(red: (4.0/255.0), green: (220.0/255.0), blue: (244.0/255.0), alpha: 1.0),NSFontAttributeName:UIFont.getCustomFont_ForSize(size: 9.0)])
            imgTxtField.image = UIImage(named: "email_icon")
            btnUsername.isHidden = false
            btnPassword.isHidden = true
            
            btnForgot.setTitle("Forgot Password?", for: .normal)
        }
            
            //Set Up Reset Password Screen
        else{
            lblHeading.text = "Reset Password"
            lblDesc.text = "Enter your Username and we’ll send a link to reset your password to the address we have for your account"
            txtField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName: UIColor(red: (4.0/255.0), green: (220.0/255.0), blue: (244.0/255.0), alpha: 1.0),NSFontAttributeName:UIFont.getCustomFont_ForSize(size: 9.0)])
            imgTxtField.image = UIImage(named: "userIcon")
            btnUsername.isHidden = true
            btnPassword.isHidden = false
            btnForgot.setTitle("Forgot Username?", for: .normal)
        }
        
    }
    
    
    ///*******************************************************
    // MARK: - UIButton Action  Methods
    ///*******************************************************
    
    @IBAction func btnForgetTapped(_ sender: UIButton) {
        
        
        if viewType == "Username" {
            viewType = "Password"
        }
        else{
            viewType = "Username"
        }
        
        updateUI()
        
    }
    
    
    @IBAction func btnUsernameTapped(_ sender: UIButton) {
        
        txtField.resignFirstResponder()
        
        if (txtField.text?.characters.count)! > 0 && StaticHelper.sharedInstance.isValidEmail(txtField.text!){
            
            forgotUsername()
        }
        else{
            StaticHelper.sharedInstance.showAlertViewWithTitle("", message: "Please enter valid email address", buttonTitles: ["OK"], viewController: self, completion: nil)
        }
    }
    
    
    
    @IBAction func btnPasswordTapped(_ sender: UIButton) {
        
        txtField.resignFirstResponder()
        
        if (txtField.text?.characters.count)! > 0 {
            
            forgotPassword()
        }
        else{
            StaticHelper.sharedInstance.showAlertViewWithTitle("", message: "Please enter valid username", buttonTitles: ["OK"], viewController: self, completion: nil)
        }
    }
    
    
    
    
    @IBAction func btnBackTaed(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    ///*******************************************************
    // MARK: - API  Methods
    ///*******************************************************
    func forgotUsername(){
        
        if !StaticHelper.sharedInstance.checkNetworkStatus() {
            StaticHelper.sharedInstance.showAlertViewWithTitle("", message: "Internet is offline. Please check & try again after Internet is connected.", buttonTitles: ["OK"], viewController: self, completion: nil)
            return
        }
        
        
        StaticHelper.sharedInstance.startLoader(view: view)
        
        let str : String = (txtField.text?.replacingOccurrences(of: " ", with: "_"))!
        
        
        Alamofire.request(URL(string: baseURL + "forgotusername/email:" + str)!, method: .post, parameters: nil,  headers: nil).authenticate(user: apiKey, password: "").responseJSON { (response:DataResponse<Any>) in
            
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    
                    StaticHelper.sharedInstance.stopLoader()
                    let dict : [String:Any] = response.result.value as! [String:Any]
                    
                    if let val : [String:Any] = dict["error"] as? [String : Any]{
                        
                        StaticHelper.sharedInstance.showAlertViewWithTitle("", message: val["message"] as! String, buttonTitles: ["OK"], viewController: self, completion:  { (index) in
                            
                            _ = self.navigationController?.popViewController(animated: true)
                        })
                    }
                    else{
                        StaticHelper.sharedInstance.showAlertViewWithTitle("", message: "Email sent successfully. Please check your mail", buttonTitles: ["OK"], viewController: self, completion:  { (index) in
                            
                            _ = self.navigationController?.popViewController(animated: true)
                        })
                    }
                    
                }
                break
                
            case .failure(_):
                StaticHelper.sharedInstance.stopLoader()
                print(response.result.error ?? "")
                break
                
            }
        }
    }
    
    func forgotPassword(){
        
        if !StaticHelper.sharedInstance.checkNetworkStatus() {
            StaticHelper.sharedInstance.showAlertViewWithTitle("", message: "Internet is offline. Please check & try again after Internet is connected.", buttonTitles: ["OK"], viewController: self, completion: nil)
            return
        }
        
        StaticHelper.sharedInstance.startLoader(view: view)
        
        print(txtField.text ?? "")
        
        print(baseURL + "forgotpassword/username:" + txtField.text!)
        
        let str : String = (txtField.text?.replacingOccurrences(of: " ", with: "_"))!
        
        Alamofire.request(URL(string: baseURL + "forgotpassword/username:" + str)!, method: .post, parameters: nil,  headers: nil).authenticate(user: apiKey, password: "").responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    
                    StaticHelper.sharedInstance.stopLoader()
                    let dict : [String:Any] = response.result.value as! [String:Any]
                    
                    if let val : [String:Any] = dict["error"] as? [String : Any]{
                        
                        StaticHelper.sharedInstance.showAlertViewWithTitle("", message: val["message"] as! String, buttonTitles: ["OK"], viewController: self, completion:  { (index) in
                            
                            _ = self.navigationController?.popViewController(animated: true)
                        })
                    }
                    else{
                        StaticHelper.sharedInstance.showAlertViewWithTitle("", message: "Email sent successfully. Please check your mail", buttonTitles: ["OK"], viewController: self, completion: { (index) in
                            
                            _ = self.navigationController?.popViewController(animated: true)
                        })
                    }
                    
                }
                break
                
            case .failure(_):
                
                StaticHelper.sharedInstance.stopLoader()
                print(response.result.error ?? "")
                break
                
            }
        }
    }
}
