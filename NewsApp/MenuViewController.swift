//
//  MenuViewController.swift
//  NewsApp
//
//  Created by Apple on 08/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var MenuTableView: UITableView!
    
    let menuitems = ["Dashboard","Category","Crypto News","Live Streaming","Share","Setting","Change Language","About Us","Logout"]
    
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
        
        cell.lblCellName.text = menuitems[indexPath.row]
       
        return cell
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
