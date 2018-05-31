//
//  CategoryViewController.swift
//  NewsApp
//
//  Created by Apple on 28/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import Alamofire
import SwiftyJSON
import SDWebImage
import MBProgressHUD

class CategoryViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet var CategoryCollectionView: UICollectionView!
    
    var categoryList = JSON()
    
    var categories = ["Life Style","Business","Politics","Entertainment","Culture and Religion","Technology","Social","Sports","Regional"]
    var categoriesImg = ["life_style","business","politics","entertainment","culture_and_religion","technology","social","sports","regional"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CategoryCollectionView.delegate = self
        CategoryCollectionView.dataSource = self
        
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        
        
        let slidemenu = self.slideMenuController()
        
        slidemenu?.openLeft()
       
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //return categories.count
        
        return categoryList["category_list"].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = CategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryListCollectionViewCell", for: indexPath) as! CategoryListCollectionViewCell
        
        //cell.imgCategory.image = UIImage(named: categoriesImg[indexPath.row])
        //cell.lblNameCategory.text = categories[indexPath.row]
        
        
        cell.lblNameCategory.text = categoryList["category_list"][indexPath.row]["category_name"].stringValue
        cell.imgCategory.sd_setImage(with: URL(string: categoryList["category_list"][indexPath.row]["category_image"].stringValue), placeholderImage: UIImage(named: "dummy"))
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        btnMenuFlagNewsList = false
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let NewsListViewController = storyboard.instantiateViewController(withIdentifier: "newsListViewController") as! NewsListViewController
        
        NewsListViewController.categoryId = categoryList["category_list"][indexPath.row]["cid"].intValue
        
        self.present(NewsListViewController, animated: true, completion: nil)
    }
    
    func loadData()
    {
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let CategoryListParameters:Parameters = ["user_id": userDefault.value(forKey: userId) as! Int  ,"user_token": userDefault.value(forKey: userToken) as! String]
        
        
        print(CategoryListParameters)
        
        Alamofire.request(categoryListAPI, method: .post, parameters: CategoryListParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                
                print(JSON(response.result.value))
                
                self.categoryList = JSON(response.result.value!)
                
                if(self.categoryList["status"] == "success" && self.categoryList["status_code"].intValue == 1)
                {
                    self.CategoryCollectionView.reloadData()
                    
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
