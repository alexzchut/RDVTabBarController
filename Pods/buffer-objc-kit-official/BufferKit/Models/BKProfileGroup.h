//
//  BKProfileGroup.h
//  Buffer
//
//  Created by Andrew Yates on 21/07/2014.
//
//

#import "Mantle.h"

@interface BKProfileGroup : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *groupID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSURL *groupAvatar;
@property (nonatomic, copy, readonly) NSArray *profileIDs;

@end
