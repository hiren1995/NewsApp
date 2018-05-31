//
//  TopNewsViewController.swift
//  NewsApp
//
//  Created by Apple on 29/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
import SDWebImage

var fromPage = Int()

class TopNewsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet var TopNewsTableView: UITableView!
    @IBOutlet var lblHeader: UILabel!
    
    var TopNewsList = JSON()
    
    var topnews = ["The World Global Warming Annual Summit","US President inaugrations help in Washington","Spotlight on Medtech Outsourcing and Innovation","The World Global Warming Annual Summit","US President inaugrations help in Washington","Spotlight on Medtech Outsourcing and Innovation"]
    var newsWriter = ["Michael Adams","Roy Montago","Michael Adams","Michael Adams","Roy Montago","Michael Adams"]
    var newstime = ["15 min","1 hour","2 hour","15 min","1 hour","2 hour"]
    var newsimg = ["global_warming","globe","global_warming","globe","global_warming","globe"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        TopNewsTableView.delegate = self
        TopNewsTableView.dataSource = self
        
        if(fromPage == 1)
        {
            lblHeader.text = "Real Spirituality"
        }
        else
        {
            lblHeader.text = "World Future News"
        }
        
        loadDate()
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return topnews.count
        
        return TopNewsList["news_list_category"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("TopNewsTableViewCell", owner: self, options: nil)?.first as! TopNewsTableViewCell
        
        //cell.CellView.ShadowAllBorders()
        //cell.lblNewsHeading.text = topnews[indexPath.row]
        //cell.imgNews.image = UIImage(named: newsimg[indexPath.row])
        //cell.lblWriter.text = newsWriter[indexPath.row]
        //cell.lblTime.text = newstime[indexPath.row]
        
        cell.CellView.ShadowAllBorders()
        
        
        cell.lblNewsHeading.text = TopNewsList["news_list_category"][indexPath.row]["news_heading"].stringValue
        
        cell.lblTime.text = DateMeduimFromDate(dateStr: TopNewsList["news_list_category"][indexPath.row]["news_date"].stringValue)
        
        cell.imgNews.sd_setImage(with: URL(string: TopNewsList["news_list_category"][indexPath.row]["news_image"].stringValue), placeholderImage: UIImage(named: "dummy"))
        
        //cell.lblWriter.text = newsWriter[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newsDetailViewController = storyboard.instantiateViewController(withIdentifier: "newsDetailViewController") as! NewsDetailViewController
        
        newsDetailViewController.newsDetail = TopNewsList["news_list_category"][indexPath.row]
        
        self.present(newsDetailViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 135
    }
    
    @IBAction func btbnMenu(_ sender: UIButton) {
        
        let slidemenu = self.slideMenuController()
        
        slidemenu?.openLeft()

    }
    
    
    func loadDate()
    {
        
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        var CategoryListParameters = Parameters()
        
        if(fromPage == 1)
        {
           CategoryListParameters = ["user_id": userDefault.value(forKey: userId) as! Int  ,"user_token": userDefault.value(forKey: userToken) as! String,"category_id": 2]
        }
        else
        {
            CategoryListParameters = ["user_id": userDefault.value(forKey: userId) as! Int  ,"user_token": userDefault.value(forKey: userToken) as! String,"category_id": 3]
        }
        
        
        
        print(CategoryListParameters)
        
        Alamofire.request(NewsCategoryListAPI, method: .post, parameters: CategoryListParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                
                print(JSON(response.result.value))
                
                self.TopNewsList = JSON(response.result.value!)
                
                if(self.TopNewsList["status"] == "success" && self.TopNewsList["status_code"].intValue == 1)
                {
                    self.TopNewsTableView.reloadData()
                    
                }
                else
                {
                    self.showAlert(Title: "Alert", Message: "Something Went Wrong")
                }
                
            }
            else
            {
                Spinner.hide(animated: true)
                self.showAlert(Title: "Alert", Message: "Something Went Wrong")
            }
        })
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
