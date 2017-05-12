//
//  ViewController.h
//  DelegateDemo
//
//  Created by 融易乐 on 2017/5/9.
//  Copyright © 2017年 融易乐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<
//实现数据视图的普通协议
UITableViewDelegate,
//实现数据视图的数据代理协议
UITableViewDataSource
>

{
//    定义一个谁识图对象（用来显示大量相同格式的大量信息的视图）
    UITableView* _tableView;
    NSMutableArray* _arrayData;
    
//    导航按钮
    UIBarButtonItem* _btnEdit;
    UIBarButtonItem* _btnFInish;
    UIBarButtonItem* _btnDel;
//   是否处于编辑状态
    BOOL _isEdit;
    
    NSArray* _imageArray;
    
}
@end

