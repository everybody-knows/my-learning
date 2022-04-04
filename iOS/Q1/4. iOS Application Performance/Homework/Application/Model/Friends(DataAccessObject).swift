//
//  Friends(DataAccessObject).swift
//  Homework
//
//  Created by Александр on 07.01.2022.
//

import Foundation
import RealmSwift

class FriendsDAO : Object,Decodable {

//    @objc dynamic var canAccessClosed : Bool = Bool()
    @objc dynamic var firstName : String = String()
    @objc dynamic var id : Int = Int()
//    @objc dynamic var isClosed : Bool = Bool()
    @objc dynamic var lastName : String = String()
    @objc dynamic var photo50 : String = String()
    @objc dynamic var trackCode : String = String()
    var lists = List<Int>()


    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case firstName = "first_name"
        case id = "id"
        case isClosed = "is_closed"
        case lastName = "last_name"
        case lists = "lists"
        case photo50 = "photo_50"
        case trackCode = "track_code"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
//        canAccessClosed = try values.decode(Bool.self, forKey: .canAccessClosed)
        firstName = try values.decode(String.self, forKey: .firstName)
        id = try values.decode(Int.self, forKey: .id)
//        isClosed = try values.decode(Bool.self, forKey: .isClosed)
        lastName = try values.decode(String.self, forKey: .lastName)
        photo50 = try values.decode(String.self, forKey: .photo50)
        trackCode = try values.decode(String.self, forKey: .trackCode)
        lists = try values.decodeIfPresent(List<Int>.self, forKey: .lists) ?? List<Int>()
    }
    
    override static func primaryKey() -> String? {
      return "id"
    }
    
    override static func indexedProperties() -> [String] {
            return ["firstName", "lastName"]
    }

}
