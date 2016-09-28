//
//  BKClient+Notifications.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 08/04/2016.
//  Copyright © 2016 Andrew Yates. All rights reserved.
//

#import "BKClient+Notifications.h"

@implementation BKClient (Notifications)

- (void)getNotificationsForProfile:(NSString *)profileID page:(NSString *)page success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure {
    [self getNotificationsForProfile:profileID page:page count:@"20" success:success failure:failure];
}

- (void)getNotificationsForProfile:(NSString *)profileID page:(NSString *)page count:(NSString *)count success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure {
    
    [self GET:[NSString stringWithFormat:@"profiles/%@/notifications.json?access_token=%@&page=%@&count=%@&resolve=true", profileID, self.accessToken, page, count] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
        NSError *error = nil;
        NSArray *updates = [MTLJSONAdapter modelsOfClass:BKUpdate.class fromJSONArray:[responseObject valueForKey:@"notifications"] error:&error];
        if(error){
            failure(error);
            return;
        }
        success(updates);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
