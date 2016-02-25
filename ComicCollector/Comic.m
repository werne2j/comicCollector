//
//  Comic.m
//  ComicCollector
//
//  Created by Jacob Wernette on 2/9/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import "Comic.h"

@implementation Comic

+ (NSString *)primaryKey
{
    return @"id";
}

+ (NSDictionary *)defaultPropertyValues
{
    return @{ @"id" : @0,
              @"digitalId" : @0,
              @"title" : @"",
              @"comicDescription" : @""
            };
}

@end

