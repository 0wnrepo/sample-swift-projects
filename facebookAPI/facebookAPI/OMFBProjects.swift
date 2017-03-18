//
//  OMFBProjects.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import ObjectMapper

class OMFBProjects: Mappable, Equatable {
    var id_E            : String?
    var name            : String?
    var startDate       : String?
    var endDate         : String?
    var withProfiles    : [OMFBProfile]?
    
    required init?(map: Map) {
        
    }
    
    // MARK: - Initializer
    init (id: String?,
          name: String?,
          startDate: String?,
          endDate: String?,
          profiles: [OMFBProfile]?) {
        self.id_E = id
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.withProfiles = profiles
    }
    
    // Mappable
    func mapping(map: Map) {
        id_E         <- map["id"]
        name         <- map["name"]
        startDate    <- map["start_date"]
        endDate      <- map["end_date"]
        withProfiles <- map["with"]
    }
    
    public static func ==(lhs: OMFBProjects, rhs: OMFBProjects) -> Bool {
        return lhs.id_E == rhs.id_E
    }
}
