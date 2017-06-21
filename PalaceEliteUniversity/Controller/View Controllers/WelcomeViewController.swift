//
//  WelcomeViewController.swift
//  palaceelite
//
//  Created by CARLOS SOLANA on 5/19/17.
//  Copyright © 2017 Cybermoth. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate
{
  
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = collectionView.frame.size.width+10
        
        let fractionalPage = collectionView.contentOffset.x/pageWidth
        let page = lroundf(Float(fractionalPage))
        pageControl.currentPage =  page
    }

    @IBAction func btnGetStartedTapped(_ sender: Any) {
        
        let vc: LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        UserDefaults.standard.set(1, forKey: "launchCount")
        UserDefaults.standard.synchronize()
        
        
    }
}
