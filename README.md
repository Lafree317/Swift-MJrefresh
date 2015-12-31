# Swift-MJrefresh
swift调用李明杰的上拉刷新和下拉刷新
#前言
本篇文章较为基础,只是为了让新手尽快熟悉swift下的一些操作

最近用swift写项目的公司越来越多了,对于Swift的第三方库的需求也越来越多了,我用了半个小事整理出了Swift语言如何调用MJ的刷新并分享出来
主要看一下Swfit如何调用cocoaPods里的第三方库,和Swift初始化OC对象的方法
#上代码
###先导入CocoaPods
- $ cd 文件路径
- $ vim Podifle
 - 按I进入编辑模式
 - 文本里输入 pod 'MJRefresh'
 - 按ESC然后输入:wq
- $ pod install

![成功效果图](http://upload-images.jianshu.io/upload_images/1298596-24d7502c1918197d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###创建一个Header文件

![Header.h](http://upload-images.jianshu.io/upload_images/1298596-bfdf27b0edbbb06c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###Header.h里面关联头文件
```
#ifndef Header_h
#define Header_h

#import "MJRefresh.h"

#endif /* Header_h */
```

###在Build Settings里的Objective-C Bridging Header里加入Header.h的文件路径

![BuildSettings里添加Header.h的路径](http://upload-images.jianshu.io/upload_images/1298596-42bb60a4b0160805.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: Selector("headerRefresh"))
        // 现在的版本要用mj_header
        self.tableview.mj_header = header
        
        // 上拉刷新
        footer.setRefreshingTarget(self, refreshingAction: Selector("footerRefresh"))
        self.tableview.mj_footer = footer
        
    }
    
    // 顶部刷新
    func headerRefresh(){
        print("下拉刷新")
        // 结束刷新
        self.tableview.mj_header.endRefreshing()
    }
    
    // 底部刷新
    var index = 0
    func footerRefresh(){
        print("上拉刷新")
        self.tableview.mj_footer.endRefreshing()
        // 2次后模拟没有更多数据
        index = index + 1
        if index > 2 {
            footer.endRefreshingWithNoMoreData()
        }
    }
    
    // 区数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    // 行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    // cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "a")
        cell.textLabel!.text = "测试刷新"
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150;
    }
}
```
#效果图


![Swift-Mjrefresh.gif](http://upload-images.jianshu.io/upload_images/1298596-b7bd133b22acf456.gif?imageMogr2/auto-orient/strip)
