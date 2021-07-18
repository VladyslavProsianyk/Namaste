//
//  YouTubeVideoViewController.swift
//  Namaste
//
//  Created by Vladyslav Prosianyk on 25.05.2021.
//

import UIKit
import youtube_ios_player_helper

class YouTubeVideoViewController: UIViewController, YTPlayerViewDelegate {
    
    static let identifire = "YouTubeVideoViewController"
    
    var index = 0
    var videoID: String?
    
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var lAsanaName: UILabel!
    @IBOutlet weak var topView: UIView!
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lAsanaName.tintColor = UIColor.white
        lAsanaName.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        lAsanaName.layer.cornerRadius = 5
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = topView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        topView.addSubview(blurEffectView)
        
        self.lAsanaName.text = yogaAsanas[index].sanskritName
        
        self.playerView.delegate = self
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_image")!)
        
        self.sendRequest()
    }
    
    
    func sendRequest() {
        
        let url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=how+to+do+\(valueSelected)+yoga+pose&maxResults=1&&safeSearch=moderate&key=\(youtube_Key)"
        
        NetworkLayer.shared.sendRequest(YouTubeRequest(url: url, onError: { (error) in
            debugPrint(error.debugDescription)
        }, onSuccess: { (data) in
            
            self.videoID = data.items[0].id.videoId
            DispatchQueue.main.async {
                self.playerView.load(withVideoId: self.videoID ?? "")
            }
            
            
        }), clas: YouTubeVideo.self)
    }
    
    
}
