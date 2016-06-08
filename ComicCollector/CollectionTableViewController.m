//
//  CollectionTableViewController.m
//  ComicCollector
//
//  Created by Jacob Wernette on 2/9/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//
#import <RBQFetchedResultsController/RBQFRC.h>

#import "CollectionTableViewController.h"
#import "CCNewCollectionViewController.h"
#import "CCCollectionDetailViewController.h"

#import "Comic.h"

@interface CollectionTableViewController () <RBQFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) RBQFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    [self.fetchedResultsController performFetch];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Collections" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
}

-(void)setup {
    self.title =  @"Comic Collector";

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fetchedResultsController numberOfRowsForSectionIndex:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    Collection *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];

    cell.textLabel.text = entry.name;
    cell.detailTextLabel.text = entry.collectionDescription;
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Collection *collection = [self.fetchedResultsController objectAtIndexPath:indexPath];
        if (!collection) {
            return;
        }
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        [realm beginWriteTransaction];
        [realm deleteObject:collection];
        [realm commitWriteTransaction];
        
    }   
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"collectionDetailSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        CCCollectionDetailViewController *vc = [segue destinationViewController];
        Collection *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
        vc.collection = entry;
    }
    
}


- (RBQFetchRequest *)entryListRequest {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    RBQFetchRequest *fetchRequest = [RBQFetchRequest fetchRequestWithEntityName:@"Collection"
                                                                        inRealm:realm
                                                                      predicate:nil];
    
    RLMSortDescriptor *sortDescriptor = [RLMSortDescriptor sortDescriptorWithProperty:@"name"
                                                                            ascending:NO];
    
    fetchRequest.sortDescriptors = @[sortDescriptor];

    return fetchRequest;
}

- (RBQFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    RBQFetchRequest *fetchRequest = [self entryListRequest];
    
    _fetchedResultsController = [[RBQFetchedResultsController alloc] initWithFetchRequest:fetchRequest sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;

    return _fetchedResultsController;
}


#pragma mark - <RBQFetchedResultsControllerDelegate>

- (void)controllerWillChangeContent:(RBQFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(RBQFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)controller:(RBQFetchedResultsController *)controller didChangeObject:(RBQSafeRealmObject *)anObject atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
        {
            // Inserting at path
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete:
        {
            // Deleting at path
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate:
        {
            // Updating at path
            if ([[tableView indexPathsForVisibleRows] containsObject:indexPath]) {
                [tableView reloadRowsAtIndexPaths:@[indexPath]
                                 withRowAnimation:UITableViewRowAnimationFade];
            }
            break;
        }
        case NSFetchedResultsChangeMove:
            // Moving to another path
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(RBQFetchedResultsController *)controller
  didChangeSection:(RBQFetchedResultsSectionInfo *)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    // butts
}

@end
