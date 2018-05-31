//
//  SlidingViewController.swift
//  NewsApp
//
//  Created by Apple on 08/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift


var SlideViewControllerFlag = 0

class SlidingViewController: SlideMenuController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        
        if SlideViewControllerFlag == 0
        {
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "dashboardViewController") {
                self.mainViewController = controller
            }
        }
        else if(SlideViewControllerFlag == 1)
        {
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "categoryViewController") {
                self.mainViewController = controller
            }
        }
        else if(SlideViewControllerFlag == 2)
        {
            btnMenuFlagNewsList = true
            
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "newsListViewController") {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let newsListViewController = storyboard.instantiateViewController(withIdentifier: "newsListViewController") as! NewsListViewController
                
                newsListViewController.categoryId = 1
                
                self.mainViewController = controller
            }
        }
       
        else if(SlideViewControllerFlag == 4)
        {
            fromPage = 1
            
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "topNewsViewController") {
                self.mainViewController = controller
            }
        }
        else if(SlideViewControllerFlag == 5)
        {
            fromPage = 2
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "topNewsViewController") {
                self.mainViewController = controller
            }
        }
        else if(SlideViewControllerFlag == 6)
        {
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "changeLanguageViewController") {
                self.mainViewController = controller
            }
        }
        
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "menuViewController") {
            self.leftViewController = controller
        }
        
        super.awakeFromNib()
        
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
