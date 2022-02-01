//
//  PhotosDB.swift
//  Homework
//
//  Created by Александр on 12.01.2022.
//
// test-repo
import Foundation
import RealmSwift

final class PhotosDB {
    
    init() {
        Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true  //DANGER METHOD !!!
        //Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 3)
        print(try! Realm().configuration.fileURL!)
    }
    
    func save(_ items: [PhotosDAO]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(items)
        }
        
    }
    
    func fetch() -> Results<PhotosDAO> {
        let realm = try! Realm()
        
        let friends: Results<PhotosDAO> = realm.objects(PhotosDAO.self)
        return friends
    }
    
    func deleteAll() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func delete(_ item: Results<PhotosDAO>) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(item)
        }
        
    }
}
