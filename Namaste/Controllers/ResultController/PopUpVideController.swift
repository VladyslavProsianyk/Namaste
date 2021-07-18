//
//  PopUpVideController.swift
//  Namaste
//
//  Created by Vladyslav Prosianyk on 24.06.2021.
//

import UIKit
import youtube_ios_player_helper

class PopUpVideController: UIViewController, YTPlayerViewDelegate {
    
    static let identifire = "PopUpVideController"
    
    var videoID = ""
    var videoTitle = ""
    
    @IBOutlet weak var videoName: UILabel!
    @IBOutlet weak var videoPlayer: YTPlayerView!
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        moveOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.videoName.text = videoTitle
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        self.videoPlayer.load(withVideoId: videoID)
        self.videoPlayer.delegate = self
        
        moveIn()
    }
    
    func moveIn() {
        self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        self.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.24) {
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1.0
        }
    }
    
    func moveOut() {
        UIView.animate(withDuration: 0.24, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
            self.view.alpha = 0.0
        }) { _ in
            self.view.removeFromSuperview()
        }
    }
   
}
