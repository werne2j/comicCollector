//
//  CCNewCollectionViewController.m
//  ComicCollector
//
//  Created by Jacob Wernette on 2/9/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import "CCNewCollectionViewController.h"
#import "CCCollectionEntity.h"
#import "CCCoreDataStack.h"

@interface CCNewCollectionViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end

@implementation CCNewCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
}

-(void)setup {
    self.title =  @"New Collection";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
   // UIViewController * contributeViewController = [[UIViewController alloc] init];
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *beView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    beView.frame = self.view.bounds;
    
    self.view.frame = self.view.bounds;
    self.view.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:beView atIndex:0];

}

- (IBAction)dismissNewCollection:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)insertCollection:(id)sender {
    
    CCCoreDataStack *stack = [CCCoreDataStack defaultStack];

    CCCollectionEntity *entry = [NSEntityDescription insertNewObjectForEntityForName:@"CCCollectionEntity" inManagedObjectContext:stack.managedObjectContext];
    
    entry.name = self.nameField.text;
    [entry setDateCreated:[NSDate date]];
    
    [stack saveContext];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
