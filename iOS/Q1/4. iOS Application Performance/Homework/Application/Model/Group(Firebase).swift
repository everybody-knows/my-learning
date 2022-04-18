//
//  Groups(Firebase).swift
//  Homework
//
//  Created by Александр on 17.01.2022.
//

import Foundation
import Firebase

class GroupFB {

    let id: Int
    let name: String
    let photo50: String
    let ref: DatabaseReference?
    
    //для создания объекта
    init(id: Int, name: String, photo50: String) {
        
        self.id = id
        self.name = name
        self.photo50 = photo50
        self.ref = nil
    }
    //для получения объекта из Firebase Database
    init?(snapshot: DataSnapshot) {

        guard let value = snapshot.value as? [String: Any],
              let id = value["id"] as? Int,
              let name = value["name"] as? String,
              let photo50 = value["photo50"] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.photo50 = photo50
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        
        return [
            "id": id,
            "name": name,
            "photo50": photo50
        ]
    }
}
