//
//  Inbox.h
//  Accomplice
//
//  Created by Muhammad Saqib Yaqeen on 4/1/16.
//  Copyright © 2016 ibuildx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Backendless.h>


@interface Categories : NSObject

@property (nonatomic, strong) NSArray *Emojis;
@property (nonatomic, strong) NSString *Image;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *TrendingValue;



@end
