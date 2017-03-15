//
//  OMFBEmployer.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import ObjectMapper

class OMFBEmployer: Mappable {
    var id_E    : String?
    var name    : String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id_E        <- map["id"]
        name        <- map["name"]
    }
}
