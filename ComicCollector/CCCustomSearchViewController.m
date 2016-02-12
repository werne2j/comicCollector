//
//  CCCustomSearchViewController.m
//  ComicCollector
//
//  Created by Jacob Wernette on 2/11/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import "CCCustomSearchViewController.h"
#import "CCCustomSearchBar.h"

@interface CCCustomSearchViewController () <UISearchBarDelegate> {
    UISearchBar *_searchBar;
}

@end

@implementation CCCustomSearchViewController

-(UISearchBar *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[CCCustomSearchBar alloc] init];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchBar.text length] > 0) {
        self.active = true;
    } else {
        self.active = false;
    }
}

@end
