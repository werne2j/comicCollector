//
//  Comic.h
//  ComicCollector
//
//  Created by Jacob Wernette on 2/9/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import <Realm/Realm.h>

@interface Comic : RLMObject

@property NSNumber<RLMInt> *id;
@property NSNumber<RLMInt> *digitalId;
@property NSString *title;
@property NSString *comicDescription;
@property NSData *thumbnail;

@end
RLM_ARRAY_TYPE(Comic)