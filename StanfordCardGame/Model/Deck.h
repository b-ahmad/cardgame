//
//  Deck.h
//  StanfordCardGame
//
//  Created by Bilal Ahmad on 5/4/14.
//  Copyright (c) 2014 Bilal Ahmad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card *)card atTop:(BOOL)atTop;
- (void) addCard:(Card *)card;
- (Card *) drawRandomCard;

@end
