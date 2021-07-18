//
//  CategoryCell.swift
//  Namaste
//
//  Created by Vladyslav Prosianyk on 03.06.2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let identifire = "CategoryCell"
    
    var closureEdit: (() -> ())?
    var closureDel: (() -> ())?
    
    @IBOutlet weak var lNameOfCategory: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var delBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        editBtn.addTarget(self, action: #selector(editCell(_:)), for: .touchUpInside)
        delBtn.addTarget(self, action: #selector(deleteCell(_:)), for: .touchUpInside)
    }
    
    @objc func editCell(_ sender: UIButton) {
        closureEdit?()
    }

    @objc func deleteCell(_ sender: UIButton) {
        closureDel?()
    }
}
