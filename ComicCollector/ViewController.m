//
//  ViewController.m
//  ComicCollector
//
//  Created by Jacob Wernette on 2/8/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import "ViewController.h"
#import "CCNewCollectionViewController.h"
#import "CCCoreDataStack.h"
#import <CoreData/CoreData.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setup];
    
    CCCoreDataStack *stack = [CCCoreDataStack defaultStack];
    
    NSManagedObjectContext *context = stack.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"CCCollectionEntity"];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (error != nil) {
        
        //Deal with failure
    }
    else {
        
        for (id someObject in results) {
            // Do stuff
            NSManagedObject *person = (NSManagedObject *)someObject;
            NSLog(@"%@%@", [person valueForKey:@"name"], [person valueForKey:@"dateCreated"]);
        }

    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup {
    self.title =  @"Comic Collector";
    
//    UIBarButtonItem *addCollection = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCollection)];
//    self.navigationItem.rightBarButtonItem = addCollection;
}

-(void)addCollection {
//    NSLog(@"Add collection");
//    CCNewCollectionViewController *vc = [[CCNewCollectionViewController alloc] init];
//    
//    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
//    
//    [self presentViewController:nc animated:YES completion:nil];
}

@end
