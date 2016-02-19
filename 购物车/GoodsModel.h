//
//  GoodsModel.h
//  购物车
//
//  Created by dpfst520 on 16/2/18.
//  Copyright © 2016年 NttData.dang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

@property (nonatomic, strong)NSString *imageName;//商品图片
@property (nonatomic, strong)NSString *goodsTitle;//商品标题
@property (nonatomic, strong)NSString *goodsPrice;//商品价格
@property (nonatomic, assign)BOOL selectState;//是否选中状态

@property (nonatomic, assign)int goodsNum;//商品个数

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
