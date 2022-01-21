//
//  FriendsDB.swift
//  Homework
//
//  Created by Александр on 09.01.2022.
//

import Foundation
import RealmSwift

final class FriendsDB {
    
    init() {
        Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true  //DANGER METHOD !!!
        //Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 3)
        print(try! Realm().configuration.fileURL!)
    }
    
    func save(_ items: [FriendsDAO]) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(items)
        }
        
    }
    
    func fetch() -> Results<FriendsDAO> {
        let realm = try! Realm()
        
        let friends: Results<FriendsDAO> = realm.objects(FriendsDAO.self)
        return friends
    }
    
    func deleteAll() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func delete(_ item: Results<FriendsDAO>) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(item)
        }
        
    }
}

