//
//  Collection.m
//  
//
//  Created by Jacob Wernette on 2/17/16.
//
//

#import "Collection.h"

@implementation Collection

+ (NSString *)primaryKey
{
    return @"id";
}

+ (NSDictionary *)defaultPropertyValues
{
    return @{ @"id" : [[NSUUID UUID] UUIDString],
              @"name" : @"",
              @"collectionDescription" : @"",
              @"dateCreated" : [NSDate date]
            };
}

@end
