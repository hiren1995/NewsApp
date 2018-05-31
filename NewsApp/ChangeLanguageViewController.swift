//
//  ChangeLanguageViewController.swift
//  NewsApp
//
//  Created by Apple on 30/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ChangeLanguageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var ChangeLanguageTableView: UITableView!
    
    var languages = ["English","Hindi","Urdu","Arabic"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //userDefault.set("English", forKey: Language)
        
        ChangeLanguageTableView.delegate = self
        ChangeLanguageTableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ChangeLanguageTableView.dequeueReusableCell(withIdentifier: "changeLanguageTableViewCell", for: indexPath) as! ChangeLanguageTableViewCell
        
    
        
        cell.lblLanguageName.text = languages[indexPath.row]
        
        if(languages[indexPath.row] == userDefault.value(forKey: Language) as! String)
        {
            cell.imgLanguageSelected.image = UIImage(named: "success_tick")
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0)
        {
            userDefault.removeObject(forKey: Language)
            userDefault.set("English", forKey: Language)
            userDefault.set("en", forKey: LanguageCode)
            
            SlideViewControllerFlag = 0
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let slidingViewController = storyboard.instantiateViewController(withIdentifier: "slidingViewController") as! SlidingViewController
            
            self.present(slidingViewController, animated: true, completion: nil)
        }
        else if(indexPath.row == 1)
        {
            userDefault.removeObject(forKey: Language)
            userDefault.set("Hindi", forKey: Language)
            userDefault.set("hi", forKey: LanguageCode)
            
            SlideViewControllerFlag = 0
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let slidingViewController = storyboard.instantiateViewController(withIdentifier: "slidingViewController") as! SlidingViewController
            
            self.present(slidingViewController, animated: true, completion: nil)
        }
        else if(indexPath.row == 2)
        {
            userDefault.removeObject(forKey: Language)
            userDefault.set("Urdu", forKey: Language)
            userDefault.set("ur", forKey: LanguageCode)
            
            SlideViewControllerFlag = 0
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let slidingViewController = storyboard.instantiateViewController(withIdentifier: "slidingViewController") as! SlidingViewController
            
            self.present(slidingViewController, animated: true, completion: nil)
        }
        else
        {
            userDefault.removeObject(forKey: Language)
            userDefault.set("Arabic", forKey: Language)
            userDefault.set("ar", forKey: LanguageCode)
            
            SlideViewControllerFlag = 0
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let slidingViewController = storyboard.instantiateViewController(withIdentifier: "slidingViewController") as! SlidingViewController
            
            self.present(slidingViewController, animated: true, completion: nil)
        }
        
        //SlideViewControllerFlag = 0
        
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let slidingViewController = storyboard.instantiateViewController(withIdentifier: "slidingViewController") as! SlidingViewController
        
        //self.present(slidingViewController, animated: true, completion: nil)
        
        //ChangeLanguageTableView.reloadData()
        
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
