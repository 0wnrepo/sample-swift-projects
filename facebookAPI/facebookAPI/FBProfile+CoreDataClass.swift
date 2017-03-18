//
//  FBProfile+CoreDataClass.swift
//  facebookAPI
//
//  Created by Good on 15/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import CoreData


public class FBProfile: NSManagedObject {

    func toObject() -> OMFBProfile {
        
        var education : [OMFBEducation]?
        education = [OMFBEducation]()
        for case let x as FBEducation in profileEducation! {
            education?.append(x.toObject())
        }
        
        var work : [OMFBWork]?
        work = [OMFBWork]()
        for case let x as FBWork in profileWork! {
            work?.append(x.toObject())
        }
        
        //TODO: might be a bug with multiple projects mapping, see database and coredata properties category
        let user = OMFBProfile(id: id,
                               name: name,
                               email: email,
                               birthday: birthday,
                               gender: gender,
                               picture: picture_url,
                               education: education,
                               work: work)
        return user
    }
    
}
