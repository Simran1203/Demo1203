//
//  CoursesCollectionViewCell.swift
//  TalentLMS
//
//  Created by Simran on 03/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit

class CoursesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imgCourse: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblType: UILabel!
    @IBOutlet var lblLoc: UILabel!
    @IBOutlet var lblProgress: UILabel!
    @IBOutlet var trackView: UIView!
    @IBOutlet var highlightedView: UIView!
    @IBOutlet var consCHighlightedView: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblType.font = UIFont.getCustomFont_ForSize(size: 14)
        lblLoc.font = UIFont.getCustomFont_ForSize(size:13)
        lblProgress.font = UIFont.getCustomFont_ForSize(size: 13)
        lblTitle.font = UIFont.getCustomMediumFont_ForSize(size: 14)
    }
    
}
