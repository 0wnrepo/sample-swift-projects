//
//  FBWork+CoreDataClass.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import CoreData

@objc(FBWork)
public class FBWork: NSManagedObject {

    func toObject() -> OMFBWork {
        var projects : [OMFBProjects]?
        projects = [OMFBProjects]()
        for case let x as FBProjects in workProjects! {
            projects?.append(x.toObject())
        }
        
        let work = OMFBWork(id: id, startDate: start_date, endDate: end_date, descriptionStr: description_str, position: workPosition?.toObject(), location: workLocation?.toObject(), employer: workEmployer?.toObject(), projects: projects)
        return work
    }
}
