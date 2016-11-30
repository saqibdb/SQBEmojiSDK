//
//  Emoji.h
//  DBEmojiSDK
//
//  Created by iBuildx_Mac_Mini on 11/29/16.
//  Copyright © 2016 iBuildX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Backendless.h>

@interface Emoji : NSObject

@property (nonatomic, strong) NSString *Image;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSString *objectId;



@end
