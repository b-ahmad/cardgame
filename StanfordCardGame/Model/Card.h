//
//  Card.h
//  StanfordCardGame
//
//  Created by Bilal Ahmad on 5/3/14.
//  Copyright (c) 2014 Bilal Ahmad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isMatched) BOOL matched;
@property (nonatomic, getter = isChosen) BOOL chosen;

- (int) match:(NSArray *) otherCards;

@end
