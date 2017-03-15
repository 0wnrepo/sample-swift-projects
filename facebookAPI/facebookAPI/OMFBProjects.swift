//
//  OMFBProjects.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import ObjectMapper

class OMFBProjects: Mappable {
    var id_E            : String?
    var name            : String?
    var startDate       : String?
    var endDate         : String?
    var withProfiles    : [OMFBProfile]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id_E         <- map["id"]
        name         <- map["name"]
        startDate    <- map["start_date"]
        endDate      <- map["end_date"]
        withProfiles <- map["with"]
    }
}
