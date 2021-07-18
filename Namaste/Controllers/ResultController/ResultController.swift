//
//  ResultController.swift
//  Namaste
//
//  Created by Vladyslav Prosianyk on 23.06.2021.
//

import UIKit

class ResultController: UIViewController {
    
    static let identifire = "ResultController"
    
    var lblName = ""
    var valueForRequest = ""
    
    var videos = [Item]()

    @IBOutlet weak var resultsTblVw: UITableView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var topView: UIView!

    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = topView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        topView.addSubview(blurEffectView)
                
        self.resultsTblVw.delegate = self
        self.resultsTblVw.dataSource = self
        
        self.categoryLbl.text = "Category: \(self.lblName)"
        
        self.resultsTblVw.separatorStyle = .none
        
        self.resultsTblVw.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 10, right: 0)

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_image")!)

        self.resultsTblVw.register(UINib(nibName: ResultCell.identifire, bundle: nil), forCellReuseIdentifier: ResultCell.identifire)
        
        self.startLoading()
        self.sendRequest()
        
    }
    
    func sendRequest() {
        let url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(valueForRequest)&maxResults=30&&safeSearch=moderate&key=\(youtube_Key)"
        
        NetworkLayer.shared.sendRequest(YouTubeRequest(url: url, onError: { error in
            debugPrint(error.debugDescription)
        }, onSuccess: { data in
 
            self.videos = data.items
            DispatchQueue.main.async {
                self.alert.dismiss(animated: true, completion: nil)
                self.resultsTblVw.reloadData()
            }
                
        }), clas: YouTubeVideo.self)
        
    }
    
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    func startLoading() {
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
}

extension ResultController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: PopUpVideController.identifire) as! PopUpVideController
        
        popUpVC.videoID = videos[indexPath.row].id.videoId ?? ""
        popUpVC.videoTitle = videos[indexPath.row].snippet.title ?? ""
        
        
        self.addChild(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultCell.identifire, for: indexPath) as! ResultCell
        cell.videoImage.image = UIImage(data: try! Data(contentsOf: URL(string: videos[index].snippet.thumbnails.high.url!)!))
        cell.nameVideo.text = videos[index].snippet.title
        cell.descriptionVideo.text = videos[index].snippet.description
        return cell
    }

}
