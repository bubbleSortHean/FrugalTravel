//
//  HA_hotelCollectionHead.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/27.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_hotelCollectionHead.h"
#define HEIGHT self.frame.size.height
#define WIDTH self.frame.size.width

@interface HA_hotelCollectionHead()

@property (nonatomic ,retain)UIView *line;

@end

@implementation HA_hotelCollectionHead

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView{
    self.backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pBack"]];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:effect];
    view.tag = 4444;
    view.alpha = 0.7;
    _backView.userInteractionEnabled = YES;
    [self addSubview:_backView];
    [_backView addSubview:view];
    
    self.titleLab = [[UILabel alloc] init];
    _titleLab.text = @"全球超过540,000家酒店供你选择";
    _titleLab.font = [UIFont boldSystemFontOfSize:18];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.textColor = [UIColor whiteColor];
    [_backView addSubview:_titleLab];
    
    self.desLab = [[UILabel alloc] init];
    _desLab.text = @"   选择目的地";
    _desLab.layer.cornerRadius = 5;
    _desLab.layer.masksToBounds = YES;
    _desLab.font = [UIFont systemFontOfSize:16];
    _desLab.textColor = [UIColor whiteColor];
    _desLab.backgroundColor = [UIColor colorWithWhite:0.965 alpha:0.500];
    [_backView addSubview:_desLab];
    
    self.desButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _desButton.backgroundColor = [UIColor clearColor];
    [_backView addSubview:_desButton];
    
    self.dateView = [[UIView alloc] init];
    _dateView.layer.cornerRadius = 5;
    _dateView.layer.masksToBounds = YES;
    _dateView.backgroundColor = [UIColor colorWithWhite:0.965 alpha:0.500];
    [_backView addSubview:_dateView];
    
    self.checkInLabel = [[UILabel alloc] init];
    _checkInLabel.textAlignment = NSTextAlignmentCenter;
    _checkInLabel.text = @"入住日期";
    _checkInLabel.textColor = [UIColor colorWithRed:0.138 green:0.221 blue:0.683 alpha:1.000];
    [_dateView addSubview:_checkInLabel];
    
    self.checkOutLabel = [[UILabel alloc] init];
    _checkOutLabel.textAlignment = NSTextAlignmentCenter;
    _checkOutLabel.text = @"离开日期";
    _checkOutLabel.textColor = [UIColor colorWithRed:0.138 green:0.221 blue:0.683 alpha:1.000];
    [_dateView addSubview:_checkOutLabel];
    
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchBtn setTitle:@"搜索酒店" forState:UIControlStateNormal];
    _searchBtn.layer.cornerRadius = 5;
    _searchBtn.backgroundColor = [UIColor colorWithRed:0.138 green:0.221 blue:0.683 alpha:1.000];
    [_searchBtn setTintColor:[UIColor whiteColor]];
    [_backView addSubview:_searchBtn];
    
    self.hotelLab = [[UILabel alloc] init];
    _hotelLab.text = @"热门城市酒店";
    _hotelLab.textAlignment = NSTextAlignmentCenter;
    _hotelLab.font = [UIFont systemFontOfSize:16];
    _hotelLab.backgroundColor = [UIColor whiteColor];
    [self addSubview:_hotelLab];
    
    self.line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor blackColor];
    [_dateView addSubview:_line];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _backView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 40);
    _titleLab.frame = CGRectMake(0, 15, WIDTH, 30);
    _desLab.frame = CGRectMake(20, 50, WIDTH - 40, 30);
    _desButton.frame = _desLab.bounds;
    _dateView.frame = CGRectMake(20, 90, WIDTH - 40, 110);
    _searchBtn.frame = CGRectMake(20, HEIGHT - 80, WIDTH - 40, 30);
    _hotelLab.frame = CGRectMake(0, HEIGHT - 40, WIDTH, 40);
    _checkInLabel.frame = CGRectMake(0, 10, _dateView.frame.size.width / 2 - 5, 30);
    _checkOutLabel.frame = CGRectMake(_dateView.frame.size.width / 2 + 5, 10, _dateView.frame.size.width / 2 - 5, 30);
    _line.frame = CGRectMake(_dateView.frame.size.width / 2, 10, 1, _dateView.frame.size.height - 20);
    [self viewWithTag:4444].frame = _backView.bounds;
}

@end
