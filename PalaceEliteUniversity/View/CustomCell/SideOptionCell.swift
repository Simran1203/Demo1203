//
//  SideOptionCell.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 08/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit

class SideOptionCell: UITableViewCell {
    
    @IBOutlet var lblCell: UILabel!
     @IBOutlet var underLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblCell.font = UIFont.getCustomFont_ForSize(size: 14)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
