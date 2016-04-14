//
//  ViewController.m
//  点菜系统
//
//  Created by  江苏 on 16/4/14.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIPickerView* foodPickView;
@property(strong,nonatomic)UIView* headView;
@property(strong,nonatomic)NSArray* foodList;
@property(strong,nonatomic)UILabel* fruitLabel;
@property(strong,nonatomic)UILabel* mainFoodLabel;
@property(strong,nonatomic)UILabel* drinkLabel;
@end

@implementation ViewController

-(UILabel *)fruitLabel{
    if (_fruitLabel==nil) {
        _fruitLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 210, 250, 30)];
        [self.view addSubview:_fruitLabel];
    }
    return _fruitLabel;
}

-(UILabel *)mainFoodLabel{
    if (_mainFoodLabel==nil) {
        _mainFoodLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 250, 250, 30)];
        [self.view addSubview:_mainFoodLabel];
    }
    return _mainFoodLabel;
}

-(UILabel *)drinkLabel{
    if (_drinkLabel==nil) {
        _drinkLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 290, 250, 30)];
        [self.view addSubview:_drinkLabel];
    }
    return _drinkLabel;
}

-(NSArray *)foodList{
    if (_foodList==nil) {
        _foodList=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"foods" ofType:@"plist"]];
    }
    return _foodList;
}

-(UIPickerView *)foodPickView{
    if (_foodPickView==nil) {
        _foodPickView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 100, 320, 100)];
        _foodPickView.delegate=self;
        _foodPickView.dataSource=self;
        [self.view addSubview:_foodPickView];
    }
    return _foodPickView;
}

-(UIView *)headView{
    if (_headView==nil) {
        _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
        _headView.backgroundColor=[UIColor grayColor];
        [self.view addSubview:_headView];
    }
    return _headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self foodPickView];
    
    UILabel* fruitL=[[UILabel alloc]initWithFrame:CGRectMake(10, 210, 40, 30)];
    fruitL.text=@"水果:";
    [self.view addSubview:fruitL];
    UILabel* mainFoodL=[[UILabel alloc]initWithFrame:CGRectMake(10, 250, 40, 30)];
    mainFoodL.text=@"主食:";
    [self.view addSubview:mainFoodL];
    UILabel* drinkL=[[UILabel alloc]initWithFrame:CGRectMake(10, 290, 40, 30)];
    drinkL.text=@"饮料:";
    [self.view addSubview:drinkL];
    
    self.fruitLabel.text=self.foodList[0][0];
    self.mainFoodLabel.text=self.foodList[1][0];
    self.drinkLabel.text=self.foodList[2][0];
    
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 30)];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"随机" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:button];

}

-(void)choose
{
    int fruit=arc4random_uniform((int)[self.foodList[0] count]);
    int mainF=arc4random_uniform((int)[self.foodList[1] count]);
    int drink=arc4random_uniform((int)[self.foodList[2] count]);
    for (int i=0; i<3; i++) {
        switch (i) {
            case 0:
                self.fruitLabel.text=self.foodList[0][fruit];
                [self.foodPickView selectRow:fruit inComponent:0 animated:YES];
                break;
            case 1:
                self.mainFoodLabel.text=self.foodList[1][mainF];
                [self.foodPickView selectRow:mainF inComponent:1 animated:YES];
                break;
            case 2:
                self.drinkLabel.text=self.foodList[2][drink];
                [self.foodPickView selectRow:drink inComponent:2 animated:YES];
                break;
            default:
                break;
        }
    }
}
#pragma mark-pickViewDataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.foodList.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.foodList[component] count];
}

#pragma mark-pickViewDelegate

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.foodList[component][row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
            self.fruitLabel.text=self.foodList[0][row];
            break;
        case 1:
            self.mainFoodLabel.text=self.foodList[1][row];
            break;
        case 2:
            self.drinkLabel.text=self.foodList[2][row];
            break;
        default:
            break;
    }
}
@end
