//
//  EmojiCollectionViewCell.h
//  DBEmojiSDK
//
//  Created by iBuildx_Mac_Mini on 11/29/16.
//  Copyright © 2016 iBuildX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQBCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *stickerImage;
@property (weak, nonatomic) IBOutlet UILabel *stickerName;

@end
