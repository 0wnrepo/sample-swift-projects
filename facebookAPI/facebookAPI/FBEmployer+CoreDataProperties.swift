//
//  FBEmployer+CoreDataProperties.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import CoreData


extension FBEmployer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FBEmployer> {
        return NSFetchRequest<FBEmployer>(entityName: "FBEmployer");
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var employerWork: FBWork?

}
