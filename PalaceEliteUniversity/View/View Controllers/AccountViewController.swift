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

class AccountViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ARPieChartDelegate, ARPieChartDataSource {
    
    // MARK: - Outlets
    @IBOutlet var imgUser: UIImageView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblUserEmail: UILabel!
    @IBOutlet var lblNotStarted: UILabel!
    @IBOutlet var lblInProgress: UILabel!
    @IBOutlet var lblCompleted: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var btnOpenPortal: UIButton!
    @IBOutlet var pieChart: ARPieChart!
    
    
    // MARK: - Variables
    var dictParamters = ["POINTS","LEVEL","BADGES"]
    var user = User()
    
    var count1 = Float()
    var count2 = Float()
    var count3 = Float()
    var totalCount :Float = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    ///*******************************************************
    // MARK: - UINavigation Bar Action Methods
    ///*******************************************************
    func tapLeftBarButton(_ sender:UIButton)  {
        
        _ = navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func tapRightBarButton(_ sender:UIButton)  {
        
        StaticHelper.sharedInstance.startLoader(view: view)
        
        logoutUser()
    }
    
    
    ///*******************************************************
    // MARK: - UIButton Action Methods
    ///*******************************************************
    
    @IBAction func btnOpenTapped(_ sender: UIButton) {
        
        //UIApplication.shared.openURL(URL(string: user.loginKey)! as URL)
        
        let vc : PortalWebViewController = storyboard?.instantiateViewController(withIdentifier: "PortalWebVC") as! PortalWebViewController
        vc.strURl = user.loginKey
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    fileprivate func updatePieChart() {
        pieChart.innerRadius = CGFloat((36.0/320.0) * UIScreen.main.bounds.width)
        pieChart.outerRadius = CGFloat((46.0/320.0) * UIScreen.main.bounds.width)
        pieChart.selectedPieOffset = CGFloat(17.4011307)
        pieChart.reloadData()
    }
    
    ///*******************************************************
    // MARK: - ARPieChartDelegate Methods
    ///*******************************************************
    func pieChart(_ pieChart: ARPieChart, itemSelectedAtIndex index: Int) {
        
    }
    
    func pieChart(_ pieChart: ARPieChart, itemDeselectedAtIndex index: Int) {
        
    }
    
    ///*******************************************************
    // MARK: - ARPieChartDataSource Methods
    ///*******************************************************
    func numberOfSlicesInPieChart(_ pieChart: ARPieChart) -> Int {
        return 3
    }
    
    func pieChart(_ pieChart: ARPieChart, valueForSliceAtIndex index: Int) -> CGFloat {
        
        var val = CGFloat()
        
        if index == 0 {
            val = CGFloat((count1 * 100)/totalCount)
        }
        else if index == 1 {
            val = CGFloat((count2 * 100)/totalCount)
        }
        else if index == 2 {
            val = CGFloat((count3 * 100)/totalCount)
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
            val = String(format: "%.1f",CGFloat((count1 * 100)/totalCount)) + "%"
        }
        else if index == 1 {
            val = String(format: "%.1f",CGFloat((count2 * 100)/totalCount)) + "%"
        }
        else if index == 2 {
            val = String(format: "%.1f",CGFloat((count3 * 100)/totalCount)) + "%"
        }
        
        
        return val
    }
    
    
    ///*******************************************************
    // MARK: - UICollection View Methods
    ///*******************************************************
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCell", for: indexPath) as! AccountCell
        
        if indexPath.item == 0 {
            cell.lblNumber.text = user.points
            cell.verticalLine.isHidden = false
        }
        else if indexPath.item == 1{
            cell.lblNumber.text = user.level
            cell.verticalLine.isHidden = false
        }
        else if indexPath.item == 2{
            cell.lblNumber.text = "\(user.badges.count)"
            cell.verticalLine.isHidden = true
        }
        
        cell.lblParameter.text =  dictParamters [indexPath.item]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height = CGFloat()
        let width : CGFloat = (106.0 / 320.0) * UIScreen.main.bounds.size.width
        
        height = (43.0 / 504.0) * UIScreen.main.bounds.size.height
        
        
        let cellSize = CGSize(width: CGFloat(width), height: height)
        
        return cellSize
    }
    
    ///*******************************************************
    // MARK: - API Methods
    ///*******************************************************
    
    func logoutUser(){
        
        if !StaticHelper.sharedInstance.checkNetworkStatus() {
            StaticHelper.sharedInstance.showAlertViewWithTitle("", message: "Internet is offline. Please check & try again after Internet is connected.", buttonTitles: ["OK"], viewController: self, completion: nil)
            return
        }
        
        let dict : [String:Any] = ["user_id":UserCache.userID()]
        
        Alamofire.request(URL(string: baseURL + "userlogout")!, method: .post, parameters: dict,  headers: nil).authenticate(user: apiKey, password: "").responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    UserCache.sharedInstance.clearUserData()
                    
                    StaticHelper.sharedInstance.stopLoader()
                    
                    let vc : LogoutViewController = self.storyboard?.instantiateViewController(withIdentifier: "LogoutVC") as! LogoutViewController
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
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
    // MARK: - Private Methods
    ///*******************************************************
    
    func setUpUI(){
        
        title = "My account"
        
        navigationItem.leftBarButtonItem = StaticHelper.sharedInstance.leftNavigationBarButton("down_arrow", viewController: self)
        navigationItem.rightBarButtonItem = StaticHelper.sharedInstance.rightNavigationBarButton("send_icon", viewController: self)
        
        // Set up Font
        lblUserName.font = UIFont.getCustomFont_ForSize(size: 15.0)
        lblUserEmail.font = UIFont.getCustomFont_ForSize(size: 15.0)
        lblNotStarted.font = UIFont.getCustomFont_ForSize(size: 9.0)
        lblCompleted.font = UIFont.getCustomFont_ForSize(size: 9.0)
        lblInProgress.font = UIFont.getCustomFont_ForSize(size: 9.0)
        btnOpenPortal.titleLabel?.font = UIFont.getCustomFont_ForSize(size: 13.0)
        

        let decodedUserData = UserDefaults.standard.object(forKey: "userData") as! Data
        user = NSKeyedUnarchiver.unarchiveObject(with: decodedUserData) as! User
        
        
        lblUserName.text = user.firstName + " " + user.lastName
        lblUserEmail.text = user.email
        
        imgUser.af_setImage(withURL: URL(string: user.avatar)!)
        
        collectionView.reloadData()
        
        let decoded1  = UserDefaults.standard.object(forKey: "courseData") as! Data
        let arrStatus = NSKeyedUnarchiver.unarchiveObject(with: decoded1) as! [Courses]
        
        if arrStatus.count > 0 {
            count1 = Float(arrStatus.filter{$0.completionStatus == "not_attempted"}.count)
            count2 = Float(arrStatus.filter{$0.completionStatus == "incomplete"}.count)
            count3 = Float(arrStatus.filter{$0.completionStatus == "complete"}.count)
            totalCount = Float(arrStatus.count)
        }
        else{
            count1 = 1.0
            count2 = 0.0
            count3 = 0.0
            totalCount = 1.0
        }
     
        pieChart.delegate = self
        pieChart.dataSource = self
        pieChart.showDescriptionText = true
        
        updatePieChart()
        
        
    }
}
