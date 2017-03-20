//
//  UserDBManager.swift
//  facebookAPI
//
//  Created by Good on 18/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SugarRecord

protocol UserDbManagerProtocol {
    
    func saveUser(user: OMFBProfile)
    func fetchUser(with userId: String) -> FBProfile?
}

class UserDbManager: MTDbManager, UserDbManagerProtocol {
    override init(mainContext: Context, saveContext: Context) {
        super.init(mainContext: mainContext, saveContext: saveContext)
    }
    
    //MARK: - UserDbManagerProtocol
    func saveUser(user: OMFBProfile) {
        let userManagedObject: FBProfile = try! self.saveContext.create()
        userManagedObject.id    = user.id_P
        userManagedObject.email = user.email
        userManagedObject.name  = user.name
        userManagedObject.picture_url = user.picture
        //TODO: finish this mapping
//        userManagedObject.profileEducation =
//        userManagedObject.profileWork =
//        userManagedObject.profileProjects =
        
        self.save()
    }
    
    func fetchUser(with userId: String) -> FBProfile? {
        let request = self.mainContext.request(FBProfile.self).filtered(with: "id", equalTo: userId)
        let user = try? self.mainContext.fetch(request).first
        return user ?? nil
    }
}
