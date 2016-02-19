//
//  GoodsModel.m
//  购物车
//
//  Created by dpfst520 on 16/2/18.
//  Copyright © 2016年 NttData.dang. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    if (self) {
        
        self.imageName = dict[@"imageName"];
        self.goodsTitle = dict[@"goodsTitle"];
        self.goodsPrice = dict[@"goodsPrice"];
        self.goodsNum = [dict[@"goodsNum"]intValue];
        self.selectState = [dict[@"selectState"]boolValue];
    }
    
    return self;
}



@end
