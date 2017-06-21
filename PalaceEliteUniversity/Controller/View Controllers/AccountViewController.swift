//
//  AccountViewController.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 05/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class AccountViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,ARPieChartDelegate, ARPieChartDataSource {

    @IBOutlet var imgUser: UIImageView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblUserEmail: UILabel!
    @IBOutlet var lblVersion: UILabel!
    @IBOutlet var lblWifiDownloadOnly: UILabel!
    @IBOutlet var btnClearDatabase: UIButton!
    @IBOutlet var switcherWifi: UISwitch!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pieChart: ARPieChart!
    
    
    var dictUserDetails = [String:Any]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Account"
        
         navigationItem.leftBarButtonItem = StaticHelper.sharedInstance.leftNavigationBarButton("menu_icon", viewController: self)
        
         navigationItem.rightBarButtonItem = StaticHelper.sharedInstance.rightNavigationBarButton("menu_icon", viewController: self)
        
        
        
        pieChart.delegate = self
        pieChart.dataSource = self
        pieChart.showDescriptionText = true
    
        updatePieChart()
        
        
        let user: User = UserDefaults.standard.object(forKey: "userData") as! User
        
        
        
        self.lblUserName.text = user.firstName + user.lastName
        self.lblUserEmail.text = user.email
        
        self.imgUser.af_setImage(withURL: URL(string: user.avatar)!)
        
        self.collectionView.reloadData()
        
     
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pieChart.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tapLeftBarButton(_ sender:UIButton)  {
        
        let view = SideMenu.getReferenceFromNib()
        view.show()
    }
    
    func tapRightBarButton(_ sender:UIButton)  {
        
        logoutUser()
    }
    
    fileprivate func updatePieChart() {
        pieChart.innerRadius = CGFloat(3.2203369)
        pieChart.outerRadius = CGFloat(36.666664)
        pieChart.selectedPieOffset = CGFloat(17.4011307)
        pieChart.reloadData()
    }
    
    /**
     *  MARK: ARPieChartDelegate
     */
    func pieChart(_ pieChart: ARPieChart, itemSelectedAtIndex index: Int) {
        
        
        var val = CGFloat()
        
        if index == 0 {
            val = 20
        }
        else if index == 1 {
            val = 10
        }
        else if index == 2 {
            val = 30
        }
        
        
    }
    
    func pieChart(_ pieChart: ARPieChart, itemDeselectedAtIndex index: Int) {
       
    }
    
    
    /**
     *   MARK: ARPieChartDataSource
     */
    func numberOfSlicesInPieChart(_ pieChart: ARPieChart) -> Int {
        return 3
    }
    
    func pieChart(_ pieChart: ARPieChart, valueForSliceAtIndex index: Int) -> CGFloat {
        
        var val = CGFloat()
        
        if index == 0 {
            val = 20
        }
        else if index == 1 {
            val = 10
        }
        else if index == 2 {
            val = 30
        }
        return val
    }
    
    func pieChart(_ pieChart: ARPieChart, colorForSliceAtIndex index: Int) -> UIColor {
        
        var color = UIColor()
        
        if index == 0 {
            color = UIColor(red: (10.0/255.0), green: (199.0/255.0) , blue: (199.0/255.0), alpha: 1.0)
        }
        else if index == 1 {
            color = UIColor(red: (254.0/255.0), green: (142.0/255.0) , blue: (1.0/255.0), alpha: 1.0)
        }
        else if index == 2 {
            color = UIColor(red: (34.0/255.0), green: (216.0/255.0) , blue: (5.0/255.0), alpha: 1.0)
        }
        return color
    }
    
    func pieChart(_ pieChart: ARPieChart, descriptionForSliceAtIndex index: Int) -> String {
        var val = String()
        
        if index == 0 {
            val = "20"
        }
        else if index == 1 {
            val = "10"
        }
        else if index == 2 {
            val = "30"
        }
        
        return val
    }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCell", for: indexPath) as! AccountCell
        
        
        cell.lblNumber.text = dictUserDetails ["points"] as? String
        cell.lblParameter.text =  dictUserDetails ["level"] as? String
        
        
        return cell
    }
    
//    func getAccountDetails(){
//        
//        Alamofire.request(URL(string: baseURL + "users/id:1")!, method: .get, parameters: nil,  headers: nil).authenticate(user: apiKey, password: "").responseJSON { (response:DataResponse<Any>) in
//            
//            switch(response.result) {
//            case .success(_):
//                if response.result.value != nil{
//                    
//                    self.dictUserDetails = response.result.value as! [String:Any]
//                    
//                    self.lblUserName.text = self.dictUserDetails["first_name"] as? String
//                    
//                    self.lblUserEmail.text = self.dictUserDetails["email"] as? String
//                    
//                    self.imgUser.af_setImage(withURL: URL(string: self.dictUserDetails["avatar"] as! String)!)
//                    
//                   self.collectionView.reloadData()
//                }
//                break
//                
//            case .failure(_):
//                print(response.result.error ?? "")
//                break
//                
//            }
//        }
//    }

    func logoutUser(){

        let dict : [String:Any] = ["user_id":1]
        
        Alamofire.request(URL(string: baseURL + "userlogout")!, method: .post, parameters: dict,  headers: nil).authenticate(user: apiKey, password: "").responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    UserCache.sharedInstance.clearUserData()
                    
                    
                    
                    
                    
                }
                break
                
            case .failure(_):
                print(response.result.error ?? "")
                break
                
            }
        }
        
    }

}
