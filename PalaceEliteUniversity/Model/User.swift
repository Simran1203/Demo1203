//
//  User.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 05/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit

class User: NSObject,NSCoding {
    
    var userId = String()
    var login = String()
    var firstName = String()
    var lastName = String()
    var email = String()
    var userType = String()
    var timeZone = String()
    var status = String()
    var level = String()
    var points = String()
    var createdOn = String()
    var avatar = String()
    var bio = String()
    var loginKey = String()
    //    var courses = Courses()
    var branches = [Any]()
    var groups = [Any]()
    var certifications = [Any]()
    var badges = [Any]()
    
    override init() {
        super.init()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        userId = aDecoder.decodeObject(forKey: "userId") as! String
        login = aDecoder.decodeObject(forKey: "login") as! String
        firstName = aDecoder.decodeObject(forKey: "firstName") as! String
        lastName = aDecoder.decodeObject(forKey: "lastName") as! String
        email = aDecoder.decodeObject(forKey: "email") as! String
        userType = aDecoder.decodeObject(forKey: "userType") as! String
        timeZone = aDecoder.decodeObject(forKey: "timeZone") as! String
        status = aDecoder.decodeObject(forKey: "status") as! String
        level = aDecoder.decodeObject(forKey: "level") as! String
        points = aDecoder.decodeObject(forKey: "points") as! String
        createdOn = aDecoder.decodeObject(forKey: "createdOn") as! String
        avatar = aDecoder.decodeObject(forKey: "avatar") as! String
        bio = aDecoder.decodeObject(forKey: "bio") as! String
        loginKey = aDecoder.decodeObject(forKey: "loginKey") as! String
        branches = aDecoder.decodeObject(forKey: "branches") as! [Any]
        groups = aDecoder.decodeObject(forKey: "groups") as! [Any]
        certifications = aDecoder.decodeObject(forKey: "certifications") as! [Any]
        badges = aDecoder.decodeObject(forKey: "badges") as! [Any]
        
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(login, forKey: "login")
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(userType, forKey: "userType")
        aCoder.encode(timeZone, forKey: "timeZone")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(level, forKey: "level")
        aCoder.encode(points, forKey: "points")
        aCoder.encode(createdOn, forKey: "createdOn")
        aCoder.encode(avatar, forKey: "avatar")
        aCoder.encode(bio, forKey: "bio")
        aCoder.encode(loginKey, forKey: "loginKey")
        aCoder.encode(branches, forKey: "branches")
        aCoder.encode(groups, forKey: "groups")
        aCoder.encode(certifications, forKey: "certifications")
        aCoder.encode(badges, forKey: "badges")
        
        
    }
}
