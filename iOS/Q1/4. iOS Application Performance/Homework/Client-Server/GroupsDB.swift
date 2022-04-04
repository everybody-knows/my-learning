//
//  GroupsDB.swift
//  Homework
//
//  Created by Александр on 09.01.2022.
//

import Foundation
import RealmSwift

final class GroupsDB {
    
    init() {
        Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true  //DANGER METHOD !!!
        //Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 3)
        print(try! Realm().configuration.fileURL!)
    }
    
    func save(_ items: [GroupsDAO]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(items)
        }
        
    }
    
    func fetch() -> Results<GroupsDAO> {
        let realm = try! Realm()
        
        let friends: Results<GroupsDAO> = realm.objects(GroupsDAO.self)
        return friends
    }
    
    func deleteAll() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func delete(_ item: Results<GroupsDAO>) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(item)
        }
        
    }
}

