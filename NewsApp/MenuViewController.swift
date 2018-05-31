//
//  MenuViewController.swift
//  NewsApp
//
//  Created by Apple on 08/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import ROGoogleTranslate
import AVKit
import AVFoundation

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var MenuTableView: UITableView!
    
    let menuitems = ["Dashboard","Category","Crypto News","Live Streaming","Real Spirituality","World Future News","Change Language","About Us"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MenuTableView.delegate = self
        MenuTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return  menuitems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MenuTableView.dequeueReusableCell(withIdentifier: "menuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        
        print(userDefault.value(forKey: LanguageCode) as! String)
        
        
        if(userDefault.value(forKey: Language) as! String == "English")
        {
            cell.lblCellName.text = menuitems[indexPath.row]
        }
        else
        {
            var params = ROGoogleTranslateParams(source: "en",
                                                 target: userDefault.value(forKey: LanguageCode) as! String,
                                                 text:   menuitems[indexPath.row])
            
            //let translator = ROGoogleTranslate(with: APIKey)
            
            let translator = ROGoogleTranslate()
            translator.apiKey = APIKey
            
            translator.translate(params: params) { (result) in
                
                DispatchQueue.main.async {
                    //self.translation.text = "\(result)"
                    
                    print("Translation: \(result)")
                    
                    cell.lblCellName.text = result
                }
                
                //print("Translation: \(result)")
            }
        }
        
        //cell.lblCellName.text = menuitems[indexPath.row]
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if(indexPath.row == 3)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let liveVideoPlayerViewController = storyboard.instantiateViewController(withIdentifier: "liveVideoPlayerViewController") as! LiveVideoPlayerViewController
            
            self.present(liveVideoPlayerViewController, animated: true, completion: nil)
        }
        else
        {
            if(indexPath.row == 0)
            {
                SlideViewControllerFlag = 0
            }
            else if(indexPath.row == 1)
            {
                SlideViewControllerFlag = 1
            }
            else if(indexPath.row == 2)
            {
                SlideViewControllerFlag = 2
            }
                
            else if(indexPath.row == 4)
            {
                SlideViewControllerFlag = 4
            }
            else if(indexPath.row == 5)
            {
                SlideViewControllerFlag = 5
            }
            else if(indexPath.row == 6)
            {
                SlideViewControllerFlag = 6
            }
            else
            {
                
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let slidingViewController = storyboard.instantiateViewController(withIdentifier: "slidingViewController") as! SlidingViewController
            
            self.present(slidingViewController, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
        
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
