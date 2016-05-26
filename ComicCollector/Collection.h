//
//  Collection.h
//  
//
//  Created by Jacob Wernette on 2/17/16.
//
//

#import <Realm/Realm.h>
#import "Comic.h"

@interface Collection : RLMObject

@property NSString *id;
@property NSString *name;
@property NSString *collectionDescription;
@property NSDate *dateCreated;
@property RLMArray<Comic *><Comic> *comics;

@end