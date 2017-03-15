//
//  FBSchool+CoreDataProperties.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import CoreData


extension FBSchool {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FBSchool> {
        return NSFetchRequest<FBSchool>(entityName: "FBSchool");
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var schoolEducation: FBEducation?

}
