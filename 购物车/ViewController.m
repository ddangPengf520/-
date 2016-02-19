//
//  ViewController.m
//  购物车
//
//  Created by dpfst520 on 16/2/18.
//  Copyright © 2016年 NttData.dang. All rights reserved.
//

#import "ViewController.h"

#import "TableViewCell.h"

#import "GoodsModel.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate>
{
    float allPrice;
    
}

@property (nonatomic, strong)UITableView *myTableView;

@property (nonatomic, strong)UIButton *allSelectBtn;
@property (nonatomic, strong)UILabel *allPriceLab;

@property (nonatomic, strong)NSMutableArray *infoArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithTableView];
    
    //初始化数据
    allPrice = 0.0;
    
    self.infoArr = [[NSMutableArray alloc]init];
    
    //初始化数组，数组里面放字典，字典里面放的是每个cell需要展示的数据
    
    for (int i = 0; i < 3; i ++) {
        
        NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
        
        [infoDict setValue:@"2.png" forKey:@"imageName"];
        [infoDict setValue:@"商品标题" forKey:@"goodsTitle"];
        [infoDict setValue:@"50" forKey:@"goodsPrice"];
        [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
        
        [infoDict setValue:[NSNumber numberWithInt:1] forKey:@"goodsNum"];
        
        //封装数据模型
        
        GoodsModel *model = [[GoodsModel alloc]initWithDict:infoDict];
        
        //将数据模型放入数组
        [self.infoArr addObject:model];
        
        
    }
    
    
}

- (void)initWithTableView
{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    self.myTableView.dataSource = self;
    
    self.myTableView.delegate = self;
    
//    [self.myTableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"shopCell"];
    
    self.myTableView.tableFooterView = [self creatFootView];
    
    [self.view addSubview:self.myTableView];
}

- (UIView *)creatFootView
{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
//    footView.backgroundColor = [UIColor redColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 150, 10, 50, 30)];
    label.text = @"全选";
    
    [footView addSubview:label];
    
    //添加全选图片按钮
    _allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _allSelectBtn.frame = CGRectMake(self.view.frame.size.width- 100, 10, 30, 30);
    [_allSelectBtn setImage:[UIImage imageNamed:@"复选框-未选中"] forState:UIControlStateNormal];
    [_allSelectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:_allSelectBtn];
    
    //添加小结文本框
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 150, 40, 60, 30)];
    lab2.textColor = [UIColor redColor];
    lab2.text = @"小结：";
    [footView addSubview:lab2];
    
    //添加一个总价格文本框，用于显示总价
    _allPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 100, 40, 100, 30)];
    _allPriceLab.textColor = [UIColor redColor];
    _allPriceLab.text = @"0.0";
    [footView addSubview:_allPriceLab];
    
    
    //添加一个结算按钮
    UIButton *settlementBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [settlementBtn setTitle:@"去结算" forState:UIControlStateNormal];
    [settlementBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    settlementBtn.frame = CGRectMake(10, 80, self.view.frame.size.width - 20, 30);
    settlementBtn.backgroundColor = [UIColor blueColor];
    [footView addSubview:settlementBtn];

    
    return footView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _infoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"shopCell";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[TableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
        //给每个cell添加代理
        cell.delegate = self;
    }
    
    cell.selectionStyle = UITableViewCellAccessoryNone;
    
    //调用方法、给单元格赋值
    [cell addTheValue:_infoArr[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
    GoodsModel *model = _infoArr[indexPath.row];
    
    if (model.selectState) {
        
        model.selectState = NO;
        
    } else {
        
        model.selectState = YES;
    }
    
    //刷新当前表格
    
    [self.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    
    //选择每个cell 的时候  都会计算价格
    [self addPrice];


}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//改变删除按钮的title
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return @"删除";
}

//删除购物车里面的内容
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //删除数组里面的商品信息
        [self.infoArr removeObjectAtIndex:indexPath.row];
        
        //删除整个cell
        [self.myTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(void)selectBtnClick:(UIButton *)sender
{
    //判断是否选中，是改成否、否改成是、并且改变图片状态
    sender.tag = !sender.tag;
    
    if (sender.tag) {
        
        [sender setImage:[UIImage imageNamed:@"复选框-选中"] forState:(UIControlStateNormal)];
        
    } else {
        
        [sender setImage:[UIImage imageNamed:@"复选框-未选中"] forState:(UIControlStateNormal)];
    }
    
    //改变单元格选中状态
    for (int i = 0; i < _infoArr.count; i++) {
        
        GoodsModel *model = [_infoArr objectAtIndex:i];
        
        model.selectState = sender.tag;
    }
    
    //计算价格
    [self addPrice];
    
    //刷新表格
    [self.myTableView reloadData];
    
}

#pragma mark -- 实现加减按钮的我点击代理事件
/*
 *cell 为当前单元格
 * flag按钮表示符  11 为减按钮 、 12 为加按钮
 */

- (void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [_myTableView indexPathForCell:cell];
    
    switch (flag) {
        case 11:
        {
            //做减法
            //先获取到当期行数据源内容，改变数据源内容，刷新表格
            GoodsModel *model = _infoArr[index.row];
            if (model.goodsNum > 1)
            {
                model.goodsNum --;
            }
        }
            break;
        case 12:
        {
            //做加法
            GoodsModel *model = _infoArr[index.row];
            
            model.goodsNum ++;
            
            
        }
            break;
        default:
            break;
    }
    
    //刷新表格
    [_myTableView reloadData];
    
    //计算总价
    [self addPrice];
}

- (void)addPrice
{
    //遍历整个数据源、并且判断如果是选中的商品、就计算价格（单价 * 商品数量）
    for (int i = 0; i < _infoArr.count; i ++) {
        
        GoodsModel *model = [_infoArr objectAtIndex:i];
        
        if (model.selectState) {
            
            //总价 = 商品数量 * 商品单价
            allPrice = allPrice + model.goodsNum * [model.goodsPrice intValue];
        }
    }
    
    //给文本赋值
    _allPriceLab.text = [NSString stringWithFormat:@"%.2f", allPrice];
    
    NSLog(@"%f", allPrice);
    
    //每次计算完总价后清零
    allPrice = 0.0;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
