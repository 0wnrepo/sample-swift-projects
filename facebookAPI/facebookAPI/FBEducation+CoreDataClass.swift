//
//  FBEducation+CoreDataClass.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import CoreData

@objc(FBEducation)
public class FBEducation: NSManagedObject {
    func toObject() -> OMFBEducation {
        let education = OMFBEducation(id: id, type: type, school: educationSchool?.toObject())
        return education
    }
    
    
}
