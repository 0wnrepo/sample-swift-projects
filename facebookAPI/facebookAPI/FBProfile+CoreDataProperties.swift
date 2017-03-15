//
//  FBProfile+CoreDataProperties.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension FBProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FBProfile> {
        return NSFetchRequest<FBProfile>(entityName: "FBProfile");
    }

    @NSManaged public var birthday: String?
    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var picture_data: NSData?
    @NSManaged public var picture_url: String?

}
