//
//  SideOptionsPopUp.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 08/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit

@objc enum Options:NSInteger{
    case NAME, DATE, STATUS
}

protocol  OptionSelected: NSObjectProtocol {
    func didSelectOption(option: Options)
}

class SideOptionsPopUp: UIView, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var sideView: UIView!
    
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var consTrailingIphone: NSLayoutConstraint!
    @IBOutlet var consTrailingIpad: NSLayoutConstraint!
    var shapeLayer = CAShapeLayer()
    
    var frameMenuButton = CGRect()
    
    weak var optionSelected: OptionSelected?
    
    let HEIGHT_TABLEVIEW_CELL: CGFloat = 38.0
    
    let arrLabels: Array = ["NAME", "DATE", "STATUS"]
    //let arrImages: Array = ["what's_on_icon", "all_deals_icon", "suggest_venue_icon", "settings_icon"]
    
    
    class func getReferenceFromNib() -> SideOptionsPopUp{
        let nib = UINib(nibName: "SideOptionsPopUp", bundle:nil)
        let loginPopUp = nib.instantiate(withOwner: nil, options: nil)[0] as! SideOptionsPopUp
        
        loginPopUp.frame = UIScreen.main.bounds
        loginPopUp.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let tapGesture = UITapGestureRecognizer(target: loginPopUp, action: #selector(handleTap(tapGesture:)))
        loginPopUp.backgroundView.addGestureRecognizer(tapGesture)
        
        loginPopUp.tableView.dataSource = loginPopUp
        loginPopUp.tableView.delegate = loginPopUp
        
        loginPopUp.tableView.register(UINib(nibName: "SideOptionCell", bundle: nil), forCellReuseIdentifier: "SideOptionCell")
        loginPopUp.tableView.isScrollEnabled = false
        
        return loginPopUp
        
    }
    
    func show() {
        let window = StaticHelper.sharedInstance.mainWindow()
        
        self.frame = window.frame;
        
        let viewHeight = (116/568.0) * UIScreen.main.bounds.height
        let viewWidth = (120/320.0) * UIScreen.main.bounds.width
        
        if UIScreen.main.bounds.height == 1024.0 || UIScreen.main.bounds.height == 1366.0{
            //constraintTrailing.constant = 0
            consTrailingIpad.isActive = true
            consTrailingIphone.isActive = false
            
        }else{
            //constraintTrailing.constant = (275.0/320) * UIScreen.main.bounds.width
            consTrailingIpad.isActive = false
            consTrailingIphone.isActive = true
        }
        self.layoutIfNeeded()
        
        window.addSubview(self)
        
        
        if UIScreen.main.bounds.height == 1024.0 || UIScreen.main.bounds.height == 1366.0{
            
            
        }else{
            
            let path = CGMutablePath()
            
            let arrowWidth = (12/320.0) * UIScreen.main.bounds.width
            let arrowHeight = (8/568.0) * UIScreen.main.bounds.height
            
            path.move(to: CGPoint(x: CGFloat(0.0), y: CGFloat(arrowHeight)), transform: .identity)
            
            path.addLine(to: CGPoint(x: CGFloat(viewWidth/2.0 - arrowWidth/2.0), y: CGFloat(arrowHeight)), transform: .identity)
            path.addLine(to: CGPoint(x: CGFloat(viewWidth/2.0), y: CGFloat(0.0)), transform: .identity)
            path.addLine(to: CGPoint(x: CGFloat(viewWidth/2.0 + arrowWidth/2.0), y: CGFloat(arrowHeight)), transform: .identity)
            path.addLine(to: CGPoint(x: CGFloat(viewWidth), y: CGFloat(arrowHeight)), transform: .identity)
            path.addLine(to: CGPoint(x: CGFloat(viewWidth), y: CGFloat(viewHeight)), transform: .identity)
            
            path.addLine(to: CGPoint(x: CGFloat(0.0), y: CGFloat(viewHeight)), transform: .identity)
            path.addLine(to: CGPoint(x: CGFloat(0.0), y: CGFloat(arrowHeight)), transform: .identity)
            
            
            //shapeLayer.removeFromSuperlayer()
            
            shapeLayer = CAShapeLayer()
            shapeLayer.path = path
            shapeLayer.fillColor = UIColor(red: (2.0/255.0), green: (112.0/255.0), blue: (120.0/255.0), alpha: 1.0).cgColor
            shapeLayer.bounds = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(viewWidth), height: CGFloat(viewHeight))
            shapeLayer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            shapeLayer.position = CGPoint(x: 0.0, y: 0.0)
            
            
            // CGPathRelease(path)
            
            sideView.layer .insertSublayer(shapeLayer, at: 0)
            
            
        }
        
        
    }
    func dismiss()  {
        self.removeFromSuperview()
    }
    
    func handleTap(tapGesture: UITapGestureRecognizer)  {
        dismiss()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLabels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight: CGFloat = (HEIGHT_TABLEVIEW_CELL/568.0) * UIScreen.main.bounds.height
        
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sideOptionCell = tableView.dequeueReusableCell(withIdentifier: "SideOptionCell") as! SideOptionCell
        
        sideOptionCell.lblCell.text = arrLabels[indexPath.row]
        
        
        if indexPath.row < 2 {
            sideOptionCell.underLine.isHidden = false
        }
        else{
            sideOptionCell.underLine.isHidden = true
        }
        
        return sideOptionCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        dismiss()
        
        if optionSelected != nil{
            optionSelected?.didSelectOption(option: Options(rawValue: indexPath.row)!)
        }
        
    }
    
}
