//
//  ViewController.h
//  DBEmojiSDK
//
//  Created by iBuildx_Mac_Mini on 11/29/16.
//  Copyright © 2016 iBuildX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQBEmojiView.h"
@interface ViewController : UIViewController<SQBEmojiDelegate>

@property (weak, nonatomic) IBOutlet SQBEmojiView *emojiView;

@end

