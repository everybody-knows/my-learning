//
//  Groups(DataAccessObject).swift
//  Homework
//
//  Created by Александр on 07.01.2022.
//

import Foundation
import RealmSwift

// MARK: - GroupsDAO
class GroupsDAO: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String
    @objc dynamic var photo50: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case photo50 = "photo_50"
    }
    
    override static func primaryKey() -> String? {
      return "id"
    }
    
    override static func indexedProperties() -> [String] {
            return ["name"]
    }
}
