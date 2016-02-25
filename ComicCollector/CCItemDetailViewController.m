//
//  CCItemDetailViewController.m
//  ComicCollector
//
//  Created by Jacob Wernette on 2/23/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import "CCItemDetailViewController.h"

@interface CCItemDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *comicLabel;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation CCItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.comicLabel.text = self.comic.title;
    
    [self.navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navBar.shadowImage = [UIImage new];
    self.navBar.translucent = YES;
    self.navBar.backgroundColor = [UIColor clearColor];
}

- (IBAction)dismissModal:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
