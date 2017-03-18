//
//  DbManager.swift
//  facebookAPI
//
//  Created by Good on 18/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import CoreData
import SugarRecord

class MTDbManager {
    var saveContext: Context
    var mainContext: Context
    
    init(mainContext: Context, saveContext: Context) {
        self.mainContext = mainContext
        self.saveContext = saveContext
    }
    
    func save(){
        do {
            try (self.saveContext as! NSManagedObjectContext).save()
        } catch {
            print("Error saving: \(error)")
            fatalError("Error in saving")
        }
    }
}

protocol DbManagerProtocol {
    var storage: CoreDataDefaultStorage { get }
}

class DbManager: DbManagerProtocol {
    //MARK: Local Variable
    var storage: CoreDataDefaultStorage
    
    //MARK: Shared Instance
    static let sharedInstance : DbManager = {
        let store = CoreDataStore.named("facebookAPI")
        let bundle = Bundle.main
        let model = CoreDataObjectModel.merged([bundle])
        let defaultStorage = try! CoreDataDefaultStorage(store: store, model: model)
        
        return DbManager(storage: defaultStorage)
    }()
    
    // MARK: - Initializer
    init(storage: CoreDataDefaultStorage) {
        self.storage = storage
        (self.storage.memoryContext as! NSManagedObjectContext).mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        (self.storage.saveContext as! NSManagedObjectContext).mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
