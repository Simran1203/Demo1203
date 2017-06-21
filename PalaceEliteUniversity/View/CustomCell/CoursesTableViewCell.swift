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
    @IBOutlet var trackView: UIView!
    @IBOutlet var highlightedView: UIView!
    
    @IBOutlet var consHighlightedView: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTitle.font = UIFont.getCustomMediumFont_ForSize(size: 14)
        lblLoc.font = UIFont.getCustomFont_ForSize(size:12)
        lblProgress.font = UIFont.getCustomFont_ForSize(size: 12)
        lblType.font = UIFont.getCustomFont_ForSize(size: 12)
        lblDesc.font = UIFont.getCustomFont_ForSize(size: 11)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
