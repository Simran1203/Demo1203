//
//
//  TalentLMS
//
//  Created by Simran on 03/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit
import Foundation
import Alamofire



class StaticHelper: NSObject{

    var progressHud = MBProgressHUD()
    var isInternetConnected = false
    
    var border = CALayer()
    
    class var sharedInstance : StaticHelper {
        struct Static {
            static let instance = StaticHelper()
        }
        
        return Static.instance
    }


    //MARK: - Check If An Object is Not Nil
    class func isObjectNotNil(object:AnyObject!) -> Bool
    {
        if let _:AnyObject = object
        {
            if object != nil && !(object is NSNull){
                return true
            }
        }
        
        return false
    }
    
    class func isKeyPresentInUserDefaults(key: String) -> Bool {
        if UserDefaults.standard.object(forKey: key) is NSNull{
            return false
            
        }
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    
    //MARK: -Check Internet Connection
    func checkNetworkStatus() -> Bool {
        //do {
        let reachability: Reachability =  Reachability.forInternetConnection()
        let networkStatus : NetworkStatus = reachability.currentReachabilityStatus()
        
        return networkStatus != .NotReachable
       
    }

    //MARK: -MB Progress Hud
    func startLoader(view:UIView){
        
        progressHud = MBProgressHUD.showAdded(to: view, animated: true)
        progressHud.activityIndicatorColor = UIColor(red: (8.0/255.0), green: (232.0/255.0), blue: (255.0/255.0), alpha: 1.0)
        progressHud.bezelView.color = UIColor.clear
        progressHud .show(animated: true)
    }
    
    
    func stopLoader(){
        progressHud .hide(animated: true)
    }

   
    //MARK: - Navigation Buttons
    func leftNavigationBarButton(_ imageName:NSString,viewController:UIViewController) -> UIBarButtonItem {
        
        var leftNavButton = UIButton(type: .custom)
        var buttonImage = UIImage(named: imageName as String)
        
        if buttonImage == nil{
            buttonImage = UIImage(named: "back_icon")
            leftNavButton  = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 0.05 , height: 0.05))
            leftNavButton .setImage(buttonImage, for: UIControlState())
            
            leftNavButton .addTarget(viewController, action:Selector(("tapLeftBarButton:")), for: .touchUpInside)
            
            
            let leftBarButton = UIBarButtonItem(customView: leftNavButton)
            
            return leftBarButton
        }

