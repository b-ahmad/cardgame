//
//  PlayingCard.h
//  StanfordCardGame
//
//  Created by Bilal Ahmad on 5/4/14.
//  Copyright (c) 2014 Bilal Ahmad. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger) maxRank;

@end
