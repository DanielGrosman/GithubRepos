//
//  Repo.h
//  GithubRepos
//
//  Created by Daniel Grosman on 2017-11-18.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject

@property (nonatomic, strong) NSString *name;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
