//
//  LoginViewController.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 05/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController,UIGestureRecognizerDelegate {
    
    // MARK: - Outlets
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var transparentView: UIView!
    @IBOutlet var switcherUsername: UISwitch!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var lblSaveUsername: UILabel!
    @IBOutlet var btnForgetCredentials: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        if StaticHelper.isObjectNotNil(object: UserDefaults.standard.object(forKey: "userName") as AnyObject!){
            let name : String = UserDefaults.standard.object(forKey: "userName") as! String
            
            if name.characters.count > 0 {
                txtUserName.text = UserDefaults.standard.object(forKey: "userName") as? String
            }
            
        }
        
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
    
    ///*******************************************************
    // MARK: - UITextField Private Methods
    ///*******************************************************
    
    func handleTap(gesture: UITapGestureRecognizer) {
        
        txtPassword.resignFirstResponder()
        txtUserName.resignFirstResponder()
    }
    
    
    ///*******************************************************
    // MARK: - API Methods
    ///*******************************************************
    func signIn(){
        
        txtUserName.resignFirstResponder()
        txtPassword.resignFirstResponder()
        
        if !StaticHelper.sharedInstance.checkNetworkStatus() {
            StaticHelper.sharedInstance.showAlertViewWithTitle("", message: "Internet is offline. Please check & try again after Internet is connected.", buttonTitles: ["OK"], viewController: self, completion: nil)
            return
        }
        
        
        let dict : [String:String] =
            ["login":txtUserName.text!,"password":txtPassword.text!,"logout_redirect":"talentlms.com"]
        
        Alamofire.request(URL(string: baseURL + "userlogin")!, method: .post, parameters: dict,  headers: nil).authenticate(user: apiKey, password: "").responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    StaticHelper.sharedInstance.stopLoader()
                    
                    let dict : [String:Any] = response.result.value as! [String:Any]
                    
                    if let val : [String:Any] = dict["error"] as? [String : Any]{
                        
                        
                        StaticHelper.sharedInstance.showAlertViewWithTitle("", message: val["message"] as! String, buttonTitles: ["OK"], viewController: self, completion: nil)
                    }
                    else{
                        UserCache.sharedInstance.saveUserData(dict)
                        
                        
                        
                        let navVC : UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "HomeNavController") as! UINavigationController
                        
                        let vc: CoursesViewController = self.storyboard?.instantiateViewController(withIdentifier: "CoursesVC") as! CoursesViewController
                        
                        _ = UINavigationController(rootViewController: vc)
                        
                        self.navigationController?.present(navVC, animated: false, completion: nil)
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
    
    
    ///*******************************************************
    // MARK: - UIButton/UISwitch Action Methods
    ///*******************************************************
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        
        if switcherUsername.isOn {
            UserDefaults.standard.set(txtUserName.text!, forKey: "userName")
        }
        
        
        if (txtUserName.text?.characters.count)! > 0 && (txtPassword.text?.characters.count)! > 0{
            StaticHelper.sharedInstance.startLoader(view: view)
            
            signIn()
        }
        else{
            StaticHelper.sharedInstance.showAlertViewWithTitle("", message: "Please enter valid credentials", buttonTitles: ["OK"], viewController: self, completion: nil)
        }
        
    }
    
    @IBAction func btnForgotTapped(_ sender: UIButton) {
        
        let vc : ForgetCredentialsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgetCredentialsVC") as! ForgetCredentialsViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func switcherUsernameTapped(_ sender: UISwitch) {
        
        if (!switcherUsername.isOn){
            
            switcherUsername.setOn(false, animated: true)
            UserDefaults.standard.set("", forKey: "userName")
            
        }
        else{
            switcherUsername.setOn(true, animated: true)
            UserDefaults.standard.set(txtUserName.text!, forKey: "userName")
        }
        
    }
    
    ///*******************************************************
    // MARK: - Private Methods
    ///*******************************************************
    
    func setUpUI(){
        
        txtUserName.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName: UIColor(red: (4.0/255.0), green: (220.0/255.0), blue: (244.0/255.0), alpha: 1.0),NSFontAttributeName:UIFont.getCustomFont_ForSize(size: 10.0)])
        txtUserName.textColor = UIColor(red: (4.0/255.0), green: (220.0/255.0), blue: (244.0/255.0), alpha: 1.0)
        txtUserName.tintColor = .white
        
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor(red: (4.0/255.0), green: (220.0/255.0), blue: (244.0/255.0), alpha: 1.0),NSFontAttributeName:UIFont.getCustomFont_ForSize(size: 10.0)])
        txtPassword.textColor = UIColor(red: (4.0/255.0), green: (220.0/255.0), blue: (244.0/255.0), alpha: 1.0)
        txtPassword.tintColor = .white
        
        transparentView.layer.cornerRadius = 6.0
        transparentView.layer.masksToBounds = true
        
        switcherUsername.setOn(true, animated: true)
        
        indicator.isHidden = true
        
        // Set Font
        lblSaveUsername.font = UIFont.getCustomFont_ForSize(size: 9.0)
        btnForgetCredentials.titleLabel?.font = UIFont.getCustomFont_ForSize(size: 10.0)
        
        
        txtUserName.font = UIFont.getCustomFont_ForSize(size: 10.0)
        txtPassword.font = UIFont.getCustomFont_ForSize(size: 10.0)
        
    }
    
}
