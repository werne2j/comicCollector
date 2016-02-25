//
//  CCItemTypeViewController.m
//  ComicCollector
//
//  Created by Jacob Wernette on 2/12/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import "CCItemTypeViewController.h"
#import "CCAddItemsTableViewController.h"

@interface CCItemTypeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *comicTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *seriesTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *eventTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *storyTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *characterTypeButton;

@end

@implementation CCItemTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CCAddItemsTableViewController *vc = [segue destinationViewController];
    vc.itemType = [sender currentTitle];
    vc.collection = self.collection;
}


- (IBAction)presentSearch:(id)sender {
    
    [self performSegueWithIdentifier:@"itemSearchSegue" sender:sender];
    
}

@end
