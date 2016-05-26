//
//  CCCustomSearchBar.m
//  ComicCollector
//
//  Created by Jacob Wernette on 2/11/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import "CCCustomSearchBar.h"

@implementation CCCustomSearchBar

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setShowsCancelButton:NO animated:NO];
}

@end
