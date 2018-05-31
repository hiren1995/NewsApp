//
//  NewsDetailSecondIndexTableViewCell.swift
//  NewsApp
//
//  Created by Apple on 24/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class NewsDetailSecondIndexTableViewCell: UITableViewCell {

    @IBOutlet var lblNewsTitle: UILabel!
    @IBOutlet var lblNews: UILabel!
    @IBOutlet var lblDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
