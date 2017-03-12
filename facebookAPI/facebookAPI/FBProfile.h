//
//  FBProfile.h
//  facebookAPI
//
//  Created by Good on 11/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

#ifndef FBProfile_h
#define FBProfile_h

@interface FBProfile : JSONModel
@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *email;
@end


#endif /* FBProfile_h */
