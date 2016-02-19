//
//  TableViewCell.h
//  购物车
//
//  Created by dpfst520 on 16/2/18.
//  Copyright © 2016年 NttData.dang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GoodsModel.h"

//添加用于按钮加减的代理
@protocol TableViewCellDelegate <NSObject>

- (void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;

//删除按钮
- (void)deleteClickedWithIndexPath:(NSIndexPath *)indexPath;


@end

@interface TableViewCell : UITableViewCell


@property (nonatomic, strong)UIImageView *goodsImgV;//商品图片
@property (nonatomic, strong)UILabel *goodsTitleLab;//商品标题
@property (nonatomic, strong)UILabel *priceTitleLab;//价格标签
@property (nonatomic, strong)UILabel *priceLab;//具体价格
@property (nonatomic, strong)UILabel *goodsNumLab;//购买数量标签
@property (nonatomic, strong)UILabel *numCountLab;//购买商品的数量
@property (nonatomic, strong)UIButton *addBtn;//添加商品数量
@property (nonatomic, strong)UIButton *deleteBtn;//删除商品数量
@property (nonatomic, strong)UIButton *isSelectBtn;//是否选中按钮


@property(nonatomic, strong)UIImageView *isSelectImg;//是否选中图片

@property(nonatomic,assign)BOOL selectState;//选中状态




@property(nonatomic,assign)id<TableViewCellDelegate>delegate;


//赋值
-(void)addTheValue:(GoodsModel *)goodsModel;


@end
