//
//  CCCustomSearchBar.m
//  ComicCollector
//
//  Created by Jacob Wernette on 2/11/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import "CCCustomSearchBar.h"

@implementation CCCustomSearchBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setShowsCancelButton:NO animated:NO];
}

@end
