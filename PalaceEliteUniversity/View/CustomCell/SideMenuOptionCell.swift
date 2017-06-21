//
//  SideMenuOptionCell.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 06/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit

class SideMenuOptionCell: UITableViewCell {
    
    @IBOutlet var lblOption: UILabel!
    @IBOutlet var imgOption: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblOption.font = UIFont.getCustomFont_ForSize(size: 15)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
