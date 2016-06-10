//
//  AddItemsTableViewController.h
//  ComicCollector
//
//  Created by Jacob Wernette on 2/11/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Collection.h"

@protocol AddItemDelegate;

@interface CCAddItemsTableViewController : UITableViewController

@property (nonatomic, strong) Collection *collection;
@property (nonatomic, assign) id<AddItemDelegate> myDelegate;

@end

@protocol AddItemDelegate <NSObject>

- (void) additemsDismissed:(Collection *)collection;

@end
