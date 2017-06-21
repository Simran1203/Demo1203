//
//  ChaptersViewController.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 05/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ChaptersViewController: UIViewController {

     // MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var lblChapterName: UILabel!
    @IBOutlet var lblChapterHeading: UILabel!
    @IBOutlet var lblChapterDesc: UITextView!
    
    
    // MARK: - Variables
    var arrUnits = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getChapters()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUnits.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var identifier = ""
        
        if indexPath.row == 1 {
            identifier = "imageCell"
        }
        else{
            identifier = "lblCell"
        }
        let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! LoginCell
        
        
        cell.imgUniversity.image = UIImage(named:"")
        
       // cell.lblImpOptions.text = arrUnits[indexPath.row] as! String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
        
        
    }
    
    
    func getChapters(){
        
        Alamofire.request(URL(string: baseURL + "/courses/id:124")!, method: .get, parameters: nil,  headers: nil).authenticate(user: apiKey, password: "").responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    
                    let arr : [String:Any] = response.result.value as! [String:Any]
                    print(arr)
                }
                break
                
            case .failure(_):
                print(response.result.error ?? "")
                break
                
            }
        }
    }


}
