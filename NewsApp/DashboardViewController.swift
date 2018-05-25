//
//  DashboardViewController.swift
//  NewsApp
//
//  Created by Apple on 08/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class DashboardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet var DashBoardTableView: UITableView!
    
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
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topnews.count + 2
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
            cell.lblNewsHeading.text = topnews[indexPath.row - 2]
            cell.imgNews.image = UIImage(named: newsimg[indexPath.row - 2])
            cell.lblWriter.text = newsWriter[indexPath.row - 2]
            cell.lblTime.text = newstime[indexPath.row - 2]
            
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
        
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectioncell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CategoriesCollectionViewCell
       
        collectioncell.lblCategory.text = categories[indexPath.row]
        collectioncell.imgCategory.image = UIImage(named: categoriesImg[indexPath.row])
        
        return collectioncell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let NewsListViewController = storyboard.instantiateViewController(withIdentifier: "newsListViewController") as! NewsListViewController
        
        self.present(NewsListViewController, animated: true, completion: nil)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }

    @IBAction func btnMenu(_ sender: UIButton) {
        
        let slidemenu = self.slideMenuController()
        
        slidemenu?.openLeft()
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
