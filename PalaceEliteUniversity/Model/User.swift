//
//  User.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 05/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit

class User: NSObject {

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
    var courses = Courses()
    var branches = [Any]()
    var groups = [Any]()
    var certifications = [Any]()
    var badges = [Any]()
    
 
}
