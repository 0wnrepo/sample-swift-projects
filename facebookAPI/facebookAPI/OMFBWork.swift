//
//  OMFBWork.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import ObjectMapper

class OMFBWork: Mappable {
    var id_E            : String?
    var startDate       : String?
    var endDate         : String?
    var descriptionStr  : String?
    
    var position        : OMFBPosition?
    var location        : OMFBLocation?
    var employer        : OMFBEmployer?
    var projects        : [OMFBProjects?]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id_E             <- map["id"]
        startDate        <- map["start_date"]
        endDate          <- map["end_date"]
        descriptionStr   <- map["description"]
        
        position         <- map["position"]
        location         <- map["location"]
        employer         <- map["employer"]
        projects         <- map["projects"]
    }
}
