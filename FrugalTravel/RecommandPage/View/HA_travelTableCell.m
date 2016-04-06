//
//  HA_travelTableCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/19.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_travelTableCell.h"
#define CWIDTH self.frame.size.width
#define CHEIGHT self.frame.size.height

@implementation HA_travelTableCell

- (void)dealloc
{
    [_photoImg release];
    [_titleLable release];
    [_userLabel release];
    [_viewsImg release];
    [_viewLabel release];
    [_replyLabel release];
    [_replysImg release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

- (void)createView{
    self.photoImg = [[UIImageView alloc] init];
    _photoImg.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_photoImg];
    
    self.titleLable = [[UILabel alloc] init];
    _titleLable.numberOfLines = 2;
    _titleLable.font = [UIFont boldSystemFontOfSize:17];
    [self.contentView addSubview:_titleLable];
    
    self.userLabel = [[UILabel alloc] init];
    _userLabel.font = [UIFont systemFontOfSize:16];
    _userLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_userLabel];
    
    self.viewsImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_viewsImg];
    
    self.viewLabel = [[UILabel alloc] init];
    _viewLabel.font = [UIFont systemFontOfSize:15];
    _viewLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview: _viewLabel];
    
    self.replysImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_replysImg];
    
    self.replyLabel = [[UILabel alloc] init];
    _replyLabel.font = [UIFont systemFontOfSize:15];
    _replyLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_replyLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _photoImg.frame = CGRectMake(5, 5, CWIDTH / 3 -10, CHEIGHT - 10);
    _titleLable.frame = CGRectMake(CWIDTH / 3 + 10, 5, CWIDTH * 2 / 3 - 15, CHEIGHT / 2);
    _userLabel.frame = CGRectMake(CWIDTH / 3 + 10, CHEIGHT / 2, CWIDTH * 2 / 3 , CHEIGHT / 4);
    _viewsImg.frame = CGRectMake(CWIDTH / 3 + 10, CHEIGHT * 3 / 4 + 14, CHEIGHT / 5 - 10, CHEIGHT / 6 - 14);
    _viewLabel.frame = CGRectMake(CWIDTH / 3 + 5 + CHEIGHT / 4, CHEIGHT * 3 / 4 + 5, CWIDTH / 4 - 10, CHEIGHT / 4 - 10);
    _replysImg.frame = CGRectMake(CWIDTH * 7 / 12 + CHEIGHT / 4 - 5, CHEIGHT * 3 / 4 + 14, CHEIGHT / 5 - 10, CHEIGHT / 6 - 14);
    _replyLabel.frame = CGRectMake(CWIDTH * 7 / 12 + CHEIGHT / 2 - 10, CHEIGHT * 3 / 4 + 5, CWIDTH / 4 - 5, CHEIGHT / 4 - 10);
    
}

@end
