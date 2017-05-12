//
//  ViewController.m
//  DelegateDemo
//
//  Created by 融易乐 on 2017/5/9.
//  Copyright © 2017年 融易乐. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    //    自动调整子视图大小
        _tableView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    
    _tableView.delegate=self;
    _tableView.dataSource=self;

    //创建一个可变数组
    _arrayData=[[NSMutableArray alloc  ]init];
    
    for(int i='A';i<='z';i++)
    {
        NSMutableArray* smallArray=[[NSMutableArray alloc] init];
        for (int j=1; j<5; j++) {
            NSString* str=[NSString stringWithFormat:@"%c,%d",i,j];
            [smallArray addObject:str];
        }
        [_arrayData addObject:smallArray];
    }


    _tableView.tableFooterView=nil;//nil继承UI View就行
    _tableView.tableHeaderView=nil;
    self.view.backgroundColor=[UIColor orangeColor];
    [_tableView reloadData];
    [self.view addSubview:_tableView];
    UILabel* lab=[[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    
     _imageArray= [NSArray arrayWithObjects : @"IMG_3837.JPG",@"IMG_3839.JPG",@"IMG_3842.JPG",@"IMG_3844.JPG",@"IMG_3838.JPG",nil];
    
    

    [self.view addSubview:lab];
    [self createBtn];
   
}

-(void)createBtn{
    _isEdit=NO;
    
//    创建导航栏按钮
    _btnEdit=[[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEdit)];
    _btnDel=[[UIBarButtonItem alloc ]initWithTitle:@"del" style:UIBarButtonItemStylePlain target:self action:@selector(onDel)];
    _btnFInish=[[UIBarButtonItem alloc]initWithTitle:@"finish" style:UIBarButtonItemStylePlain target:self action:@selector(onFinish)];
    self.navigationItem.rightBarButtonItem=_btnEdit;
//    self.navigationItem.leftBarButtonItem=_btnDel;
    
    
}

-(void)toggleEdit{
    _isEdit=YES;
    self.navigationItem.rightBarButtonItem=_btnFInish;
    [_tableView setEditing:YES];
    self.navigationItem.leftBarButtonItem=_btnDel;
}

-(void)onDel{}
-(void)onFinish{
    _isEdit=NO;
    self.navigationItem.rightBarButtonItem=_btnEdit;
    [_tableView setEditing:NO];
    self.navigationItem.leftBarButtonItem=nil;
}
//获取每组元素个数（行数）
//必须实现，显示数据视图是回调用此函数
//返回值：每组元素个数
//P1：数据视图对象本身
//P2:那一组需要的行数

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger numbRow=[[_arrayData objectAtIndex:section] count];
    return numbRow;}

//获取组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrayData.count;
}
//单元格显示效果协议
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//     
//    组合状态，效果为多选
//    return UITableViewCellEditingStyleInsert|UITableViewCellEditingStyleDelete;
//    return UITableViewCellEditingStyleInsert;//添加
        return UITableViewCellEditingStyleDelete;//默认也是这个效果
}

//单条进入edit状态，只有当editingStyle返回的是删除状态才能够正常触发
//当单条进入删除状态时并不会出发，点击单条上的删除按钮时才会触发，
//当eitingStyle返回不为del时，无法触发条目的状态改变，所以更不会触发此方法


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"ONEDIT");
    
//    [_arrayData removeObjectAtIndex:indexPath.row ];//数据源是一维数组
    
   NSMutableArray* smallGroup= [NSMutableArray arrayWithArray:_arrayData [indexPath.section]];
    [smallGroup removeObjectAtIndex:indexPath.row];
    _arrayData[indexPath.section]=smallGroup;
    
    [_tableView reloadData];
}

//点击哪个单元格
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"SelectRowAtIndexPath select %ld, %ld",indexPath.section,indexPath.row);
}

//取消选择了哪个单元格
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSLog(@"DeselectRowAtIndexPath select %ld, %ld",indexPath.section,indexPath.row);
}




-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    NSString* cellStr=@"cell";
    
    //复用单于格
    UITableViewCell* cell=[_tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (cell==nil) {
//        创建一个单元格
//        P1 ：单元格样式
//        P2 ：单元格的服用标记
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
//        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                   reuseIdentifier:cellStr];
    }
    
 NSString* str=[NSString stringWithFormat:@"第%ld组,第%ld行",indexPath.section,indexPath.row];
    cell.textLabel.text=_arrayData[indexPath.section][indexPath.row];
    cell.detailTextLabel.text=@"sub title";//需要和上面的样式配合
    NSLog(@"index=%d",(NSInteger)indexPath.row%5);
    UIImage* image=[UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row%5]];
    cell.imageView.image=image;
    
    
        return cell;
}

//头部标题

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _arrayData[section][0];
}

//尾部标题
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return _arrayData[section][1];
}
//获取头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;

}

//获取尾部高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
