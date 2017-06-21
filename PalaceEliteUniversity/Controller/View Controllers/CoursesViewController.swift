//
//  CoursesViewController.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 05/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class CoursesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,OptionSelected,UITextFieldDelegate,UICollectionViewDelegateFlowLayout,RowSelectionDelegate  {
    
    // MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var lblNoSearch: UILabel!
    
    // MARK: - Variables
    
    var arrMyCourses = [Courses]()
    var arrAllCourses = [Courses]()
    var arrCourses = [Courses]()
    var arrFilteredCourses = [Courses]()
    
    var selectedView = String()
    var searchTextField = UITextField()
    
    var sortButton = UIBarButtonItem()
    var rightBarButton = UIBarButtonItem()
    var searchButton = UIBarButtonItem()
    var gridButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///*******************************************************
    // MARK: - UITableView Methods
    ///*******************************************************
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrFilteredCourses.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (130.0/504.0) * tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "courseTCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CoursesTableViewCell
        
        let course : Courses = arrFilteredCourses[indexPath.section]
        
        cell.lblTitle.text = course.name
        cell.lblLoc.text = "Delhi"
        cell.lblDesc.text = "Description: " + course.desc
        cell.lblType.text = "Instructor"
        cell.lblProgress.text = "\(course.completionPercentage)" + "%"
        
        cell.imgCourse.af_setImage(withURL: URL(string:course.avatar)!, placeholderImage: UIImage(named:"courses_default_placeholder"), filter: nil, progress: nil, progressQueue: .main, imageTransition: .noTransition, runImageTransitionIfCached: false, completion: nil)
        
        
        let perc = Double(course.completionPercentage)
        
        cell.consHighlightedView.constant = CGFloat((perc / 100.0) * Double(UIScreen.main.bounds.width))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (10.0/504.0) * tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view  = UIView()
        view.backgroundColor = UIColor.clear
        
        return view
    }
    
    ///*******************************************************
    // MARK: - UICollection View Methods
    ///*******************************************************
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFilteredCourses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "courseCCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CoursesCollectionViewCell
        
        let course : Courses = arrFilteredCourses[indexPath.item]
        
        cell.imgCourse.af_setImage(withURL: URL(string:course.avatar)!, placeholderImage: UIImage(named:"courses_placeholder_square"), filter: nil, progress: nil, progressQueue: .main, imageTransition: .noTransition, runImageTransitionIfCached: false, completion: nil)
        
        cell.lblTitle.text = course.name
        cell.lblLoc.text = "Delhi"
        cell.lblType.text = "Instructor"
        cell.lblProgress.text = "\(course.completionPercentage)" + "%"
        
        let perc = Double(course.completionPercentage)
        
        cell.consCHighlightedView.constant = CGFloat((perc / 100.0) * Double((139.0 / 300.0) * UIScreen.main.bounds.size.width))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height = CGFloat()
        let width : CGFloat = (139.0 / 300.0) * UIScreen.main.bounds.size.width
        
        height = (155.0 / 504.0) * UIScreen.main.bounds.size.height
        
        
        let cellSize = CGSize(width: CGFloat(width), height: height)
        
        return cellSize
    }
    
    
    ///*******************************************************
    // MARK: - Navigation Bar Buttons Action  Methods
    ///*******************************************************

    func tapLeftBarButton(_ sender:UIButton)  {
        
        view.endEditing(true)
        
        let sideView = SideMenu.getReferenceFromNib()
        sideView.rowSelectionDelegate = self
        sideView.show()
    }
    
    func tapRightBarButton(_ sender:UIButton)  {
        
        let vc: AccountViewController = storyboard?.instantiateViewController(withIdentifier: "AccountVC") as! AccountViewController
        
        let navVC : UINavigationController = storyboard?.instantiateViewController(withIdentifier: "HomeNavController") as! UINavigationController
        
        
        navVC.viewControllers = [vc]
        navigationController?.present(navVC, animated: true, completion: nil)
        
    }
    
    func tapSortRightBarButton(_ sender:UIButton){
        
        let optionsPopUp = SideOptionsPopUp.getReferenceFromNib()
        
        let barBtnItemView = sortButton.value(forKey: "view")
        optionsPopUp.frameMenuButton = (barBtnItemView as AnyObject).frame
        optionsPopUp.optionSelected = self
        optionsPopUp.show()
        
    }
    
    func tapSearchRightBarButton(_ sender:UIButton){
        
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItems = nil
        
        searchTextField = UITextField(frame: CGRect(x: 15, y: 0, width: (navigationController?.navigationBar.frame.size.width)!, height: 21.0))
        navigationItem.titleView = searchTextField
        
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search for a course", attributes: [NSForegroundColorAttributeName: UIColor.white])
        searchTextField.textColor = .white
        searchTextField.tintColor = .white
        
        searchTextField.delegate = self
        searchTextField.becomeFirstResponder()
        
        let rightBarButton : UIBarButtonItem = StaticHelper.sharedInstance.placeCrossBarButtonWithImage(imageName: "close_icon", vc: self)
        navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    
    func tapGridRightBarButton(_ sender:UIButton){
        
        if selectedView == "Grid" {
            
            selectedView = "Table"
            
            tableView.isHidden = false
            collectionView.isHidden = true
        }
        else if selectedView == "Table"{
            
            selectedView = "Grid"
            
            collectionView.isHidden = false
            tableView.isHidden = true
            
        }
        
        tableView.reloadData()
        collectionView.reloadData()
        
    }
    
    func tapCrossRightBarButton (_ sender:UIButton){
        
        view.endEditing(true)
        searchTextField.endEditing(true)
        
        navigationItem.titleView = nil
        
        title = "Courses"
        
        navigationItem.leftBarButtonItem = StaticHelper.sharedInstance.leftNavigationBarButton("menu_icon", viewController: self)
        
        rightBarButton  = StaticHelper.sharedInstance.rightNavigationBarButton("user_icon", viewController: self)
        sortButton = StaticHelper.sharedInstance.placeSortBarButtonWithImage(imageName: "courses_sort_icon", vc: self)
        searchButton = StaticHelper.sharedInstance.placeSearchBarButtonWithImage(imageName: "courses_search_icon", vc: self)
        gridButton = StaticHelper.sharedInstance.placeGridBarButtonWithImage(imageName: "courses_grid_icon", vc: self)
        
        navigationItem.setRightBarButtonItems([rightBarButton,gridButton,sortButton,searchButton], animated: true)
        
        arrFilteredCourses = arrCourses
        
        tableView.reloadData()
        collectionView.reloadData()
        
        lblNoSearch.isHidden = true
        
        if selectedView == "Grid" {
            collectionView.isHidden = false
            tableView.isHidden = true
        }
        else if selectedView == "Table"{
            tableView.isHidden = false
            collectionView.isHidden = true
        }
        
    }
  
    ///*******************************************************
    // MARK: - Delegate Methods (Sort)
    ///*******************************************************
    
    func didSelectOption(option: Options) {
        
        switch option {
            
        case .NAME:
            arrFilteredCourses = arrCourses
            break
            
        case .DATE:
            arrFilteredCourses = arrCourses.sorted(by: {$0.enrolledOnTime.compare($1.enrolledOnTime) == .orderedAscending})
            
            break
            
        case .STATUS:
            arrFilteredCourses = arrCourses.sorted {
                return $0.completionPercentage > $1.completionPercentage
            }
            
            break
            
        }
        
        tableView.reloadData()
        collectionView.reloadData()
        
    }
    
    
    ///*******************************************************
    // MARK: - UITextField Delegate Methods
    ///*******************************************************
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text: NSString = (textField.text ?? "") as NSString
        let resultString = text.replacingCharacters(in: range, with: string)
        
       // let rightBarButton : UIBarButtonItem = StaticHelper.sharedInstance.placeCrossBarButtonWithImage(imageName: "close_icon", vc: self)
        
        filterSearchFor(str: resultString)
        
        //if resultString.characters.count > 0 {
           // navigationItem.rightBarButtonItem = rightBarButton
//        }
//        else{
//            navigationItem.rightBarButtonItem = nil
//        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    ///*******************************************************
    // MARK: - Private Methods
    ///*******************************************************
    func filterSearchFor(str : String){
        
        if str.characters.count > 0 {
            arrFilteredCourses = arrCourses.filter {
                $0.name.range(of: str, options: .caseInsensitive) != nil
            }
        }
        else{
            arrFilteredCourses = arrCourses
        }
        
        
        if arrFilteredCourses.count == 0{
            tableView.isHidden = true
            collectionView.isHidden = true
            lblNoSearch.isHidden = false
        }
        else{
            lblNoSearch.isHidden = true
            if selectedView == "Grid" {
                collectionView.isHidden = false
                tableView.isHidden = true
            }
            else if selectedView == "Table"{
                tableView.isHidden = false
                collectionView.isHidden = true
            }
            
        }
        
        tableView.reloadData()
        collectionView.reloadData()
        
    }
    
    func setUpUI(){
        StaticHelper.sharedInstance.startLoader(view: view)
        
        getCourses()
        
        title = "Courses"
        
        navigationItem.leftBarButtonItem = StaticHelper.sharedInstance.leftNavigationBarButton("menu_icon", viewController: self)
        
        rightBarButton = StaticHelper.sharedInstance.rightNavigationBarButton("user_icon", viewController: self)
        sortButton = StaticHelper.sharedInstance.placeSortBarButtonWithImage(imageName: "courses_sort_icon", vc: self)
        searchButton = StaticHelper.sharedInstance.placeSearchBarButtonWithImage(imageName: "courses_search_icon", vc: self)
        gridButton = StaticHelper.sharedInstance.placeGridBarButtonWithImage(imageName: "courses_grid_icon", vc: self)
        
        navigationItem.setRightBarButtonItems([rightBarButton,gridButton,sortButton,searchButton], animated: true)
        
        selectedView = "Table"
        lblNoSearch.isHidden = true
        
        if selectedView == "Grid" {
            collectionView.isHidden = false
            tableView.isHidden = true
        }
        else if selectedView == "Table"{
            tableView.isHidden = false
            collectionView.isHidden = true
        }
        
        // Set up Font
        
        lblNoSearch.font = UIFont.getCustomFont_ForSize(size: 16.0)
        
    }
    
    ///*******************************************************
    // MARK: - Delegate Method (Side Menu)
    ///*******************************************************
    
    func didSelectRow(selectedRowIndex: NSInteger){
        
        if selectedRowIndex == 0 {
            
            
        }
        else if selectedRowIndex == 8 {
            
            StaticHelper.sharedInstance.startLoader(view: view)
            logoutUser()
            
        }
    }
    
    ///*******************************************************
    // MARK: - API Methods
    ///*******************************************************
    
    func getCourses(){
        
        navigationController?.navigationBar.isUserInteractionEnabled = false
        
        
        if !StaticHelper.sharedInstance.checkNetworkStatus() {
            StaticHelper.sharedInstance.showAlertViewWithTitle("", message: "Internet is offline. Please check & try again after Internet is connected.", buttonTitles: ["OK"], viewController: self, completion: nil)
            return
        }
        
        
        Alamofire.request(URL(string: baseURL + "users/id:\(UserCache.userID())")!, method: .get, parameters: nil,  headers: nil).authenticate(user: apiKey, password: "").responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    
                    let dict : [String:Any] = response.result.value as! [String:Any]
                    
                    self.parseResponseUser(dict : dict)
                    
                    let arrCourses = dict["courses"] as! [Any]
                    
                    self.parseResponseToCourse(arr: arrCourses)
                    
                    self.getAllCourses()
                }
                break
                
            case .failure(_):
                print(response.result.error ?? "")
                break
                
            }
        }
    }
    
    func getAllCourses(){
        
        
        if !StaticHelper.sharedInstance.checkNetworkStatus() {
            StaticHelper.sharedInstance.showAlertViewWithTitle("", message: "Internet is offline. Please check & try again after Internet is connected.", buttonTitles: ["OK"], viewController: self, completion: nil)
            return
        }
        
        
        Alamofire.request(URL(string: baseURL + "courses/")!, method: .get, parameters: nil,  headers: nil).authenticate(user: apiKey, password: "").responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    
                    let arr = response.result.value as! [Any]
                    
                    self.parseResponseAllCourses(arr: arr)
                    
                    for i in 0..<self.arrMyCourses.count{
                        
                        let c : Courses = self.arrMyCourses[i]
                        
                        for j in 0..<self.arrAllCourses.count{
                            let c1 : Courses = self.arrAllCourses[j]
                            
                            if c.id == c1.id {
                                
                                let course = Courses()
                                
                                let myCourse : Courses = self.arrMyCourses[i]
                                let allCourse = self.arrAllCourses[j]
                                
                                
                                course.id = myCourse.id
                                course.name = myCourse.name
                                course.role = myCourse.role
                                course.enrolledOn = myCourse.enrolledOn
                                course.enrolledOnTime = myCourse.enrolledOnTime
                                course.completedOn = myCourse.completedOn
                                course.completedOnTime = myCourse.completedOnTime
                                course.completionStatus = myCourse.completionStatus
                                
                                course.completionPercentage = myCourse.completionPercentage
                                course.expiredOn = myCourse.expiredOn
                                course.expiredOnTime = myCourse.expiredOnTime
                                course.totalTime = myCourse.totalTime
                                
                                
                                course.code = allCourse.code
                                course.categoryId = allCourse.categoryId
                                course.desc = allCourse.desc
                                course.price = allCourse.price
                                course.status = allCourse.status
                                course.creationDate = allCourse.creationDate
                                
                                course.lastUpdateOn = allCourse.lastUpdateOn
                                course.creatorId = allCourse.creatorId
                                course.hideFromCatalog = allCourse.hideFromCatalog
                                course.timeLimit = allCourse.timeLimit
                                course.level = allCourse.level
                                
                                
                                course.shared = allCourse.shared
                                course.sharedUrl = allCourse.sharedUrl
                                course.avatar = allCourse.avatar
                                course.bigAvatar = allCourse.bigAvatar
                                course.certification = allCourse.certification
                                course.certificationDuration = allCourse.certificationDuration
                                course.customField1 = allCourse.customField1
                                
                                self.arrCourses.append(course)
                                
                            }
                            
                        }
                        
                    }
                    
                    self.arrFilteredCourses = self.arrCourses
                    
                    
                    StaticHelper.sharedInstance.stopLoader()
                    
                    self.navigationController?.navigationBar.isUserInteractionEnabled = true
                    
                    self.tableView.reloadData()
                    self.collectionView.reloadData()
                }
                break
                
            case .failure(_):
                print(response.result.error ?? "")
                break
                
            }
        }
        
    }
    
    
    
    
    
    func parseResponseUser(dict : [String: Any]){
        let user = User()
        
        if StaticHelper.isObjectNotNil(object: dict["id"] as AnyObject!){
            user.userId = dict["id"] as! String
        }
        else{
            user.userId = ""
        }
        
        
        if StaticHelper.isObjectNotNil(object: dict["login"] as AnyObject!){
            user.login = dict["login"] as! String
        }
        else{
            user.login = ""
        }
        
        
        if StaticHelper.isObjectNotNil(object: dict["first_name"] as AnyObject!){
            user.firstName = dict["first_name"] as! String
        }
        else{
            user.firstName = ""
        }
        
        if StaticHelper.isObjectNotNil(object: dict["last_name"] as AnyObject!){
            user.lastName = dict["last_name"] as! String
        }
        else{
            user.lastName = ""
        }
        
        if StaticHelper.isObjectNotNil(object: dict["email"] as AnyObject!){
            user.email = dict["email"] as! String
        }
        else{
            user.email = ""
        }
        
        if StaticHelper.isObjectNotNil(object: dict["user_type"] as AnyObject!){
            user.userType = dict["user_type"] as! String
        }
        else{
            user.userType = ""
        }
        
        if StaticHelper.isObjectNotNil(object: dict["timezone"] as AnyObject!){
            user.timeZone = dict["timezone"] as! String
        }
        else{
            user.timeZone = ""
        }
        
        if StaticHelper.isObjectNotNil(object: dict["status"] as AnyObject!){
            user.status = dict["status"] as! String
        }
        else{
            user.status = ""
        }
        
        if StaticHelper.isObjectNotNil(object: dict["level"] as AnyObject!){
            user.level = dict["level"] as! String
        }
        else{
            user.level = ""
        }
        
        if StaticHelper.isObjectNotNil(object: dict["points"] as AnyObject!){
            user.points = dict["points"] as! String
        }
        else{
            user.points = ""
        }
        
        if StaticHelper.isObjectNotNil(object: dict["created_on"] as AnyObject!){
            user.createdOn = dict["created_on"] as! String
        }
        else{
            user.createdOn = ""
        }
        
        if StaticHelper.isObjectNotNil(object: dict["avatar"] as AnyObject!){
            user.avatar = dict["avatar"] as! String
        }
        else{
            user.avatar = ""
        }
        
        if StaticHelper.isObjectNotNil(object: dict["bio"] as AnyObject!){
            user.bio = dict["bio"] as! String
        }
        else{
            user.bio = ""
        }
        
        if StaticHelper.isObjectNotNil(object: dict["login_key"] as AnyObject!){
            user.loginKey = dict["login_key"] as! String
        }
        else{
            user.loginKey = ""
        }
        
        UserCache.sharedInstance.saveAccountData(userData: user)
        
    }
    
    func parseResponseToCourse(arr : [Any]){
        for i in 0..<arr.count{
            
            let course = Courses()
            
            let dictCourse :[String:Any] = arr[i] as! [String : Any]
            
            
            if StaticHelper.isObjectNotNil(object: dictCourse["id"] as AnyObject!){
                course.id = dictCourse["id"] as! String
            }
            else{
                course.id = ""
            }
            if StaticHelper.isObjectNotNil(object: dictCourse["name"] as AnyObject!){
                course.name = dictCourse["name"] as! String
            }
            else{
                course.name = ""
            }
            if StaticHelper.isObjectNotNil(object: dictCourse["role"] as AnyObject!){
                course.role = dictCourse["role"] as! String
            }
            else{
                course.role = ""
            }
            if StaticHelper.isObjectNotNil(object: dictCourse["enrolled_on"] as AnyObject!){
                course.enrolledOn = dictCourse["enrolled_on"] as! String
            }
            else{
                course.enrolledOn = ""
            }
            if StaticHelper.isObjectNotNil(object: dictCourse["enrolled_on_timestamp"] as AnyObject!){
                course.enrolledOnTime = dictCourse["enrolled_on_timestamp"] as! String
            }
            else{
                course.enrolledOnTime = ""
            }
            if StaticHelper.isObjectNotNil(object: dictCourse["completed_on"] as AnyObject!){
                course.completedOn = dictCourse["completed_on"] as! String
            }
            else{
                course.completedOn = ""
            }
            if StaticHelper.isObjectNotNil(object: dictCourse["completed_on_timestamp"] as AnyObject!){
                course.completedOnTime = (dictCourse["completed_on_timestamp"] as? String)!
            }
            else{
                course.completedOnTime = ""
            }
            if StaticHelper.isObjectNotNil(object: dictCourse["completion_status"] as AnyObject!){
                course.completionStatus = (dictCourse["completion_status"] as? String)!
            }
            else{
                course.completionStatus = ""
            }
            if StaticHelper.isObjectNotNil(object: dictCourse["completion_percentage"] as AnyObject!){
                course.completionPercentage = Int((dictCourse["completion_percentage"] as? String)!)!
            }
            else{
                course.completionPercentage = 0
            }
            if StaticHelper.isObjectNotNil(object: dictCourse["expired_on"] as AnyObject!){
                course.expiredOn = dictCourse["expired_on"] as! String
            }
            else{
                course.expiredOn = ""
            }
            if StaticHelper.isObjectNotNil(object: dictCourse["expired_on_timestamp"] as AnyObject!){
                course.expiredOnTime = dictCourse["expired_on_timestamp"] as! String
            }
            else{
                course.expiredOnTime = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictCourse["total_time"] as AnyObject!){
                course.totalTime = dictCourse["total_time"] as! String
            }
            else{
                course.totalTime = ""
            }
            
            arrMyCourses.append(course)
        }
        
        UserCache.sharedInstance.saveCourseData(arrCourseData: arrMyCourses)
    }
    
    func parseResponseAllCourses(arr : [Any]){
        
        for i in 0..<arr.count{
            
            let course = Courses()
            
            let dictAllCourse:[String:Any] = arr[i] as! [String : Any]
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["id"] as AnyObject!){
                course.id = dictAllCourse["id"] as! String
            }
            else{
                course.id = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["name"] as AnyObject!){
                course.name = dictAllCourse["name"] as! String
            }
            else{
                course.name = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["code"] as AnyObject!){
                course.code = dictAllCourse["code"] as! String
            }
            else{
                course.code = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["category_id"] as AnyObject!){
                course.categoryId = dictAllCourse["category_id"] as! String
            }
            else{
                course.categoryId = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["description"] as AnyObject!){
                course.desc = dictAllCourse["description"] as! String
            }
            else{
                course.desc = ""
            }
            if StaticHelper.isObjectNotNil(object: dictAllCourse["price"] as AnyObject!){
                course.price = dictAllCourse["price"] as! String
            }
            else{
                course.price = ""
            }
            if StaticHelper.isObjectNotNil(object: dictAllCourse["status"] as AnyObject!){
                course.status = dictAllCourse["status"] as! String
            }
            else{
                course.status = ""
            }
            if StaticHelper.isObjectNotNil(object: dictAllCourse["creation_date"] as AnyObject!){
                course.creationDate = dictAllCourse["creation_date"] as! String
                
            }
            else{
                course.creationDate = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["last_update_on"] as AnyObject!){
                course.lastUpdateOn = dictAllCourse["last_update_on"] as! String
            }
            else{
                course.lastUpdateOn = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["creator_id"] as AnyObject!){
                course.creatorId = dictAllCourse["creator_id"] as! String
            }
            else{
                course.creatorId = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["hide_from_catalog"] as AnyObject!){
                course.hideFromCatalog = dictAllCourse["hide_from_catalog"] as! String
            }
            else{
                course.hideFromCatalog = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["time_limit"] as AnyObject!){
                course.timeLimit = dictAllCourse["time_limit"] as! String
            }
            else{
                course.timeLimit = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["level"] as AnyObject!){
                course.level = dictAllCourse["level"] as! String
            }
            else{
                course.level = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["shared"] as AnyObject!){
                course.shared = dictAllCourse["shared"] as! String
            }
            else{
                course.shared = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["shared_url"] as AnyObject!){
                course.sharedUrl = dictAllCourse["shared_url"] as! String
            }
            else{
                course.sharedUrl = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["avatar"] as AnyObject!){
                course.avatar = dictAllCourse["avatar"] as! String
            }
            else{
                course.avatar = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["big_avatar"] as AnyObject!){
                course.bigAvatar = dictAllCourse["big_avatar"] as! String
            }
            else{
                course.bigAvatar = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["certification"] as AnyObject!){
                course.certification = dictAllCourse["certification"] as! String
            }
            else{
                course.certification = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["certification_duration"] as AnyObject!){
                course.certificationDuration = dictAllCourse["certification_duration"] as! String
            }
            else{
                course.certificationDuration = ""
            }
            
            if StaticHelper.isObjectNotNil(object: dictAllCourse["custom_field_1"] as AnyObject!){
                course.customField1 = dictAllCourse["custom_field_1"] as! String
            }
            else{
                course.customField1 = ""
            }
            
            arrAllCourses.append(course)
            
            
        }
        
    }
    
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
    
}
