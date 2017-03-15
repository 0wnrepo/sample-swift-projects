//
//  FBLocation+CoreDataProperties.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import CoreData


extension FBLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FBLocation> {
        return NSFetchRequest<FBLocation>(entityName: "FBLocation");
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var locationWork: FBWork?

}
