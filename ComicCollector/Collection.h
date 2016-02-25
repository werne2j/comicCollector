//
//  Collection.h
//  
//
//  Created by Jacob Wernette on 2/17/16.
//
//

#import <Realm/Realm.h>
#import "Comic.h"
//#import <CoreData/CoreData.h>
//
//@class Comic;
//
//NS_ASSUME_NONNULL_BEGIN
//
//@interface Collection : NSManagedObject
//
//// Insert code here to declare functionality of your managed object subclass
//
//@end
//
//NS_ASSUME_NONNULL_END
//
//#import "Collection+CoreDataProperties.h"

@interface Collection : RLMObject

@property NSString *id;
@property NSString *name;
@property NSString *collectionDescription;
@property NSDate *dateCreated;
@property RLMArray<Comic *><Comic> *comics;

@end