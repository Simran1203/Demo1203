//
//  CoursesTableViewCell.swift
//  TalentLMS
//
//  Created by Simran on 03/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit


class CoursesTableViewCell: UITableViewCell {

    @IBOutlet var imgCourse: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblLoc: UILabel!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var lblProgress: UILabel!
    @IBOutlet var lblType: UILabel!
    @IBOutlet var linearProgressView: LinearProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
