//
//  Defaults.swift
//  Namaste
//
//  Created by Vladyslav Prosianyk on 22.06.2021.
//

import Foundation

class Defauts {
    
    required init() {}
    
    static let shared: Defauts = Defauts()
    
    let defaults = UserDefaults.standard
    
    func encodeData(array: Array<Any>, key: String) {
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: true)
            defaults.set(data, forKey: key)
            defaults.synchronize()
        }catch (let error){
            #if DEBUG
                print("Failed to convert UIColor to Data : \(error.localizedDescription)")
            #endif
        }
    }
        
    func encodeData(object: Any, key: String) {
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: true)
            defaults.set(data, forKey: key)
            defaults.synchronize()
        }catch (let error){
            #if DEBUG
                print("Failed to convert UIColor to Data : \(error.localizedDescription)")
            #endif
        }
    }
    
    func decodeData<T>(key: String, type: T) -> Any {
        guard let decoded  = defaults.data(forKey: key) else {
            print("Cannot find object by key: \(key)")
            return Any.self
        }
            let decodedData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! T
            return decodedData

    }

    
    func getAllData<T>(forKey: String, type: T) -> [Any] {
        if let arr = defaults.object(forKey: forKey) as? T {
            return [arr]
        } else {
            print("Cannot find object by key: \(forKey)")
        }
        return [Any.self]
    }
    
}
