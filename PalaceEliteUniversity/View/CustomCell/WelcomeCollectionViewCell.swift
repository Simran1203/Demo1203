//
//  WelcomeCollectionViewCell.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 06/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit

class WelcomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var btnGetStarted: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblHeader.font = UIFont.getCustomFont_ForSize(size: 21)
        lblDesc.font = UIFont.getCustomFont_ForSize(size: 13)
        
        
    }
}
