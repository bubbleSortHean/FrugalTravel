//
//  BaseTableViewCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/16.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DKNightVersion.h"
@implementation BaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor darkGrayColor]);
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
