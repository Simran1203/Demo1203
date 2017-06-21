//
//  AccountCell.swift
//  TalentLMS
//
//  Created by Simran on 03/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit

class AccountCell: UICollectionViewCell {
    
    @IBOutlet var lblNumber: UILabel!
    @IBOutlet var lblParameter: UILabel!
    
    @IBOutlet var verticalLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblParameter.font = UIFont.getCustomFont_ForSize(size: 10)
        lblNumber.font = UIFont.getCustomBoldFont_ForSize(size: 18)
    }
}
