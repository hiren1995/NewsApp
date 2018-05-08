//
//  TopNewsTableViewCell.swift
//  NewsApp
//
//  Created by Apple on 08/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class TopNewsTableViewCell: UITableViewCell {

    @IBOutlet var CellView: UIView!
    @IBOutlet var imgNews: UIImageView!
    @IBOutlet var lblNewsHeading: UILabel!
    @IBOutlet var lblWriter: UILabel!
    @IBOutlet var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
