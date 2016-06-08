//
//  CCCollectionDetailViewController.m
//  ComicCollector
//
//  Created by Jacob Wernette on 2/12/16.
//  Copyright © 2016 Jacob Wernette. All rights reserved.
//

#import "CCCollectionDetailViewController.h"
#import "CCItemDetailViewController.h"
#import "LTInfiniteScrollView.h"

#import "Comic.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define COLOR [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]

@interface CCCollectionDetailViewController () <LTInfiniteScrollViewDelegate,LTInfiniteScrollViewDataSource>

@property (strong, nonatomic) LTInfiniteScrollView *scrollView;
@property (strong, nonatomic) RLMResults *comicArray;
@property (strong, nonatomic) Comic *selectedComic;

@end

@implementation CCCollectionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.title =  self.collection.name;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    // Do any additional setup after loading the view.
    self.scrollView = [[LTInfiniteScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.scrollView];
    
    self.scrollView.dataSource = self;
    self.scrollView.delegate = self;
    self.scrollView.maxScrollDistance = 3;

    NSArray *arr = [self.collection.comics valueForKey:@"id"];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"id IN %@", arr];
    RLMResults<Comic *> *comarr = [Comic objectsWithPredicate:pred];

    self.comicArray = comarr;
    
    [self.scrollView reloadDataWithInitialIndex: [self.collection.comics count] - 1];
    CGFloat inset = [UIScreen mainScreen].bounds.size.width / 5 * 2;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, inset, 0, inset);
    [self sortViews];
}


- (void)sortViews
{
    NSMutableArray *views = [[self.scrollView allViews] mutableCopy];
    [views sortUsingComparator:^NSComparisonResult(UIView *view1, UIView *view2) {
        return view1.tag > view2.tag;
    }];
    for (UIView *view in views) {
        [view.superview bringSubviewToFront:view];
    }
}

# pragma mark - LTInfiniteScrollView dataSource
- (NSInteger)numberOfViews
{
    return [self.collection.comics count];
}

- (NSInteger)numberOfVisibleViews
{
    return 5;
}

# pragma mark - LTInfiniteScrollView delegate
- (UIView *)viewAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view) {
        view = [self newCard:index];
    }
    return view;
}

- (UIView *)newCard:(NSInteger)index
{
    CGFloat width =  SCREEN_WIDTH / 10 * 7.2;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 500)];
    
    UIView *snapshot = [[UIView alloc] initWithFrame:CGRectMake(0, 60, width, 430)];
    snapshot.backgroundColor = [UIColor whiteColor];
    snapshot.layer.cornerRadius = 5;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:snapshot.bounds];
    snapshot.layer.shadowColor = [UIColor blackColor].CGColor;
    snapshot.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    snapshot.layer.shadowOpacity = .3;
    snapshot.layer.shadowPath = shadowPath.CGPath;
    
    Comic *comic = [self.comicArray objectAtIndex:index];
    
    NSString *myString = [[NSString alloc] initWithData:comic.thumbnail encoding:NSUTF8StringEncoding];
    NSData* data = [[NSData alloc] initWithBase64EncodedString:myString options:0];
    UIImage* image = [UIImage imageWithData:data];
    
    UIGraphicsBeginImageContext(snapshot.frame.size);
    [image drawInRect:snapshot.bounds];
    UIImage *butts = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    snapshot.backgroundColor = [UIColor colorWithPatternImage:butts];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemSelected:)];
    [snapshot addGestureRecognizer:tap];
    
    snapshot.tag = index;
    
    
    [view addSubview:snapshot];
    return view;
}

- (void)updateView:(UIView *)view withProgress:(CGFloat)progress scrollDirection:(ScrollDirection)direction
{
    // adjust z-index of each views
    [self sortViews];
    
    // alpha
    CGFloat alpha = 1;
    if (progress >= 0) {
        alpha = 1;
    } else {
        alpha = 1 - fabs(progress) * 0.25;
    }
    view.alpha = alpha;
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    // scale
    CGFloat scale = 1 + (progress) * 0.05;
    transform = CGAffineTransformScale(transform, scale, scale);
    
    // translation
    CGFloat translation = 0;
    if (progress == 0) {
        translation = fabs(progress) * SCREEN_WIDTH / 3;
    } else if (progress > 0){
        translation = fabs(progress) * SCREEN_WIDTH / 2;
    } else {
        translation = fabs(progress) * SCREEN_WIDTH / 10;
    }

    transform = CGAffineTransformTranslate(transform, translation, 0);
    view.transform = transform;
}

- (void)itemSelected:(UITapGestureRecognizer *)gr {
    self.selectedComic = [self.comicArray objectAtIndex:gr.view.tag];
    
    [self performSegueWithIdentifier:@"comicDetail" sender:gr];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CCItemDetailViewController *vc = [segue destinationViewController];
    vc.comic = self.selectedComic;
}


@end