        leftNavButton  = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: buttonImage!.size.width, height: buttonImage!.size.height))
        leftNavButton .setImage(buttonImage, for: UIControlState())
        
        leftNavButton .addTarget(viewController, action:Selector(("tapLeftBarButton:")), for: .touchUpInside)
        
        
        let leftBarButton = UIBarButtonItem(customView: leftNavButton)
        
        return leftBarButton
    }
    

     func rightNavigationBarButton(_ imageName:NSString,viewController:UIViewController) -> UIBarButtonItem {
        
        var rightNavButton = UIButton(type: .custom)
        let buttonImage = UIImage(named: imageName as String)
        
        rightNavButton  = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: buttonImage!.size.width, height: buttonImage!.size.height))
        rightNavButton .setImage(buttonImage, for: UIControlState())
        
        rightNavButton .addTarget(viewController, action:Selector(("tapRightBarButton:")), for: .touchUpInside)
        
        let rightBarButton = UIBarButtonItem(customView: rightNavButton)
        
        return rightBarButton
    }
    
    
     func placeSearchBarButtonWithImage(imageName:String,vc:UIViewController) -> UIBarButtonItem{
        
        let rightImage = UIImage.init(named: imageName)
        let rightButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width:(rightImage?.size.width)!, height: (rightImage?.size.height)!))
        
        rightButton.setImage(rightImage, for: .normal)
        rightButton.addTarget(vc, action: Selector(("tapSearchRightBarButton:")), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: rightButton)
        
        return barButton
        
    }
    
     func placeSortBarButtonWithImage(imageName:String,vc:UIViewController) -> UIBarButtonItem{
        
        let rightImage = UIImage.init(named: imageName)
        let rightButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width:(rightImage?.size.width)!, height: (rightImage?.size.height)!))
        
        rightButton.setImage(rightImage, for: .normal)
        rightButton.addTarget(vc, action: Selector(("tapSortRightBarButton:")), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: rightButton)
        
        
        return barButton
        
    }
  
    func placeGridBarButtonWithImage(imageName:String,vc:UIViewController) -> UIBarButtonItem{
        
        let rightImage = UIImage.init(named: imageName)
        let rightButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width:(rightImage?.size.width)!, height: (rightImage?.size.height)!))
        
        rightButton.setImage(rightImage, for: .normal)
        rightButton.addTarget(vc, action: Selector(("tapGridRightBarButton:")), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: rightButton)
        
        
        return barButton
        
    }
    
    func placeCrossBarButtonWithImage(imageName:String,vc:UIViewController) -> UIBarButtonItem{
        
        let rightImage = UIImage.init(named: imageName)
        let rightButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width:(rightImage?.size.width)!, height: (rightImage?.size.height)!))
        
        rightButton.setImage(rightImage, for: .normal)
        rightButton.addTarget(vc, action: Selector(("tapCrossRightBarButton:")), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: rightButton)
      
        
        return barButton
        
    }
    
  
    //****************************************************
    //MARK: - Calculating Label Size
    //****************************************************
    
    func calculateSizeOfLabel(withText data:String, andWidth width:CGFloat, andFont font:UIFont) -> CGSize {
        var size = CGSize()
        var constraintSize = CGSize()
        
        constraintSize.width = width
        constraintSize.height = CGFloat(MAXFLOAT)
       //constraintSize.height = .greatestFiniteMagnitude
        
        let stringAttributes = [NSFontAttributeName: font]
        
         size = data.boundingRect(with: constraintSize, options: [.usesFontLeading, .usesDeviceMetrics,], attributes: stringAttributes, context: nil).size
        
        return size
    
    }
    

    ////****************************************************
    //MARK: - AlertView Methods
    ////****************************************************

    func showAlertViewWithTitle(_ title:String?, message:String, buttonTitles:[String], viewController:UIViewController, completion: ((_ index: Int) -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for buttonTitle in buttonTitles {
            let alertAction = UIAlertAction(title: buttonTitle, style: .default, handler: { (action:UIAlertAction) in
                completion?(buttonTitles.index(of: buttonTitle)!)
            })
            alertController .addAction(alertAction)
        }
        viewController .present(alertController, animated: true, completion: nil)
    }

////****************************************************
//#pragma mark -Action Sheet Method
////****************************************************
//

    func showActionSheet(in controller: UIViewController, title: String?, message: String?, buttonArray: [String], completion block: @escaping (_ buttonIndex: Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        //let buttonArray:Array<String> = ["mariyam","sabeel"]
        
        for buttonTitle: String in buttonArray{
            let alertAction = UIAlertAction(title: buttonTitle, style: .default, handler: {(_ action: UIAlertAction) -> Void in
                let index: Int = (buttonArray as NSArray).index(of: action.title ?? "defaultValue")
                block(index)
            })
            alertController.addAction(alertAction)
        }
        let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            block(buttonArray.count)
        })
        alertController.addAction(alertAction)
        DispatchQueue.main.async {
            controller.present(alertController, animated: true, completion: {
                
            })
        }
    }


    //MARK: - Get Main Window
    
    func mainWindow() -> UIWindow {
        let app = UIApplication.shared.delegate as? AppDelegate
        return (app?.window!)!
    }
    
    /**
     * A utility method that grabs the top-most view controller for the main application window.
     * May return nil if a suitable view controller cannot be found.
     */
    func topController() -> UIViewController? {
        let window = self.mainWindow()
        
        var topController: UIViewController? = window.rootViewController!
        
        if (topController == nil) {
            print("Unable to find top controller")
            
            return nil
        }
        
        var presented: Bool = false
        
        var presentationStyle: UIModalPresentationStyle = topController!.modalPresentationStyle;
        
        // Iterate through any presented view controllers and find the top-most presentation context
        while ((topController?.presentedViewController) != nil) {
            presented = true
            // UIModalPresentationCurrentContext allows a view controller to use the presentation style of its modal parent.
            if (topController?.presentedViewController?.modalPresentationStyle != .currentContext) {
                presentationStyle = (topController?.presentedViewController?.modalPresentationStyle)!;
            }
            topController = topController?.presentedViewController;
        }
        
        // Custom modal presentation could leave us in an unpredictable display state
        if (presented && presentationStyle == .custom) {
            NSLog("top view controller is using a custom presentation style, returning nil");
            return nil;
        }
        
        return topController!;
    }
    
    //MARK: - Is Email Id valid
    func isValidEmail(_ checkString: String) -> Bool {
        let stricterFilter: Bool = false
        let stricterFilterString: String = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let laxString: String = ".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*"
        let emailRegex: String = stricterFilter ? stricterFilterString : laxString
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let result: Bool = emailTest.evaluate(with: checkString)
        
        return result
    }
}

extension UIScreen{
    
    enum SizeType: CGFloat {
        case Unknown = 0.0
        case iPad = 1024.0
        case iPadPro = 1366.0
        case iPhone5 = 568.0
        case iPhone6 = 667.0
        case iPhone6Plus = 736.0
    }
    
    var sizeType: SizeType {
        let height = UIScreen.main.bounds.height
        guard let sizeType = SizeType(rawValue: height) else { return .Unknown }
        return sizeType
    }
}

//MARK: - Font Size alters according to Screen size
extension UIFont{
    
    static  func getCustomFont_ForSize(size:CGFloat) -> UIFont{
        var fontSize = size
        if UIScreen.main.sizeType  == .iPhone6 || UIScreen.main.sizeType  == .iPhone6Plus{
            fontSize = size + 2
        }
        else if UIScreen.main.bounds.height  >= 1024.0 {
            fontSize = size + 10
        }
        
        return UIFont.systemFont(ofSize: fontSize)
        
    }
    
    static  func getCustomBoldFont_ForSize(size:CGFloat) -> UIFont{
        var fontSize = size
        if UIScreen.main.sizeType  == .iPhone6 || UIScreen.main.sizeType  == .iPhone6Plus{
            fontSize = size + 2
        }
        else if UIScreen.main.bounds.height  >= 1024.0 {
            fontSize = size + 10
        }
        return UIFont.systemFont(ofSize: fontSize, weight: UIFontWeightSemibold)
        
    }
    static  func getCustomMediumFont_ForSize(size:CGFloat) -> UIFont{
        var fontSize = size
        if UIScreen.main.sizeType  == .iPhone6 || UIScreen.main.sizeType  == .iPhone6Plus{
            fontSize = size + 2
        }
        else if UIScreen.main.bounds.height  >= 1024.0 {
            fontSize = size + 10
        }
        return UIFont.systemFont(ofSize: fontSize, weight: UIFontWeightMedium)
        
    }
}
