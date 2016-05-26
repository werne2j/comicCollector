//
//  CCNewCollectionViewController.m
//  ComicCollector
//
//  Created by Jacob Wernette on 2/9/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//
#import <RBQFetchedResultsController/RBQFRC.h>

#import "CCNewCollectionViewController.h"
#import "CCAddItemsTableViewController.h"
#import "CCItemTypeViewController.h"

#import "Collection.h"

@interface CCNewCollectionViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *insertCollectionButton;
@property (nonatomic, strong) Collection *collection;

@end

@implementation CCNewCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
}

-(void)setup {

    self.title =  @"New Collection";
//    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.view.backgroundColor = [UIColor clearColor];
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//    
    self.insertCollectionButton.enabled = NO;
    
   // UIViewController * contributeViewController = [[UIViewController alloc] init];
//    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *beView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    beView.frame = self.view.bounds;
//    
//    self.view.frame = self.view.bounds;
//    self.view.backgroundColor = [UIColor clearColor];
//    [self.view insertSubview:beView atIndex:0];

}

- (IBAction)dismissNewCollection:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)insertCollection:(id)sender {

    self.collection = [[Collection alloc] init];
    self.collection.name = self.nameField.text;
    self.collection.collectionDescription = self.descriptionField.text;
    
    RLMRealm *realm = [RLMRealm defaultRealm];

    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [realm addObject:self.collection];
    }];

    [self performSegueWithIdentifier:@"selectItemType" sender:sender];

}

- (IBAction)editingChanged:(UITextField *)sender {
    self.insertCollectionButton.enabled = sender.text.length > 0;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CCItemTypeViewController *vc = [segue destinationViewController];
    vc.collection = self.collection;
}

@end
