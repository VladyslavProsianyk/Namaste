//
//  File.swift
//  Namaste
//
//  Created by Vladyslav Prosianyk on 25.05.2021.
//

import UIKit

public struct YogaAsana: Decodable {
    let id: Int
    let sanskritName, englishName: String
    let imgURL: String
    let userID: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case sanskritName = "sanskrit_name"
        case englishName = "english_name"
        case imgURL = "img_url"
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

var yogaAsanas: [YogaAsana] = (try! JSONDecoder().decode([YogaAsana].self, from: jsonData ?? Data())).sorted(by: {$0.id < $1.id})

public func nullifyFlags() {
    for asana in yogaAsanas {
        UserDefaults.standard.set(false, forKey: "\(asana.id)")
    }
}
public let randomIndex = Int.random(in: 0..<yogaAsanas.count)
