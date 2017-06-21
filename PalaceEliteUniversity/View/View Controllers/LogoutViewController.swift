//
//  LogoutViewController.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 09/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit

class LogoutViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    // MARK: - Outlets
    @IBOutlet var lblHeading: UILabel!
    @IBOutlet var lblRateApp: UILabel!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var btnShow: UIButton!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var backViewSec1: UIView!
    @IBOutlet var backViewSec2: UIView!
    @IBOutlet var btnLearn: UIButton!
    @IBOutlet var lblSession: UILabel!
    
    // MARK: - Variables
    var bottomColor1 = UIColor()
    var topColor1 = UIColor()
    var bottomColor2 = UIColor()
    var topColor2 = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        
    }
    
    ///*******************************************************
    // MARK: - UICollectionView Methods
    ///*******************************************************
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : LogoutCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LogoutCell", for: indexPath) as! LogoutCell
        
        if indexPath.item == 0{
            cell.btnLeft.isHidden = true
            cell.btnRight.isHidden = false
            
            
            cell.lblHeading.text = "Get answers fast"
        }
        else{
            cell.btnLeft.isHidden = false
            cell.btnRight.isHidden = true
            
            cell.lblHeading.text = "Is it that simple?"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height : CGFloat = collectionView.bounds.height
        let width : CGFloat = UIScreen.main.bounds.size.width
        
        let cellSize = CGSize(width: CGFloat(width), height: height)
        
        return cellSize
    }
    
    ///*******************************************************
    // MARK: - Page Control Methods
    ///*******************************************************
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = collectionView.frame.size.width + 10
        
        let fractionalPage = collectionView.contentOffset.x/pageWidth
        let page = lroundf(Float(fractionalPage))
        
        if page == 0 {
            
            btnShow.setImage(UIImage(named:"get_answers_icon"), for: .normal)
            
            backViewSec1.isHidden = false
            backViewSec2.isHidden = true
        }
        else{
            btnShow.setImage(UIImage(named: "is_that_simple_icon"), for: .normal)
            
            backViewSec1.isHidden = true
            backViewSec2.isHidden = false
        }
        
        pageControl.currentPage =  page
    }
    
    ///*******************************************************
    // MARK: - Private Methods
    ///*******************************************************
    
    func setUpUI(){
        title = "PALACE ELITE UNIVERSITY"
        
        navigationItem.leftBarButtonItem = StaticHelper.sharedInstance.leftNavigationBarButton("", viewController: self)
        btnShow.setImage(UIImage(named: "get_answers_icon"), for: .normal)
        
        
        let linkAttributes: [String : Any] = [
            NSUnderlineColorAttributeName: UIColor(red: (0.0/255.0), green: (122.0/255.0), blue:(255.0/255.0), alpha:1.0),
            NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        
        
        lblRateApp.attributedText = NSAttributedString(string: " Please rate our app", attributes:linkAttributes)
        
        
        //Set Bottom Bar Background
        let gradientLayer1 = CAGradientLayer()
        
        gradientLayer1.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (181.0/504.0) * UIScreen.main.bounds.height)
        bottomColor1 = UIColor(red: (1.0/255.0), green: (29.0/255.0), blue: (39.0/255.0), alpha: 1.0)
        topColor1 = UIColor(red: (4.0/255.0), green: (140.0/255.0), blue: (155.0/255.0), alpha: 1.0)
        gradientLayer1.colors = Array(arrayLiteral: topColor1.cgColor,bottomColor1.cgColor)
        
        backViewSec1.layer.insertSublayer(gradientLayer1, at: 0)
        
        let gradientLayer2 = CAGradientLayer()
        
        gradientLayer2.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (181.0/504.0) * UIScreen.main.bounds.height)
        bottomColor2 = UIColor(red: (244.0/255.0), green: (55.0/255.0), blue: (6.0/255.0), alpha: 1.0)
        topColor2 = UIColor(red: (247.0/255.0), green: (194.0/255.0), blue: (21.0/255.0), alpha: 1.0)
        gradientLayer2.colors = Array(arrayLiteral: topColor2.cgColor,bottomColor2.cgColor)
        
        backViewSec2.layer.insertSublayer(gradientLayer2, at: 0)
        
        
        backViewSec1.isHidden = false
        backViewSec2.isHidden = true
        
        // Set up BtnLearn
        btnLearn.layer.cornerRadius = 4.0
        btnLearn.layer.masksToBounds = true
        
        
        btnLearn.layer.borderWidth = 1
        btnLearn.layer.borderColor = UIColor.lightGray.cgColor
        

        // Setup Font
        lblHeading.font = UIFont.getCustomFont_ForSize(size: 17.0)
        lblSession.font = UIFont.getCustomFont_ForSize(size: 11.0)
        lblRateApp.font = UIFont.getCustomFont_ForSize(size: 11.0)
        btnLearn.titleLabel?.font = UIFont.getCustomFont_ForSize(size: 15.0)
        
    }
    
    ///*******************************************************
    // MARK: - UIButton Action Methods
    ///*******************************************************
    
    
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        
        let vc : LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        
        let navController: UINavigationController = storyboard!.instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
        navController.viewControllers = [vc]
        
        navigationController?.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func btnLeftTapped(_ sender: UIButton) {
        collectionView.scrollToItem(at:IndexPath(item: 0, section: 0), at: .left, animated: false)
        
    }
    
    @IBAction func btnRightTapped(_ sender: UIButton) {
        collectionView.scrollToItem(at:IndexPath(item: 1, section: 0), at: .right, animated: false)
        
    }
    
}
