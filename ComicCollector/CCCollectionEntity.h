//
//  CCCollectionEntity.h
//  ComicCollector
//
//  Created by Jacob Wernette on 2/9/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface CCCollectionEntity : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic) NSDate *dateCreated;

@end
