//
//  BaseRealmDataStore.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 05/04/2021.
//

import Foundation
import RealmSwift

// swiftlint:disable force_try
protocol BaseRealmDataStore {
    associatedtype ObjectType: Object
    
    func getAll() -> Results<ObjectType>
    
    func findById(identifier: Int) -> ObjectType?
    
    func create(object: ObjectType)
    
    func create(objects: [ObjectType])
    
    func update(object: ObjectType)
    
    func update(objects: [ObjectType])
    
    func delete(object: ObjectType)
    
    func delete(objects: [ObjectType])
    
    func sync(objects: [ObjectType])
    
    func clear()
    
    func count() -> Int
    
    func getRealm() -> Realm
    
    func getNewId() -> Int
}

extension BaseRealmDataStore {
    
    func getAll() -> Results<ObjectType> {
        return getRealm().objects(ObjectType.self)
    }
    
    func findById(identifier: Int) -> ObjectType? {
        let objects = getAll()
        if objects.count > 0 {
            return objects.filter(NSPredicate(format: "identifier = %d", identifier)).first
        }
        
        return nil
    }
    
    func create(object: ObjectType) {
        var lastId = getNewId()
        
        if let identifier = object.value(forKey: "identifier") as? Int, identifier == 0 {
            object.setValue("\(lastId)", forKey: "identifier")
            lastId += 1
        }
        
        let realm = getRealm()
        
        try? realm.write {
            realm.add(object)
        }
    }
    
    func create(objects: [ObjectType]) {
        var lastId = getNewId()
        
        objects.forEach {
            if let identifier = $0.value(forKey: "identifier") as? Int, identifier == 0 {
                $0.setValue("\(lastId)", forKey: "identifier")
                lastId += 1
            }
        }
        
        let realm = getRealm()
        realm.beginWrite()
        
        for object in objects {
            realm.create(ObjectType.self, value: object, update: .error)
        }
        
        try? realm.commitWrite()
    }
    
    func update(object: ObjectType) {
        let realm = getRealm()
        
        try? realm.write {
            realm.add(object, update: .all)
        }
    }
    
    func update(objects: [ObjectType]) {
        let realm = getRealm()
        
        try? realm.write {
            realm.add(objects, update: .all)
        }
    }
    
    func delete(object: ObjectType) {
        let realm = getRealm()
        
        try? realm.write {
            realm.delete(object)
        }
    }
    
    func delete(objects: [ObjectType]) {
        let realm = getRealm()
        
        try? realm.write {
            realm.delete(objects)
        }
    }
    
    func sync(objects: [ObjectType]) {
        let realm = getRealm()
        
        var ids = [Int]()
        for object in objects {
            ids.append(object.value(forKey: "identifier") as? Int ?? 0)
        }
        
        let objectToDelete = getAll().filter(NSPredicate(format: "NOT identifier IN %@", ids))
        
        try? realm.write {
            if objectToDelete.count > 0 {
                realm.delete(objectToDelete)
            }
        }
        
        var lastId = getNewId()
        
        objects.forEach {
            if let identifier = $0.value(forKey: "identifier") as? Int, identifier == 0 {
                $0.setValue("\(lastId)", forKey: "identifier")
                lastId += 1
            }
        }
        
        try? realm.write {
            realm.add(objects, update: .all)
        }
    }
    
    func count() -> Int {
        return getAll().count
    }
    
    func clear() {
        let realm = getRealm()
        
        try? realm.write {
            realm.delete(getAll())
        }
    }
    
    func getRealm() -> Realm {
        return try! Realm()
    }
    
    func getNewId() -> Int {
        let type = ObjectType.self.description()
        let realm = getRealm()
        
        if let realmId = realm.objects(RealmIds.self).filter(NSPredicate(format: "type = %@", type)).first {
            let newId = realmId.typeId + 1
            
            try? realm.write {
                let realmIds = RealmIds()
                realmIds.type = type
                realmIds.typeId = newId
                realm.add(realmIds, update: .all)
            }
            
            return newId
        } else {
            let newId = 1
            
            try? realm.write {
                let realmIds = RealmIds()
                realmIds.type = type
                realmIds.typeId = newId
                realm.add(realmIds, update: .all)
            }
            
            return newId
        }
    }
}

extension Results {
    func toArray() -> [Object] {
        return Array(self) as? [Object] ?? []
    }
}

class RealmIds: Object {
    @objc dynamic var type: String = ""
    @objc dynamic var typeId: Int = 0
    
    override class func primaryKey() -> String? { return "type" }
}
