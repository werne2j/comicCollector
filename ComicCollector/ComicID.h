//
//  ComicID.h
//  ComicCollector
//
//  Created by Jacob Wernette on 6/7/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import <Realm/Realm.h>

@interface ComicID : RLMObject

@property NSNumber<RLMInt> *id;

@end
RLM_ARRAY_TYPE(ComicID)