//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Apple on 24/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    @IBOutlet var NewsListTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        NewsListTableView.delegate = self
        NewsListTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0)
        {
            let cell = Bundle.main.loadNibNamed("NewsListFirstIndexTableViewCell", owner: self, options: nil)?.first as! NewsListFirstIndexTableViewCell
            
            cell.NewsListCollectionView.delegate = self
            cell.NewsListCollectionView.dataSource = self
            
            cell.NewsListCollectionView.register(UINib(nibName: "NewsListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
            
            cell.selectionStyle = .none
            
            return cell
        }
        else
        {
            let cell = Bundle.main.loadNibNamed("NewsListSecondIndexTableViewCell", owner: self, options: nil)?.first as! NewsListSecondIndexTableViewCell
            
            
            
            return cell
        }
        
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
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectioncell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! NewsListCollectionViewCell
        
       
        return collectioncell
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
