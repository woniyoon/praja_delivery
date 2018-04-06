//
//  RealmManager.swift
//  delivery
//
//  Created by Bacelar on 2018-04-05.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit
import RealmSwift

class RealmManager {
    
    private var database: Realm
    static let sharedInstance = RealmManager()
    
    internal required init() {
        database = try! Realm()
    }
    
    func getData(type: Object.Type) -> Results<Object>? {
        return database.objects(type)
    }
    
    func addData(object: Object)   {
        do {
            try! database.write {
                database.add(object, update: true)
                print("Added new object")
            }
        }
        catch let error as NSError {
            print("Something went wrong: \(error.localizedDescription)")
        }
    }
    
    func deleteAllFromDatabase()  {
        try!   database.write {
            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: Object)   {
        try!   database.write {
            database.delete(object)
        }
    }
    
    func getNewId(type: Object.Type) -> Int? {
        if let last = database.objects(type).last as? Int {
            return last + 1
        } else {
            return 1
        }
    }
}
