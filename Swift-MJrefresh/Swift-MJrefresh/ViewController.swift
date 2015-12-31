//
//  ViewController.swift
//  Swift-MJrefresh
//
//  Created by huchunyuan on 15/12/31.
//  Copyright © 2015年 huchunyuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

