//
//  NewsDetailFirstIndexTableViewCell.swift
//  NewsApp
//
//  Created by Apple on 24/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class NewsDetailFirstIndexTableViewCell: UITableViewCell {

    @IBOutlet var imgNews: UIImageView!
    @IBOutlet var btnPlay: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
