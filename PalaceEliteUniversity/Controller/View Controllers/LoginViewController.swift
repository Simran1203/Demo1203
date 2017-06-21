//
//  LoginViewController.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 05/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var transparentView: UIView!
    @IBOutlet var switcherUsername: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtUserName.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName: UIColor.white])
        txtUserName.textColor = UIColor(red: (4.0/255.0), green: (220.0/255.0), blue: (244.0/255.0), alpha: 1.0)
        txtUserName.tintColor = .white
        
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.white])
        txtPassword.textColor = UIColor(red: (4.0/255.0), green: (220.0/255.0), blue: (244.0/255.0), alpha: 1.0)
        txtPassword.tintColor = .white
        
        transparentView.layer.cornerRadius = 6.0
        transparentView.layer.masksToBounds = true
        
        
        if StaticHelper.isObjectNotNil(object: UserDefaults.standard.object(forKey: "userName") as AnyObject!){
            txtUserName.text = UserDefaults.standard.object(forKey: "user_name") as! String?
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnLoginTapped(_ sender: Any) {
        
          signIn()
        
        UserDefaults.standard.set(txtUserName.text!, forKey: "userName")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func signIn(){
        
        let dict : [String:String] =
        ["login":txtUserName.text!,"password":txtPassword.text!,"logout_redirect":"talentlms.com"]
        
        Alamofire.request(URL(string: baseURL + "userlogin")!, method: .post, parameters: dict,  headers: nil).authenticate(user: apiKey, password: "").responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    
                    let dict : [String:Any] = response.result.value as! [String:Any]
                
                    UserCache.sharedInstance.saveUserData(dict)
                    
                    let navVC : UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "HomeNavController") as! UINavigationController
                    
                    let vc: CoursesViewController = self.storyboard?.instantiateViewController(withIdentifier: "CoursesVC") as! CoursesViewController
                    
                    _ = UINavigationController(rootViewController: vc)
                    
                    self.navigationController?.present(navVC, animated: false, completion: nil)
                
                }
                break
                
            case .failure(_):
                print(response.result.error ?? "")
                break
                
            }
        }
    }
    
    
    @IBAction func btnForgotTapped(_ sender: UIButton) {
        
        
    }
}
