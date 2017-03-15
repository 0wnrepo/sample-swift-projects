//
//  FBEducation+CoreDataProperties.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import CoreData


extension FBEducation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FBEducation> {
        return NSFetchRequest<FBEducation>(entityName: "FBEducation");
    }

    @NSManaged public var type: String?
    @NSManaged public var id: String?
    @NSManaged public var educationSchool: FBSchool?
    @NSManaged public var educationFBProfileInverse: FBProfile?

}
