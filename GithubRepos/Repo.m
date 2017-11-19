//
//  Repo.m
//  GithubRepos
//
//  Created by Daniel Grosman on 2017-11-18.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "Repo.h"

@implementation Repo

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _name = dict[@"name"];
    }
    
    return self;
}


@end
