//
//  CCTypeButton.m
//  ComicCollector
//
//  Created by Jacob Wernette on 2/12/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import "CCTypeButton.h"

@implementation CCTypeButton

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.bounds.size.height / 2;;
    self.clipsToBounds = YES;
}

@end
