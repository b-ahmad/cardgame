//
//  CardMatchingGame.h
//  StanfordCardGame
//
//  Created by Bilal Ahmad on 10/15/14.
//  Copyright (c) 2014 Bilal Ahmad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck*)deck;
- (void) chooseCardAtIndex:(NSUInteger) index gameType:(int) game;
- (Card*) cardAtIndex:(NSUInteger)index;
- (NSString*) statusMessage;

@property (nonatomic, readonly) NSInteger score;

@end
