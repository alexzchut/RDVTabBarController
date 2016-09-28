//
//  BKUser.h
//  Buffer
//
//  Created by Andrew Yates on 01/08/2014.
//
//

#import "Mantle.h"

@interface BKUser : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *userID;

@property (nonatomic, copy, readonly) NSString *billingGateway;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSDictionary *experiments;
@property (nonatomic, copy, readonly) NSArray *features;
@property (nonatomic, readonly) BOOL hasBufferedUpdate;
@property (nonatomic, readonly) BOOL hasCardDetails;
@property (nonatomic, readonly) BOOL hasHadTrial;
@property (nonatomic, readonly) BOOL isNewUser;
@property (nonatomic, readonly) BOOL isOnTrial;
@property (nonatomic, readonly) BOOL isAdmin;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *plan;
@property (nonatomic, readonly) NSInteger profileLimit;
@property (nonatomic, readonly) NSInteger profileUsage;
@property (nonatomic, copy, readonly) NSArray *profileGroups;
@property (nonatomic, copy, readonly) NSString *secretEmail;
@property (nonatomic, copy, readonly) NSArray *tags;
@property (nonatomic, copy, readonly) NSString *timezone;
@property (nonatomic, readonly) BOOL twentyfourHourTimeEnabled;
@property (nonatomic, copy, readonly) NSDictionary *s3VideoSignature;


@end
