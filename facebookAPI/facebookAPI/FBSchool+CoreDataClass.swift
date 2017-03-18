//
//  FBSchool+CoreDataClass.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import CoreData

@objc(FBSchool)
public class FBSchool: NSManagedObject {
    func toObject() -> OMFBSchool {
        let school = OMFBSchool(id: id, name: name)
        return school
    }
}
