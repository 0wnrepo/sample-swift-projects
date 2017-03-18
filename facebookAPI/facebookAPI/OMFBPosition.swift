//
//  OMFBPosition.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import ObjectMapper

class OMFBPosition: Mappable, Equatable {
    var id_E    : String?
    var name    : String?
    
    required init?(map: Map) {
        
    }
    
    // MARK: - Initializer
    init (id: String?,
          name: String?) {
        self.id_E = id
        self.name = name
    }
    
    // Mappable
    func mapping(map: Map) {
        id_E        <- map["id"]
        name        <- map["name"]
    }
    
    public static func ==(lhs: OMFBPosition, rhs: OMFBPosition) -> Bool {
        return lhs.id_E == rhs.id_E
    }
}
