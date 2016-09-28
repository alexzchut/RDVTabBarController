//
//  BFRJSONResponseSerializerWithData.m
//  Buffer
//
//  Created by Andrew Yates on 25/02/2014.
//
//

#import "BKJSONResponseSerializerWithData.h"

@implementation BKJSONResponseSerializerWithData

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (*error != nil) {
            NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
            [userInfo setValue:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] forKey:JSONResponseSerializerWithDataKey];
            NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
            (*error) = newError;
        }
        
        return (nil);
    }
    
    return ([super responseObjectForResponse:response data:data error:error]);
}


@end
