
import UIKit
import Foundation
import Alamofire


//typealias Handler = (index:NSInteger)->Void


protocol BlueToothStatusDelegate: NSObjectProtocol {
    func blueToothStatus(isBlueToothOn: Bool)
}


class StaticHelper: NSObject{

    var progressHud = MBProgressHUD()
    var isInternetConnected = false
    
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
    
    
    
    
    // MARK: - Network Monitoring
//    func startMonitoringNetworkStatus() {
//        let reachability = Reachability()!
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)),name: ReachabilityChangedNotification,object: reachability)
//        
//        do{
//            try reachability.startNotifier()
//        }catch{
//            print("could not start reachability notifier")
//        }
//    }
    
//    func reachabilityChanged(note: NSNotification) {
//        
//        let reachability = note.object as! Reachability
//        
//        if reachability.isReachable {
//            if reachability.isReachableViaWiFi {
//                print("Reachable via WiFi")
//                self.isInternetConnected = true
//            } else {
//                print("Reachable via Cellular")
//                self.isInternetConnected = true
//            }
//        } else {
//            print("Network not reachable")
//            self.isInternetConnected = false
//        }
//    }
    
    func showAlertInternetError(){
    }
    
    //MARK: -MB Progress Hud
    func startLoader(view:UIView){
        
        progressHud = MBProgressHUD.showAdded(to: view, animated: true)
        progressHud.activityIndicatorColor = UIColor.gray
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
        
        let leftBarButton = UIBarButtonItem.init(customView: rightButton)
        // leftBarButton = nil
        
        return leftBarButton
        
    }
    
     func placeSortBarButtonWithImage(imageName:String,vc:UIViewController) -> UIBarButtonItem{
        
        let rightImage = UIImage.init(named: imageName)
        let rightButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width:(rightImage?.size.width)!, height: (rightImage?.size.height)!))
        
        rightButton.setImage(rightImage, for: .normal)
        rightButton.addTarget(vc, action: Selector(("tapSortRightBarButton:")), for: .touchUpInside)
        
        let leftBarButton = UIBarButtonItem.init(customView: rightButton)
        // leftBarButton = nil
        
        return leftBarButton
        
    }
  
    func placeGridBarButtonWithImage(imageName:String,vc:UIViewController) -> UIBarButtonItem{
        
        let rightImage = UIImage.init(named: imageName)
        let rightButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width:(rightImage?.size.width)!, height: (rightImage?.size.height)!))
        
        rightButton.setImage(rightImage, for: .normal)
        rightButton.addTarget(vc, action: Selector(("tapGridRightBarButton:")), for: .touchUpInside)
        
        let leftBarButton = UIBarButtonItem.init(customView: rightButton)
        // leftBarButton = nil
        
        return leftBarButton
        
    }
    
    
  
    //MARK: - set Initial ViewController Method
    func setInitialViewController(_ viewControllerName:NSString) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var homeNav = UINavigationController(nibName: "LoginHomeNav", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: viewControllerName as String)
        let window = mainWindow()
        homeNav = UINavigationController(rootViewController: viewController)
        window .rootViewController = homeNav
        window .makeKeyAndVisible()
    }
    
    func setLoginAsRootViewController(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginHomeNav = storyBoard.instantiateViewController(withIdentifier: "LoginHomeNav") as! UINavigationController
        let window = mainWindow()
        window.rootViewController = loginHomeNav
        
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


    
    func isValidEmail(_ checkString: String) -> Bool {
        let stricterFilter: Bool = false
        let stricterFilterString: String = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let laxString: String = ".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*"
        let emailRegex: String = stricterFilter ? stricterFilterString : laxString
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let result: Bool = emailTest.evaluate(with: checkString)
        
        return result
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
}

