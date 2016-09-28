//
//  BKClient+Notifications.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 08/04/2016.
//  Copyright © 2016 Andrew Yates. All rights reserved.
//

#import "BKClient.h"
#import "BKUpdate.h"

@interface BKClient (Notifications)

- (void)getNotificationsForProfile:(NSString *)profileID page:(NSString *)page success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure;

- (void)getNotificationsForProfile:(NSString *)profileID page:(NSString *)page count:(NSString *)count success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure;

@end
