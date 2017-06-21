//
//  UserCache.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 08/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit


class UserCache: NSObject {

    class var sharedInstance : UserCache {
        struct Static {
            static let instance = UserCache()
        }
        
        return Static.instance
    }
    
    
    func saveAccountData(userData: User){
        
        let userDefault = UserDefaults.standard
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: userData)
      
        userDefault.setValue(encodedData, forKey:"userData")
        userDefault.synchronize()
        
    }
    
    func saveCourseData(arrCourseData: [Courses]){
        
        let userDefault = UserDefaults.standard
    
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: arrCourseData)
        
        userDefault.setValue(encodedData, forKey:"courseData")
        userDefault.synchronize()
        
    }
    
    func saveUserData(_ userDetails: [String: Any]) {
        let userDefault = UserDefaults.standard
        
        userDefault.setValue(userDetails["user_id"], forKey:"userId")
        userDefault.synchronize()
    }
    
    func clearUserData() {
        let userDefault = UserDefaults.standard
        
        userDefault.setValue(nil, forKey:"userId")
        userDefault.synchronize()
    }
    
    class func userID() -> String {
        return UserDefaults.standard.object(forKey: "userId") as! String
    }
    
}
