//
//  FBLocation+CoreDataClass.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import CoreData

@objc(FBLocation)
public class FBLocation: NSManagedObject {

    func toObject() -> OMFBLocation {
        let location = OMFBLocation(id: id, name: name)
        return location
    }
}
