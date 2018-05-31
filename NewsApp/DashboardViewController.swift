//
//  DashboardViewController.swift
//  NewsApp
//
//  Created by Apple on 08/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import ROGoogleTranslate
import Alamofire
import SwiftyJSON
import MBProgressHUD
import SDWebImage

class DashboardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet var DashBoardTableView: UITableView!
    
    var APIData = JSON()
    
    var categories = ["Life Style","Business","Politics","Entertainment","Culture and Religion","Technology","Social","Sports","Regional"]
    var categoriesImg = ["life_style","business","politics","entertainment","culture_and_religion","technology","social","sports","regional"]
    var topnews = ["The World Global Warming Annual Summit","US President inaugrations help in Washington","Spotlight on Medtech Outsourcing and Innovation","The World Global Warming Annual Summit","US President inaugrations help in Washington","Spotlight on Medtech Outsourcing and Innovation"]
    var newsWriter = ["Michael Adams","Roy Montago","Michael Adams","Michael Adams","Roy Montago","Michael Adams"]
    var newstime = ["15 min","1 hour","2 hour","15 min","1 hour","2 hour"]
    var newsimg = ["global_warming","globe","global_warming","globe","global_warming","globe"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DashBoardTableView.delegate = self
        DashBoardTableView.dataSource = self
        
        
        loadData()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        //loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return topnews.count + 2
        
        return APIData["recent_news"].count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0)
        {
            let cell = Bundle.main.loadNibNamed("CategoriesTableViewCell", owner: self, options: nil)?.first as! CategoriesTableViewCell
            
            cell.CategoriesCollectionView.delegate = self
            cell.CategoriesCollectionView.dataSource = self
            
            cell.CategoriesCollectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")

            cell.selectionStyle = .none
            
            return cell
            
        }
        else if(indexPath.row == 1)
        {
            let cell = Bundle.main.loadNibNamed("TopNewsHeaderTableViewCell", owner: self, options: nil)?.first as! TopNewsHeaderTableViewCell
            
            cell.selectionStyle = .none
            
            return cell
        }
        else
        {
            let cell = Bundle.main.loadNibNamed("TopNewsTableViewCell", owner: self, options: nil)?.first as! TopNewsTableViewCell
            
            cell.CellView.ShadowAllBorders()
            
            cell.imgNews.sd_setImage(with: URL(string: APIData["recent_news"][indexPath.row - 2]["news_image"].stringValue), placeholderImage: UIImage(named: "dummy"))
            
            //cell.imgNews.image = UIImage(named: newsimg[indexPath.row - 2])
            
            if(userDefault.value(forKey: Language) as! String == "English")
            {
                //cell.lblNewsHeading.text = topnews[indexPath.row - 2]
                //cell.lblWriter.text = newsWriter[indexPath.row - 2]
                //cell.lblTime.text = newstime[indexPath.row - 2]
                
                //cell.lblWriter.text = newsWriter[indexPath.row - 2]
                
                
                cell.lblNewsHeading.text = APIData["recent_news"][indexPath.row - 2]["news_heading"].stringValue
                cell.lblTime.text = DateMeduimFromDate(dateStr: APIData["recent_news"][indexPath.row - 2]["news_date"].stringValue)
                
            }
            else
            {
                var params = ROGoogleTranslateParams(source: "en",
                                                     target: userDefault.value(forKey: LanguageCode) as! String,
                                                     text:   APIData["recent_news"][indexPath.row - 2]["news_heading"].stringValue)
                
                //var params1 = ROGoogleTranslateParams(source: "en",
                //                                     target: userDefault.value(forKey: LanguageCode) as! String,
                //                                     text:   newsWriter[indexPath.row - 2])
                
                var params2 = ROGoogleTranslateParams(source: "en",
                                                      target: userDefault.value(forKey: LanguageCode) as! String,
                                                      text:   DateMeduimFromDate(dateStr: APIData["recent_news"][indexPath.row - 2]["news_date"].stringValue))
                
                //let translator = ROGoogleTranslate(with: APIKey)
                
                let translator = ROGoogleTranslate()
                translator.apiKey = APIKey
                
                translator.translate(params: params) { (result) in
                    
                    DispatchQueue.main.async {
                        
                        cell.lblNewsHeading.text = result
                    }
                    
                    //print("Translation: \(result)")
                }
                
                /*
                translator.translate(params: params1) { (result) in
                    
                    DispatchQueue.main.async {
                        
                        cell.lblWriter.text = result
                    }
                    
                    //print("Translation: \(result)")
                }
                */
                
                translator.translate(params: params2) { (result) in
                    
                    DispatchQueue.main.async {
                        
                        cell.lblTime.text = result
                    }
                    
                    //print("Translation: \(result)")
                }
            }
            
            
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0)
        {
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //let NewsListViewController = storyboard.instantiateViewController(withIdentifier: "newsListViewController") as! NewsListViewController
            
            //self.present(NewsListViewController, animated: true, completion: nil)
        }
        else if(indexPath.row == 1)
        {
            
        }
        else
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newsDetailViewController = storyboard.instantiateViewController(withIdentifier: "newsDetailViewController") as! NewsDetailViewController
            
            newsDetailViewController.newsDetail = APIData["recent_news"][indexPath.row - 2]
            
            self.present(newsDetailViewController, animated: true, completion: nil)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 180
        }
            else if(indexPath.row == 1)
        {
            return 60
        }
        else
        {
            return 135
            
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //return categories.count
        
        return APIData["category_list"].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectioncell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CategoriesCollectionViewCell
       
        //collectioncell.imgCategory.image = UIImage(named: categoriesImg[indexPath.row])
        
        collectioncell.imgCategory.sd_setImage(with: URL(string: APIData["category_list"][indexPath.row]["category_image"].stringValue), placeholderImage: UIImage(named: "dummy"))
        
        
        if(userDefault.value(forKey: Language) as! String == "English")
        {
            //collectioncell.lblCategory.text = categories[indexPath.row]
            
            collectioncell.lblCategory.text = APIData["category_list"][indexPath.row]["category_name"].stringValue
        }
        else
        {
            var params = ROGoogleTranslateParams(source: "en",
                                                 target: userDefault.value(forKey: LanguageCode) as! String,
                                                 text:   APIData["category_list"][indexPath.row]["category_name"].stringValue)
            
            let translator = ROGoogleTranslate()
            translator.apiKey = APIKey
            
            translator.translate(params: params) { (result) in
                
                DispatchQueue.main.async {
                    
                    collectioncell.lblCategory.text = result
                }
                
                //print("Translation: \(result)")
            }
            
        }
        
        
        
        return collectioncell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        btnMenuFlagNewsList = false
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let NewsListViewController = storyboard.instantiateViewController(withIdentifier: "newsListViewController") as! NewsListViewController
        
        NewsListViewController.categoryId = APIData["category_list"][indexPath.row]["cid"].intValue
        
        self.present(NewsListViewController, animated: true, completion: nil)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }

    @IBAction func btnMenu(_ sender: UIButton) {
        
        let slidemenu = self.slideMenuController()
        
        slidemenu?.openLeft()
    }
    
    
    func loadData()
    {
        
        let SignupParameters:Parameters = ["device_id": 123,"device_token": 123456 ,"os_type" :  2 ]
        
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        print(SignupParameters)
        
        Alamofire.request(signupAPI, method: .post, parameters: SignupParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                
                print(JSON(response.result.value))
                
                var tempDict = JSON(response.result.value!)
                
                if(tempDict["status"] == "success" && tempDict["status_code"].intValue == 1)
                {
                    
                    userDefault.set(tempDict["user_details"][0]["user_id"].intValue , forKey: userId)
                    userDefault.set(tempDict["user_details"][0]["user_token"].stringValue, forKey: userToken)
                    
                    print(userDefault.value(forKey: userId) as! Int)
                    print(userDefault.value(forKey: userToken) as! String)
                    
                    
                    let CategoryParameters:Parameters = ["user_id": userDefault.value(forKey: userId) as! Int  ,"user_token": userDefault.value(forKey: userToken) as! String]
                    
                    
                    print(CategoryParameters)
                    
                    Alamofire.request(categoryListAPI, method: .post, parameters: CategoryParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                        if(response.result.value != nil)
                        {
                            Spinner.hide(animated: true)
                            
                            print(JSON(response.result.value))
                            
                            self.APIData = JSON(response.result.value!)
                            
                            if(self.APIData["status"] == "success" && self.APIData["status_code"].intValue == 1)
                            {
                                self.DashBoardTableView.reloadData()
                                
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
                    
                    //let story = UIStoryboard(name: "Main", bundle: nil)
                    //let x = story.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
                    //x.DashBoardTableView.reloadData()
                }
                    
                else
                {
                    self.showAlert(Title: "Alert", Message: "Something Went Wrong while SignUP")
                }
                
            }
            else
            {
                
                self.showAlert(Title: "Alert", Message: "Something Went Wrong ")
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
