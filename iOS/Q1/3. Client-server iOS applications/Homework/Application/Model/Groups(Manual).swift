//
//  Groups.swift
//  Homework
//
//  Created by Александр on 25.03.2021.
//

import Foundation

struct Groups {
    var id: Int = 0
    var name: String = ""
    var photo50: String = ""
    
    init(item: [String: Any]) {
        self.id = item["id"] as! Int
        self.name = item["name"] as! String
        self.photo50 = item["photo_50"] as! String
    }
}
