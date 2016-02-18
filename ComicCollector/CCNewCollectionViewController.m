//
//  CCNewCollectionViewController.m
//  ComicCollector
//
//  Created by Jacob Wernette on 2/9/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import "CCNewCollectionViewController.h"
#import "CCAddItemsTableViewController.h"
#import "CCItemTypeViewController.h"
#import "CCCoreDataStack.h"
#import "Collection.h"

@interface CCNewCollectionViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *insertCollectionButton;

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
    
    CCCoreDataStack *stack = [CCCoreDataStack defaultStack];

    self.entry = [NSEntityDescription insertNewObjectForEntityForName:@"Collection" inManagedObjectContext:stack.managedObjectContext];
    
    self.entry.name = self.nameField.text;
    self.entry.collectionDescription = self.descriptionField.text;
    
    [self.entry setDateCreated:[NSDate date]];
    
    [stack saveContext];
    
    //CCAddItemsTableViewController *vc = [[CCAddItemsTableViewController alloc] init];
    
    //[self.navigationController pushViewController:vc animated:YES];
    
    [self performSegueWithIdentifier:@"selectItemType" sender:sender];
    
    //[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)editingChanged:(UITextField *)sender {
    
    self.insertCollectionButton.enabled = sender.text.length > 0;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    CCItemTypeViewController *vc = [segue destinationViewController];
    NSLog(@"%@", self.entry);
    vc.entry = self.entry;
    
}


@end
