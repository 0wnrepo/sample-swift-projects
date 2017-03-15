//
//  OMFBEducation.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import ObjectMapper

class OMFBEducation: Mappable {
    var id_E    : String?
    var type    : String?
    
    var school  : OMFBSchool?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id_E        <- map["id"]
        type        <- map["type"]
        
        school      <- map["school"]
        
    }
}
