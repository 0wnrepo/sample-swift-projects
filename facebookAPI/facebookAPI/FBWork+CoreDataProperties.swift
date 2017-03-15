//
//  FBWork+CoreDataProperties.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import CoreData


extension FBWork {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FBWork> {
        return NSFetchRequest<FBWork>(entityName: "FBWork");
    }

    @NSManaged public var start_date: String?
    @NSManaged public var id: String?
    @NSManaged public var end_date: String?
    @NSManaged public var description_str: String?
    @NSManaged public var workEmployer: FBEmployer?
    @NSManaged public var workLocation: FBLocation?
    @NSManaged public var workPosition: FBPosition?
    @NSManaged public var workProjects: NSSet?
    @NSManaged public var workFBProfileInverse: FBProfile?

}

// MARK: Generated accessors for workProjects
extension FBWork {

    @objc(addWorkProjectsObject:)
    @NSManaged public func addToWorkProjects(_ value: FBProjects)

    @objc(removeWorkProjectsObject:)
    @NSManaged public func removeFromWorkProjects(_ value: FBProjects)

    @objc(addWorkProjects:)
    @NSManaged public func addToWorkProjects(_ values: NSSet)

    @objc(removeWorkProjects:)
    @NSManaged public func removeFromWorkProjects(_ values: NSSet)

}
