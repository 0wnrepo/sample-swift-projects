//
//  FBProfile+CoreDataProperties.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
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
    @NSManaged public var profileEducation: NSSet?
    @NSManaged public var profileWork: NSSet?
    @NSManaged public var profileProjects: NSSet?

}

// MARK: Generated accessors for profileEducation
extension FBProfile {

    @objc(addProfileEducationObject:)
    @NSManaged public func addToProfileEducation(_ value: FBEducation)

    @objc(removeProfileEducationObject:)
    @NSManaged public func removeFromProfileEducation(_ value: FBEducation)

    @objc(addProfileEducation:)
    @NSManaged public func addToProfileEducation(_ values: NSSet)

    @objc(removeProfileEducation:)
    @NSManaged public func removeFromProfileEducation(_ values: NSSet)

}

// MARK: Generated accessors for profileWork
extension FBProfile {

    @objc(addProfileWorkObject:)
    @NSManaged public func addToProfileWork(_ value: FBWork)

    @objc(removeProfileWorkObject:)
    @NSManaged public func removeFromProfileWork(_ value: FBWork)

    @objc(addProfileWork:)
    @NSManaged public func addToProfileWork(_ values: NSSet)

    @objc(removeProfileWork:)
    @NSManaged public func removeFromProfileWork(_ values: NSSet)

}

// MARK: Generated accessors for profileProjects
extension FBProfile {

    @objc(addProfileProjectsObject:)
    @NSManaged public func addToProfileProjects(_ value: FBProjects)

    @objc(removeProfileProjectsObject:)
    @NSManaged public func removeFromProfileProjects(_ value: FBProjects)

    @objc(addProfileProjects:)
    @NSManaged public func addToProfileProjects(_ values: NSSet)

    @objc(removeProfileProjects:)
    @NSManaged public func removeFromProfileProjects(_ values: NSSet)

}
