//
//  ResultCell.swift
//  Namaste
//
//  Created by Vladyslav Prosianyk on 23.06.2021.
//

import UIKit

class ResultCell: UITableViewCell {
    
    static let identifire = "ResultCell"

    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var nameVideo: UILabel!
    @IBOutlet weak var descriptionVideo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
