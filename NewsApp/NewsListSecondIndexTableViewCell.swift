//
//  NewsListSecondIndexTableViewCell.swift
//  NewsApp
//
//  Created by Apple on 25/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class NewsListSecondIndexTableViewCell: UITableViewCell {

    @IBOutlet var imgNews: UIImageView!
    @IBOutlet var lblNewsTitle: UILabel!
    @IBOutlet var lblNewsDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
