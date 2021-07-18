//
//  CategoriesController.swift
//  Namaste
//
//  Created by Vladyslav Prosianyk on 03.06.2021.
//

import UIKit
import CoreData

public var categoryValue = "yoga"

class CategoriesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static let shared: CategoriesController = CategoriesController()
    
    static let identifire = "CategoriesController"
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    var alert: UIAlertController?

    let key = "Category"
    
    var categories: [Category] = [
        Category(name: "Yoga for night"),
        Category(name: "Morning yoga"),
        Category(name: "Hatha yoga"),
        Category(name: "Vinyassa yoga"),
        Category(name: "Hot yoga"),
        Category(name: "Iyengar yoga"),
        Category(name: "Kundalini yoga"),
        Category(name: "Ashtanga yoga"),
        Category(name: "Bikram yoga"),
        Category(name: "Yin yoga"),
        Category(name: "Restorative yoga"),
        Category(name: "Prenatal yoga"),
        Category(name: "Anusara yoga"),
        Category(name: "Jivamukti yoga"),
        Category(name: "Yoga for beginers"),
        Category(name: "Yoga for continuing"),
        Category(name: "Yoga for profi")
    ]
    
    func addCategory(name: String) {
        categories.append(Category(name: name))
        saveAllCategories()
        collectionView.reloadData()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.bounds.width / 2) - 15, height: view.bounds.height / 7)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = topView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        topView.addSubview(blurEffectView)
        
        collectionView.collectionViewLayout = layout
        collectionView!.contentInset = UIEdgeInsets(top: 60, left: 10, bottom: 50, right: 10)

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        
        collectionView.register(UINib(nibName: CategoryCell.identifire, bundle: nil), forCellWithReuseIdentifier: CategoryCell.identifire)
        
        alert = UIAlertController(title: "Adding category", message: "", preferredStyle: .alert)
        alert!.addTextField { tf in
            tf.placeholder = "Write here your new category"
            tf.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
        }
        
        let action = UIAlertAction(title: "Add", style: .default, handler: { action in
            let textField = self.alert?.textFields![0]
            self.addCategory(name: (textField?.text!)!)
            textField?.text = ""
        })
        action.isEnabled = false
        alert?.addAction(action)
        alert?.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_image")!)

    }
    
    func getAllCategories() -> [Category] {
        if let savedCategories = defaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedCategories = try? decoder.decode([Category].self, from: savedCategories) {
                categories = loadedCategories
                return loadedCategories
            }
        }
        return [Category]()
    }
    
    
    
    func saveAllCategories() {
        do{
                let encoder = JSONEncoder()
                let encoded = try encoder.encode(categories)
                defaults.set(encoded, forKey: key)
                defaults.synchronize()
        }catch (let error){
            print("Failed to convert Data : \(error.localizedDescription)")
        }
    }

    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        alert!.actions[0].isEnabled = sender.text!.count > 0
    }
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        self.present(alert!, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let vc = storyboard!.instantiateViewController(identifier: ResultController.identifire) as! ResultController
        vc.lblName = categories[indexPath.item].name
        vc.valueForRequest = categories[indexPath.item].name.replacingOccurrences(of: " ", with: "+")
        self.navigationController?.pushViewController(vc, animated: true)
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getAllCategories().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifire, for: indexPath) as! CategoryCell
        cell.lNameOfCategory.text = getAllCategories()[indexPath.row].name
        cell.lNameOfCategory.numberOfLines = 0
        cell.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        cell.layer.cornerRadius = 5
        cell.backgroundColor = .random
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 2
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        cell.closureEdit = {
            let ac = UIAlertController(title: "Rename category", message: nil, preferredStyle: .alert)
            ac.addTextField { tf in
                tf.text = self.categories[indexPath.item].name
            }
            
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "OK", style: .default) { [self, ac] _ in
                let newName = ac.textFields![0].text
                categories[indexPath.item].name = newName ?? ""
                
                self.collectionView.reloadData()
                self.saveAllCategories()
                
            })
            
            self.present(ac, animated: true, completion: nil)
        }
        
        cell.closureDel = {
            
            let alert = UIAlertController(title: "Are you sure?", message: "You want delete this category?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "I'm sure!", style: .default, handler: { _ in
                self.collectionView.deleteItems(at: [indexPath])
                self.collectionView.reloadData()
                self.categories.remove(at: indexPath.item)
                self.saveAllCategories()
            }))
            alert.addAction(UIAlertAction(title: "Close", style: .destructive, handler: nil))
            self.present(alert, animated: true)
            
            
        }
        
        return cell
    }
    
    
    
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
