//
//  LogoutCell.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 09/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit

class LogoutCell: UICollectionViewCell {
    
    
    @IBOutlet var lblHeading: UILabel!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var btnRight: UIButton!
    @IBOutlet var btnLeft: UIButton!
    @IBOutlet var btnLearn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblHeading.font = UIFont.getCustomFont_ForSize(size: 15)
        lblDesc.font = UIFont.getCustomFont_ForSize(size: 12)
    }

}
