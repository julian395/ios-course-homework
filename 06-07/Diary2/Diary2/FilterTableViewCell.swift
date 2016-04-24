//
//  FilterTableViewCell.swift
//  Diary2
//
//  Created by Julian1 on 12.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

   
    @IBOutlet weak var notateImg: UIImageView!
    @IBOutlet weak var notateTitle: UILabel!
    @IBOutlet weak var notateDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
