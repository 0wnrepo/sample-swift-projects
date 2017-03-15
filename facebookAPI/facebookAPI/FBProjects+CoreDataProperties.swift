//
//  FBProjects+CoreDataProperties.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import CoreData


extension FBProjects {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FBProjects> {
        return NSFetchRequest<FBProjects>(entityName: "FBProjects");
    }

    @NSManaged public var id: String?
    @NSManaged public var end_date: String?
    @NSManaged public var start_date: String?
    @NSManaged public var name: String?
    @NSManaged public var withFBProfiles: NSSet?
    @NSManaged public var projectWork: FBWork?

}

// MARK: Generated accessors for withFBProfiles
extension FBProjects {

    @objc(addWithFBProfilesObject:)
    @NSManaged public func addToWithFBProfiles(_ value: FBProfile)

    @objc(removeWithFBProfilesObject:)
    @NSManaged public func removeFromWithFBProfiles(_ value: FBProfile)

    @objc(addWithFBProfiles:)
    @NSManaged public func addToWithFBProfiles(_ values: NSSet)

    @objc(removeWithFBProfiles:)
    @NSManaged public func removeFromWithFBProfiles(_ values: NSSet)

}
