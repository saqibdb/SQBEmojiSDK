//
//  SQBEmojiView.m
//  DBEmojiSDK
//
//  Created by iBuildx_Mac_Mini on 11/29/16.
//  Copyright © 2016 iBuildX. All rights reserved.
//

#import "SQBEmojiView.h"
#import "Backendless.h"
#import "Categories.h"
#import "EmojiCollectionViewCell.h"
#import "Emoji.h"
#import "SQBEmojiSDK-Bridging-Header.h"
@implementation SQBEmojiView{
    NSArray *categories ;
    NSArray *emojis ;
    BOOL emojiSelected ;
}

-(void)setupSQBEmojis{
    

    UINib *customNib = [UINib nibWithNibName:@"SQBEmojiView" bundle:nil];
    self.emojiView = [[customNib instantiateWithOwner:self options:nil] objectAtIndex:0];
    [self addSubview:self.emojiView];
    
    self.emojiView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) ;
    //[self addSubview:self.emojiCollectionView] ;
    self.emojiView.emojiCollectionView.delegate = self ;
    self.emojiView.emojiCollectionView.dataSource = self ;
    [self.emojiView.emojiCollectionView registerNib:[UINib nibWithNibName:@"SQBCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"EmojiCollectionViewCell"];

    if (backendless.userService.currentUser) {
        [backendless.userService isValidUserToken:
         ^(NSNumber *result) {
             NSLog(@"isValidUserToken (ASYNC): %@", [result boolValue]?@"YES":@"NO");
             
             
             [self loadStickers] ;
             
             
         }
                                            error:^(Fault *fault) {
                                                NSLog(@"login FAULT (ASYNC): %@", fault);
                                                if ([fault.faultCode isEqualToString:@"3064"] ) {
                                                    BackendlessUser *user = backendless.userService.currentUser ;
                                                    user.password = @"1223" ;
                                                    [self loginWithUser:user] ;
                                                }
                                                else {
                                                    /// TODO No internet
                                                }
                                            }];
    }
    else{
        BackendlessUser *user = [[BackendlessUser alloc] init] ;
        user.email = @"test@ibuildx.com" ;
        user.password = @"1223" ;
        [self loginWithUser:user] ;
        
    }
    
    NSLog(@"______%@_______" , backendless.userService.currentUser.name) ;
}
-(void)loginWithUser :(BackendlessUser *)loginUser
{
    [backendless.userService login:loginUser.email password:loginUser.password response:^(BackendlessUser *userLogged) {
        [backendless.userService setStayLoggedIn:YES] ;
        
        [self loadStickers] ;
    } error:^(Fault *error) {
        /// TODO No internet
    }];
}
-(void)loadStickers {
    [backendless.persistenceService find:[Categories class] dataQuery:nil response:^(BackendlessCollection *collection) {
        NSLog(@"Total Objects count = %lu" , (unsigned long)collection.data.count) ;
        categories = collection.data ;
        [self.emojiView.emojiCollectionView reloadData] ;
    } error:^(Fault *error) {
        
    } ] ;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (emojiSelected) {
        return emojis.count ;
    }
    else{
        return categories.count ;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize cellSize = CGSizeMake((self.emojiView.emojiCollectionView.frame.size.height/2) - 5, (self.emojiView.emojiCollectionView.frame.size.height/2) - 5) ;
    return cellSize ;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EmojiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EmojiCollectionViewCell" forIndexPath:indexPath];
    NSString *imageUrl ;
    NSString *stickerName ;
    
    if (emojiSelected) {
        Emoji *emoji = emojis[indexPath.row];
        imageUrl = emoji.Image ;
        stickerName = emoji.Name ;
    }
    else{
        Categories *category = categories[indexPath.row] ;
        imageUrl = category.Image ;
        stickerName = category.Name ;
    }
    cell.stickerName.text = stickerName ;
    cell.stickerImage.image = nil ;
    FaveButton *newBtn = [[FaveButton alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.height - 40, cell.frame.size.height - 40) faveIconNormal:[UIImage imageNamed:@"heartIcon"]] ;
    [newBtn setSelectedColor:[UIColor greenColor]] ;
    [newBtn setDotSecondColor:[UIColor blueColor]] ;
    [newBtn setDotFirstColor:[UIColor greenColor]] ;
    [newBtn setCircleFromColor:[UIColor blueColor]] ;
    [newBtn setCircleToColor:[UIColor greenColor]] ;
    [cell addSubview:newBtn];
    newBtn.center = CGPointMake( cell.bounds.size.width / 2, (cell.bounds.size.height-30)/2 );
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageUrl]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            [newBtn animateSelect:YES duration:1.0] ;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                cell.stickerImage.image = [UIImage imageWithData: data] ;
                [cell bringSubviewToFront:cell.stickerImage] ;
                [newBtn removeFromSuperview];
            });
        });
    });
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (emojiSelected) {
        Emoji *emoji = emojis[indexPath.row] ;
        id<SQBEmojiDelegate> strongDelegate = self.delegate ;
        [strongDelegate SQBEmojiDidExportImageForSticker:emoji.Image] ;
    }
    else{
        Categories *category = categories[indexPath.row] ;
        
        emojis = category.Emojis ;
        [self.emojiView.emojiCollectionView reloadData] ;
        emojiSelected = YES ;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end