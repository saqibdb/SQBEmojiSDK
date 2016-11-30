//
//  SQBEmojiView.h
//  DBEmojiSDK
//
//  Created by iBuildx_Mac_Mini on 11/29/16.
//  Copyright © 2016 iBuildX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SQBEmojiDelegate;

@interface SQBEmojiView : UIView <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic, weak) id<SQBEmojiDelegate> delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *emojiCollectionView;
@property (weak, nonatomic) SQBEmojiView *emojiView;

-(void)setupSQBEmojis ;

@end

@protocol SQBEmojiDelegate <NSObject>

- (void)SQBEmojiDidExportImageForSticker:(NSString *)imageURL ;
@end

