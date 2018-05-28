//
//  CategoryViewController.swift
//  NewsApp
//
//  Created by Apple on 28/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class CategoryViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet var CategoryCollectionView: UICollectionView!
    
    var categories = ["Life Style","Business","Politics","Entertainment","Culture and Religion","Technology","Social","Sports","Regional"]
    var categoriesImg = ["life_style","business","politics","entertainment","culture_and_religion","technology","social","sports","regional"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CategoryCollectionView.delegate = self
        CategoryCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        
        
        let slidemenu = self.slideMenuController()
        
        slidemenu?.openLeft()
       
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = CategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryListCollectionViewCell", for: indexPath) as! CategoryListCollectionViewCell
        
        cell.imgCategory.image = UIImage(named: categoriesImg[indexPath.row])
        cell.lblNameCategory.text = categories[indexPath.row]
        
        return cell
        
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
