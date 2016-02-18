//
//  Comic.h
//  ComicCollector
//
//  Created by Jacob Wernette on 2/9/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Comic : NSManagedObject

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSNumber *digitalId;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *comicDescription;
@property (nullable, nonatomic, retain) NSData *thumbnail;

@end
