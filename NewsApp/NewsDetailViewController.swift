//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Apple on 24/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
import SDWebImage

class NewsDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet var NewsDetailTableView: UITableView!
    
    var newsDetail = JSON()
    
    
    let newstitle = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    
    let news = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum,comes from a line in section 1.10.32."
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        NewsDetailTableView.delegate = self
        NewsDetailTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0)
        {
            let cell = Bundle.main.loadNibNamed("NewsDetailFirstIndexTableViewCell", owner: self, options: nil)?.first as! NewsDetailFirstIndexTableViewCell
            
            cell.selectionStyle = .none
            
            //cell.imgNews.image = UIImage(named: "cover_image")
            
            cell.imgNews.sd_setImage(with: URL(string: newsDetail["news_image"].stringValue), placeholderImage: UIImage(named: "dummy"))
            cell.btnPlay.addTarget(self, action: #selector(btnPlay), for: .touchUpInside)
            
            return cell
        }
        else
        {
            let cell = Bundle.main.loadNibNamed("NewsDetailSecondIndexTableViewCell", owner: self, options: nil)?.first as! NewsDetailSecondIndexTableViewCell
            
            cell.selectionStyle = .none
            
            //cell.lblNewsTitle.text = newstitle
            //cell.lblNews.text = news
            
            cell.lblNewsTitle.text = newsDetail["news_heading"].stringValue
            cell.lblNews.text = newsDetail["news_description"].stringValue
            cell.lblDate.text = DateMeduimFromDate(dateStr: newsDetail["news_date"].stringValue)
            
            return cell
        }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row == 0)
        {
            return 280
        }
        else
        {
            return UITableViewAutomaticDimension
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func btnPlay()
    {
        let youtubelink = "https://www.youtube.com/watch?v="
        
        if let url = URL(string: youtubelink + newsDetail["news_youtube_id"].stringValue ) {
            UIApplication.shared.openURL(url)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
