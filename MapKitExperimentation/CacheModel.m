//
//  CacheModel.m
//  MapKitExperimentation
//
//  Created by Justin Huntington on 5/28/15.
//  Copyright (c) 2015 Justin Huntington. All rights reserved.
//

#import "CacheModel.h"

@implementation CacheModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cacheLocation = [[CLLocation alloc] initWithLatitude:40.7708 longitude:-111.8920];

    }
    return self;
}

@end
