//
//  FBPosition+CoreDataProperties.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import CoreData


extension FBPosition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FBPosition> {
        return NSFetchRequest<FBPosition>(entityName: "FBPosition");
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var positionWork: FBWork?

}
