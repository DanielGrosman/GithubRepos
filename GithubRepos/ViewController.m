//
//  ViewController.m
//  GithubRepos
//
//  Created by Daniel Grosman on 2017-11-18.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "ViewController.h"
#import "Repo.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<Repo*> *reposArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/DanielGrosman/repos"];
    // this object is used to make configurations specific to the URL
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        
        // create an array of dictionary items from the JSON file
        NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        // initialize the reposArray
        self.reposArray = [[NSMutableArray alloc] init];
        // for each of the repo dictionaries in the repo array, create a new Repo class item, initialize it with a repo from the dictionary, and then add it to the reposArray
        for (NSDictionary *repo in repos)
        {
            Repo *newRepo = [[Repo alloc] initWithDictionary:repo];
            
            [self.reposArray addObject:newRepo];
            
            // relod the tableView (always have to perform UI updates on the main thread)
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
        }
    }];
    
    [dataTask resume];
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reposArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    // initiatlize a repo object and give it a repo object from the reposArray at the indexpath.row
    Repo *currentRepo = self.reposArray[indexPath.row];
    cell.textLabel.text = currentRepo.name;
    
    return cell;
}

@end
