//
//  WelcomeViewController.swift
//  palaceelite
//
//  Created by Simran on 05/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout 
{
    
     // MARK: - Outlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    ///*******************************************************
    // MARK: - UICollectionView Methods
    ///*******************************************************
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : WelcomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCell", for: indexPath) as! WelcomeCollectionViewCell
        
        if indexPath.item == 3{
            cell.btnGetStarted.isHidden = false
        }
        else{
             cell.btnGetStarted.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height = CGFloat()
        let width : CGFloat = UIScreen.main.bounds.size.width
        
        height = (272.0 / 568.0) * UIScreen.main.bounds.size.height
        
        
        let cellSize = CGSize(width: CGFloat(width), height: height)
        
        return cellSize
    }
    
    ///*******************************************************
    // MARK: - Page Control Position Method
    ///*******************************************************
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = collectionView.frame.size.width+10
        
        let fractionalPage = collectionView.contentOffset.x/pageWidth
        let page = lroundf(Float(fractionalPage))
        pageControl.currentPage =  page
    }
    
    
    ///*******************************************************
    // MARK: - UIButton Action Methods
    ///*******************************************************
    @IBAction func btnGetStartedTapped(_ sender: Any) {
        
        let vc: LoginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
        
        UserDefaults.standard.set(1, forKey: "launchCount")
        UserDefaults.standard.synchronize()
        
        
    }
}
