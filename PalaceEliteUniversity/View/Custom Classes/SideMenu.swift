//
//  SideMenu.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 05/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit

protocol RowSelectionDelegate: NSObjectProtocol {
    func didSelectRow(selectedRowIndex: NSInteger)
    
}

class SideMenu: UIView, UITableViewDelegate, UITableViewDataSource  {
    
    weak var rowSelectionDelegate: RowSelectionDelegate?
    
   
    @IBOutlet var viewMenu: UIView!
    @IBOutlet var shadowView: UIView!
    @IBOutlet var viewBackground: SideMenu!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var consMenuViewWidth: NSLayoutConstraint!
    
    var arrData = [[String]]()
    
    var widthViewMenu = CGFloat()
    
    class func getReferenceFromNib() -> SideMenu {
        
        let nib = UINib(nibName: "SideMenu", bundle:nil)
        let popUpTable = nib.instantiate(withOwner: nil, options:nil)[0] as! SideMenu
        
        popUpTable.frame = UIScreen.main.bounds
        popUpTable.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let tapGesture = UITapGestureRecognizer(target: popUpTable, action: #selector(handleTap(tapGesture:)))
        popUpTable.viewBackground.addGestureRecognizer(tapGesture)
        
        popUpTable.tableView.delegate = popUpTable
        popUpTable.tableView.dataSource = popUpTable
        
        popUpTable.tableView.register(UINib(nibName: "SideMenuOptionCell", bundle: nil), forCellReuseIdentifier: "SideMenuOptionCell")
        
        popUpTable.tableView.isScrollEnabled = false
        
        popUpTable.arrData = [["side_nav_courses_icon","Courses"],["side_nav_progress_icon","Progress"],["side_nav_calendar_icon","Calendar"],["notificationsIcon","Notifications"],["side_nav_attendance_icon","Attendance"],["side_nav_support_icon","Support"],["side_nav_settings_icon","Settings"],["side_nav_palace_elite_icon","Palace Elite"],["Logout","Logout"]]
        
        popUpTable.widthViewMenu = (212.0/320.0) * UIScreen.main.bounds.width
        popUpTable.consMenuViewWidth.constant = popUpTable.widthViewMenu
        popUpTable.viewMenu.frame = CGRect(x: -popUpTable.widthViewMenu, y: 0, width: popUpTable.widthViewMenu, height: popUpTable.frame.size.height)
        
        
        return popUpTable
        
    }
    
   
    ///*******************************************************
    // MARK: - UITableView Delgate and Datasource Methods
    ///*******************************************************
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (40.0 / 568.0) * UIScreen.main.bounds.height
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuOptionCell") as! SideMenuOptionCell
        
        cell.imgOption.image = UIImage(named: arrData[indexPath.row][0])
        cell.lblOption.text = arrData[indexPath.row][1]
    
        return cell
        
    }
    
    
    
    ///*******************************************************
    // MARK: - Private Methods
    ///*******************************************************
    
    func show() {
        
        let window = StaticHelper.sharedInstance.mainWindow()
        
        self.frame = window.frame
        
        window.addSubview(self)
        
         viewBackground.backgroundColor = UIColor.black.withAlphaComponent(0)
         shadowView.backgroundColor = UIColor.black.withAlphaComponent(0)
        
        UIView .animate(withDuration: 0.3, animations: {
     
             self.viewBackground.backgroundColor = UIColor.black.withAlphaComponent(0.2)
             self.shadowView.backgroundColor = UIColor.black.withAlphaComponent(1)
            self.viewMenu.frame  = CGRect(x: 0, y:0, width: 270, height: UIScreen.main.bounds.height)
        }) { (finished:Bool) in
            self.layoutIfNeeded()
            
        }
       
        
    }
    
    func dismiss()  {
        layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.viewMenu.frame = CGRect(x: -self.widthViewMenu, y: 0, width: self.widthViewMenu, height: self.frame.size.height)
            
            self.layoutIfNeeded()
            
        }) { (finished:Bool) in
            self.removeFromSuperview()
           
        }
    }
    
    func handleTap(tapGesture: UITapGestureRecognizer)  {
        dismiss()
    }
    


}
