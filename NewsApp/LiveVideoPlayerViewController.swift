//
//  LiveVideoPlayerViewController.swift
//  NewsApp
//
//  Created by Apple on 30/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import YouTubePlayer

class LiveVideoPlayerViewController: UIViewController {

    @IBOutlet var LiveVideoPlayer: YouTubePlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let myVideoURL = NSURL(string: "https://www.youtube.com/watch?v=X7Ktabhd8a4")
        LiveVideoPlayer.loadVideoURL(myVideoURL! as URL)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        
        LiveVideoPlayer.stop()
        self.dismiss(animated: true, completion: nil)
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
