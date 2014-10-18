//
//  Card.m
//  StanfordCardGame
//
//  Created by Bilal Ahmad on 5/3/14.
//  Copyright (c) 2014 Bilal Ahmad. All rights reserved.
//

#import "Card.h"

@interface Card()
@end

@implementation Card

- (int) match:(NSArray *)otherCard {
    int score = 0;
    for (Card *card in otherCard) {
        if([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}


@end
