//
//  OMFBProfile.swift
//  facebookAPI
//
//  Created by Good on 14/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import ObjectMapper

//https://developers.facebook.com/tools/explorer?method=GET&path=me%3Ffields%3Did%2Cname%2Cemail%2Cbirthday%2Cgender%2Cpicture%7Burl%7D%26redirect%3Dno&version=v2.4
//seems like the iOS fb framework is using the v2.4 api version for some reason
/*
 
 {
    "id":"710617345661745",
    "name":"Name Surename",
    "email":"name.surname@gmail.com",
    "birthday":"01/01/1970",
    "gender":"male",
    "picture":{
        "data":{
            "url":"https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/17103255_1416521411737998_6052762405151729930_n.jpg?oh=5b41c6219234b38615e7d3164e5b9b55&oe=595CCFF1"
        }
    }
 }
 */

class OMFBProfile: Mappable {
    var id_P    : String?
    var name    : String?
    var email   : String?
    var birthday: String?
    var gender  : String?
    var picture : String?
    
    var educationS : [OMFBEducation]?
    var work      : [OMFBWork]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id_P        <- map["id"]
        name        <- map["name"]
        email       <- map["email"]
        birthday    <- map["birthday"]
        gender      <- map["gender"]
        picture     <- map["picture.data.url"]
        
        educationS   <- map["education"]
        work         <- map["work"]
    }
}
