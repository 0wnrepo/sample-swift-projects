//
//  OMFBEducation.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import ObjectMapper

class OMFBEducation: Mappable, Equatable {
    var id_E    : String?
    var type    : String?
    
    var school  : OMFBSchool?
    
    required init?(map: Map) {
        
    }
    
    // MARK: - Initializer
    init(id: String?,
        type: String?,
        school: OMFBSchool?) {
        self.id_E = id
        self.type = type
        self.school = school
    }
    
    // Mappable
    func mapping(map: Map) {
        id_E        <- map["id"]
        type        <- map["type"]
        
        school      <- map["school"]
    }
    
    public static func ==(lhs: OMFBEducation, rhs: OMFBEducation) -> Bool {
        return lhs.id_E == rhs.id_E
    }
}
