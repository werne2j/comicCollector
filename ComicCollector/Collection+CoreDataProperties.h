//
//  Collection+CoreDataProperties.h
//  
//
//  Created by Jacob Wernette on 2/17/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Collection.h"

NS_ASSUME_NONNULL_BEGIN

@interface Collection (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *collectionDescription;
@property (nullable, nonatomic, retain) NSDate *dateCreated;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Comic *> *comics;

@end

@interface Collection (CoreDataGeneratedAccessors)

- (void)addComicsObject:(Comic *)value;
- (void)removeComicsObject:(Comic *)value;
- (void)addComics:(NSSet<Comic *> *)values;
- (void)removeComics:(NSSet<Comic *> *)values;

@end

NS_ASSUME_NONNULL_END
