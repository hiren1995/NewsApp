//
//  NewsListViewController.swift
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

var btnMenuFlagNewsList = false

class NewsListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet var NewsListTableView: UITableView!
    @IBOutlet var imgNavBtn: UIImageView!
    
    var categoryId = 1 // by default to crypto news..!
    
    var NewsList = JSON()
    
    
    var images = ["congrats_bg","cover_image"]
    var news = ["Testing News Demo 1","Testing News Demo 2"]
    var dates = ["28 May","29 May"]
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        NewsListTableView.delegate = self
        NewsListTableView.dataSource = self
        
        if btnMenuFlagNewsList
        {
            imgNavBtn.image = UIImage(named: "menu_options")
            //imgNavBtn.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        }
        else
        {
            imgNavBtn.image = UIImage(named: "left_arrow")
            //imgNavBtn.frame = CGRect(x: 16, y: 15, width: 20, height: 20)
        }
        
        loadData()
        
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return news.count + 1
        
        return NewsList["news_list_category"].count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0)
        {
            let cell = Bundle.main.loadNibNamed("NewsListFirstIndexTableViewCell", owner: self, options: nil)?.first as! NewsListFirstIndexTableViewCell
            
            cell.NewsListCollectionView.delegate = self
            cell.NewsListCollectionView.dataSource = self
            cell.NewsListCollectionView.isPagingEnabled = true
            
            cell.NewsListCollectionView.register(UINib(nibName: "NewsListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
            
            cell.selectionStyle = .none
            
            return cell
        }
        else
        {
            let cell = Bundle.main.loadNibNamed("NewsListSecondIndexTableViewCell", owner: self, options: nil)?.first as! NewsListSecondIndexTableViewCell
            
            
            cell.selectionStyle = .none
            
            //cell.imgNews.image = UIImage(named: images[indexPath.row - 1])
            //cell.lblNewsTitle.text = news[indexPath.row - 1]
            //cell.lblNewsDate.text = dates[indexPath.row - 1]
            
            
            cell.lblNewsTitle.text = NewsList["news_list_category"][indexPath.row - 1]["news_heading"].stringValue
            cell.lblNewsDate.text = DateMeduimFromDate(dateStr: NewsList["news_list_category"][indexPath.row - 1]["news_date"].stringValue)
            cell.imgNews.sd_setImage(with: URL(string: NewsList["news_list_category"][indexPath.row - 1]["news_image"].stringValue), placeholderImage: UIImage(named: "dummy"))
            
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newsDetailViewController = storyboard.instantiateViewController(withIdentifier: "newsDetailViewController") as! NewsDetailViewController
        
        newsDetailViewController.newsDetail = NewsList["news_list_category"][indexPath.row - 1]
        
        self.present(newsDetailViewController, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row == 0)
        {
            return 270
        }
        else
        {
            return 150
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //return 5
        
        //return images.count
        
        return NewsList["news_list_category"].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectioncell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! NewsListCollectionViewCell
        
       
        //collectioncell.imgNews.image = UIImage(named: images[indexPath.row])
        //collectioncell.titleNews.text = news[indexPath.row]
        
        collectioncell.imgNews.sd_setImage(with: URL(string: NewsList["news_list_category"][indexPath.row]["news_image"].stringValue), placeholderImage: UIImage(named: "dummy"))
        collectioncell.titleNews.text = NewsList["news_list_category"][indexPath.row]["news_heading"].stringValue
        
        return collectioncell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        //return CGSize(width: 120, height: 120)
        
        return UICollectionViewFlowLayoutAutomaticSize
    }
    @IBAction func btnNav(_ sender: UIButton) {
        
        if btnMenuFlagNewsList
        {
            let slidemenu = self.slideMenuController()
            
            slidemenu?.openLeft()
        }
        else
        {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func loadData()
    {
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let NewListParameters:Parameters = ["user_id": userDefault.value(forKey: userId) as! Int  ,"user_token": userDefault.value(forKey: userToken) as! String,"category_id": categoryId]
        
        
        print(NewListParameters)
        
        Alamofire.request(NewsCategoryListAPI, method: .post, parameters: NewListParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                
                print(JSON(response.result.value))
                
                self.NewsList = JSON(response.result.value!)
                
                if(self.NewsList["status"] == "success" && self.NewsList["status_code"].intValue == 1)
                {
                    self.NewsListTableView.reloadData()
                    
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
