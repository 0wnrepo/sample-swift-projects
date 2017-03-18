//
//  FBEmployer+CoreDataClass.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import CoreData

@objc(FBEmployer)
public class FBEmployer: NSManagedObject {

    func toObject() -> OMFBEmployer {
        let employer = OMFBEmployer(id: id, name: name)
        return employer
    }
}
