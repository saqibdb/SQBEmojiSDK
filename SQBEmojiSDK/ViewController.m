//
//  ViewController.m
//  DBEmojiSDK
//
//  Created by iBuildx_Mac_Mini on 11/29/16.
//  Copyright © 2016 iBuildX. All rights reserved.
//

#import "ViewController.h"
#import "SQBEmojiView.h"

@interface ViewController (){
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emojiView.delegate = self ;

    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)SQBEmojiDidExportImageForSticker:(NSString *)imageURL {
    NSLog(@"Image gotten") ;
}

-(void)viewWillAppear:(BOOL)animated{
   
    [self.emojiView setupSQBEmojis] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
