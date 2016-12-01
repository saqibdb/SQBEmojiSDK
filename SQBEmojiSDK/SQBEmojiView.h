//
//  SQBEmojiView.h
//  DBEmojiSDK
//
//  Created by iBuildx_Mac_Mini on 11/29/16.
//  Copyright © 2016 iBuildX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SQBEmojiDelegate;

@interface SQBEmojiView : UIView <UICollectionViewDelegate , UICollectionViewDataSource , UITextFieldDelegate>

@property (nonatomic, weak) id<SQBEmojiDelegate> delegate;



@property (weak, nonatomic) IBOutlet UITextField *emojiSearchText;


@property (weak, nonatomic) IBOutlet UICollectionView *emojiCollectionView;
@property (weak, nonatomic) SQBEmojiView *emojiView;
@property (weak, nonatomic) IBOutlet UIButton *magnifyingBtn;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *infoText;




- (IBAction)magnifyingAction:(id)sender;
- (IBAction)historyAction:(id)sender;

-(void)setupSQBEmojis ;

@end

@protocol SQBEmojiDelegate <NSObject>

- (void)SQBEmojiDidExportImageForSticker:(NSString *)imageURL ;
@end

