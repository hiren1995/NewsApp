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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DashBoardTableView.delegate = self
        DashBoardTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0)
        {
            let cell = Bundle.main.loadNibNamed("CategoriesTableViewCell", owner: self, options: nil)?.first as! CategoriesTableViewCell
            
            cell.CategoriesCollectionView.delegate = self
            cell.CategoriesCollectionView.dataSource = self
            
            cell.CategoriesCollectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")

            
            return cell
            
        }
        else
        {
            let cell = Bundle.main.loadNibNamed("CategoriesTableViewCell", owner: self, options: nil)?.first as! CategoriesTableViewCell
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 180
        }
        else
        {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectioncell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CategoriesCollectionViewCell
       
        return collectioncell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        
        let slidemenu = self.slideMenuController()
        
        slidemenu?.openLeft()
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
