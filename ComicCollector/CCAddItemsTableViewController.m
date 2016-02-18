//
//  AddItemsTableViewController.m
//  ComicCollector
//
//  Created by Jacob Wernette on 2/11/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "CCAddItemsTableViewController.h"
#import "CCCustomSearchViewController.h"
#import "CCCoreDataStack.h"
#import "Comic.h"

@interface CCAddItemsTableViewController () <UISearchBarDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) CCCustomSearchViewController *searchController;

@property (nonatomic, strong) NSArray *searchResults;

@end

@implementation CCAddItemsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchController = [[CCCustomSearchViewController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    
    // we want to be the delegate for our filtered table so didSelectRowAtIndexPath is called for both tables
    self.searchController.dimsBackgroundDuringPresentation = NO; // default is YES
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    
    self.searchController.searchBar.barTintColor = [UIColor greenColor];
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchController.searchBar.translucent = NO;
    
    self.navigationItem.titleView = self.searchController.searchBar;
    
    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *dismissItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissAddItems)];
    self.navigationItem.rightBarButtonItem = dismissItem;
    
    self.definesPresentationContext = YES;

    self.navigationItem.hidesBackButton = YES;

}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.searchController setActive:YES];
}

- (void) dismissAddItems {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
    
    
    static NSString *CellIdentifier = @"searchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSObject *obj = [self.searchResults objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [obj valueForKeyPath:@"title"];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[obj valueForKeyPath:@"thumbnail"]]
                      placeholderImage:nil];

    
    UIButton *contactAddButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [contactAddButton setTag:indexPath.row];
    [contactAddButton addTarget:self action:@selector(addItem:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = contactAddButton;
    
    
    return cell;
}

- (void)addItem:(id)sender {
    NSLog(@"%ld", (long)[sender tag]);
    NSLog(@"%@", [self.searchResults objectAtIndex:[sender tag]]);
    
    NSLog(@"%@", self.entry);
    
    NSInteger row = [sender tag];
    NSDictionary *obj = [self.searchResults objectAtIndex:row];
    
    CCCoreDataStack *stack = [CCCoreDataStack defaultStack];

    Collection *collection = self.entry;
    
    Comic *comic = [NSEntityDescription insertNewObjectForEntityForName:@"Comic" inManagedObjectContext:stack.managedObjectContext];
    comic.id = [obj valueForKey:@"id"];
    comic.digitalId = [obj valueForKey:@"digitalId"];
    comic.title = [obj valueForKey:@"title"];
    
    if ([[obj valueForKey:@"description"] isKindOfClass:[NSNull class]]) {
       comic.comicDescription = @"";
    } else {
       comic.comicDescription = [obj valueForKey:@"description"];
    }
    
    NSURL *thumbnailURL = [[NSURL alloc] initWithString:[obj valueForKey:@"thumbnail"]];
    NSData *data = [NSData dataWithContentsOfURL:thumbnailURL];
    NSData *base64 = [data base64EncodedDataWithOptions:NSUTF8StringEncoding];
    
    comic.thumbnail = base64;
    
    [collection addComicsObject:comic];
    
    [stack saveContext];
    
    
}


- (void) search:(NSString *)q {

    NSString *urlString = [@"http://104.236.118.99/api/items/search/" stringByAppendingString:q];
    
    NSString *newURL = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    NSURL *url = [[NSURL alloc]initWithString: newURL];

    
    //type your URL u can use initWithFormat for placeholders
    NSURLSession *session = [NSURLSession sharedSession];  //use NSURLSession class
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:url];

    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {

        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSArray *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

        NSLog(@"%@", [responseDictionary objectAtIndex:0]);
        self.searchResults = [responseDictionary objectAtIndex:0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    [task resume]; // to start the download task
    
}

-(void) updateSearchResultsForSearchController:(CCCustomSearchViewController *)searchController {
    
    if (searchController.active && ![searchController.searchBar.text  isEqual: @""]) {
        [self search:searchController.searchBar.text];
    }
    
}

@end
