//
//  RandomYogaAssanaViewController.swift
//  Namaste
//
//  Created by Vladyslav Prosianyk on 12.05.2021.
//

import UIKit
import CoreData
import WebKit

class RandomYogaAsanaViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    static let identifire = "RandomYogaAsanaViewController"
    
    let defaults = UserDefaults.standard
    
    var index: Int = UserDefaults.standard.integer(forKey: "index")
        
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    @IBOutlet weak var lSanscritName: UILabel!
    @IBOutlet weak var wvAsanaImage: WKWebView!
    @IBOutlet weak var lEnglishName: UILabel!
    @IBOutlet weak var nowToDoBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    
    @IBAction func onPress(_ sender: UIButton) {
        let nextViewController = self.storyboard!.instantiateViewController(withIdentifier: YouTubeVideoViewController.identifire) as! YouTubeVideoViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        nextViewController.index = index 
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spiner.stopAnimating()
        self.spiner.hidesWhenStopped = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = topView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        topView.addSubview(blurEffectView)

        wvAsanaImage.uiDelegate = self
        wvAsanaImage.navigationDelegate = self
        spiner.startAnimating()
        
        wvAsanaImage.backgroundColor = .white.withAlphaComponent(0.4)
        lSanscritName.backgroundColor = .black.withAlphaComponent(0.3)
        lEnglishName.backgroundColor = .black.withAlphaComponent(0.3)
        nowToDoBtn.backgroundColor = .yellow
        wvAsanaImage.layer.cornerRadius = 10
        lSanscritName.layer.cornerRadius = 5
        lEnglishName.layer.cornerRadius = 5
        nowToDoBtn.layer.cornerRadius = 5
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_image")!)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        let date = Date()
        let strDate = formatter.string(from: date)
        
        if defaults.string(forKey: "currentDay") != strDate {
            
            defaults.set(strDate, forKey: "currentDay")
            
            repeat {
                defaults.set(randomIndex, forKey: "index")
            } while defaults.bool(forKey: "\(yogaAsanas[index].id)")
            
        }
        
        let filteredAsanas = yogaAsanas.filter({defaults.bool(forKey: "\($0.id)") == false})
        
        if filteredAsanas.count == 0 {
            nullifyFlags()
        }
        
        lSanscritName.text = yogaAsanas[index].sanskritName
        lEnglishName.text = yogaAsanas[index].englishName
        let nameWithoutSpaces = yogaAsanas[index].sanskritName.replacingOccurrences(of: " ", with: "+")
        valueSelected = nameWithoutSpaces
        
        let imageUrl = URL(string: yogaAsanas[index].imgURL)
        self.wvAsanaImage.load(URLRequest(url: imageUrl!))
        
    }
}

