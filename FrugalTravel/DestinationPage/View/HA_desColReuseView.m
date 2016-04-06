//
//  HA_desColReuseView.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/20.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_desColReuseView.h"
#import "Macro.h"
#import "DKNightVersion.h"
@interface HA_desColReuseView ()

@property (nonatomic ,retain)UIButton *globalBtn;

@end

@implementation HA_desColReuseView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)dealloc
{
    Block_release(_passBlock);
    [_imageView release];
    [_textLab release];
    [super dealloc];
}

- (void)createView{
    self.isSelect = 0;
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map"]];
    _imageView.userInteractionEnabled = YES;
    [self addSubview:_imageView];
    
    self.textLab = [[UILabel alloc] init];
    _textLab.font = [UIFont systemFontOfSize:18];
    _textLab.dk_textColorPicker = DKColorWithColors([UIColor darkGrayColor], [UIColor lightGrayColor]);
    _textLab.text = @"亚洲热门目的地";
    [self addSubview:_textLab];
    for (NSInteger i = 0; i < 7; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSArray *arr = @[@"北美洲",@"南美洲",@"非洲",@"南极洲",@"亚洲",@"大洋洲",@"欧洲"];
//        button.frame = CGRectMake(10 * i, 50, 50, 50);
        if (i == 4) {
            button.backgroundColor = [UIColor colorWithRed:0.052 green:0.751 blue:0.544 alpha:1.000];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
        }
        button.layer.cornerRadius = 5;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = 1000 + i;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_imageView addSubview:button];
    }
}
#pragma warning block在这
- (void)click:(UIButton *)btn{
    // block 传值
    self.passBlock(btn.titleLabel.text);
    _textLab.text = [NSString stringWithFormat:@"%@热门目的地",btn.titleLabel.text];
    for (NSInteger i = 0; i < 7; i++) {
        UIButton *button = [self viewWithTag:1000 + i];
        if (button.tag == btn.tag) {
            btn.backgroundColor = [UIColor colorWithRed:0.052 green:0.751 blue:0.544 alpha:1.000];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }


}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    UIButton *nABtn = [self viewWithTag:1000];
    UIButton *sABtn = [self viewWithTag:1001];
    UIButton *afrBtn = [self viewWithTag:1002];
    UIButton *antBtn = [self viewWithTag:1003];
    UIButton *asiaBtn = [self viewWithTag:1004];
    UIButton *oceBtn = [self viewWithTag:1005];
    UIButton *eurBtn = [self viewWithTag:1006];
 
    
    _imageView.frame = CGRectMake(0, 0, width, height * FIT_SCREEN_HEIGHT - 40);
    nABtn.frame = CGRectMake(50 * FIT_SCREEN_WIDTH, 30 * FIT_SCREEN_HEIGHT, 60 * FIT_SCREEN_WIDTH, 35 * FIT_SCREEN_HEIGHT);
    sABtn.frame = CGRectMake(105 * FIT_SCREEN_WIDTH, 100 * FIT_SCREEN_HEIGHT, 60 * FIT_SCREEN_WIDTH, 35 * FIT_SCREEN_HEIGHT);
    afrBtn.frame = CGRectMake(200 * FIT_SCREEN_WIDTH , 90 * FIT_SCREEN_HEIGHT, 60 * FIT_SCREEN_WIDTH, 35 * FIT_SCREEN_HEIGHT);
    antBtn.frame = CGRectMake(250 * FIT_SCREEN_WIDTH, 160 * FIT_SCREEN_HEIGHT, 60  * FIT_SCREEN_WIDTH, 35 * FIT_SCREEN_HEIGHT);
    asiaBtn.frame = CGRectMake(310 * FIT_SCREEN_WIDTH, 30 * FIT_SCREEN_HEIGHT, 60 * FIT_SCREEN_WIDTH, 35 * FIT_SCREEN_HEIGHT);
    oceBtn.frame = CGRectMake(330 * FIT_SCREEN_WIDTH, 100 * FIT_SCREEN_HEIGHT, 60 * FIT_SCREEN_WIDTH, 35 * FIT_SCREEN_HEIGHT);
    eurBtn.frame = CGRectMake(220 * FIT_SCREEN_WIDTH, 40 * FIT_SCREEN_HEIGHT, 60 * FIT_SCREEN_WIDTH, 35 * FIT_SCREEN_HEIGHT);
    
    _textLab.frame = CGRectMake(5, _imageView.frame.size.height, self.frame.size.width - 10 * FIT_SCREEN_WIDTH, 40  * FIT_SCREEN_HEIGHT);
    
}

@end
