//
//  CCTypeButton.m
//  ComicCollector
//
//  Created by Jacob Wernette on 2/12/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import "CCTypeButton.h"

@implementation CCTypeButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.bounds.size.height / 2;;
    self.clipsToBounds = YES;
}
@end
