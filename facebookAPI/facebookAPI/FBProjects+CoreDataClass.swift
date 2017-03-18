//
//  FBProjects+CoreDataClass.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import CoreData

@objc(FBProjects)
public class FBProjects: NSManagedObject {

    func toObject() -> OMFBProjects {
        var profiles : [OMFBProfile]?
        profiles = [OMFBProfile]()
        for case let x as FBProfile in withFBProfiles! {
            profiles?.append(x.toObject())
        }
        
        let projects = OMFBProjects(id: id, name: name, startDate: start_date, endDate: end_date, profiles: profiles)
        return projects
    }
    
}
