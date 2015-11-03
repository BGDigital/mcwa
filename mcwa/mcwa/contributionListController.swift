//
//  contributionListController.swift
//  mcwa
//
//  Created by XingfuQiu on 15/10/8.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

class contributionListController: UITableViewController {

    let cellIdentifier = "contributionListCell"
    var isFirstLoad = true
    var manager = AFHTTPRequestOperationManager()
    var page: PageInfo!
    var json: JSON! {
        didSet {
            if "ok" == self.json["state"].stringValue {
                //分页信息
                page = PageInfo(j: self.json["dataObject", "pageBean"])
                
                if let d = self.json["dataObject", "data"].array {
                    if page.currentPage == 1 {
                        //                        println("刷新数据")
                        self.datasource = d
                    } else {
                        //                        println("加载更多")
                        self.datasource = self.datasource + d
                    }
                }
            }
        }
    }
    
    var datasource: Array<JSON>! = Array() {
        didSet {
            if self.datasource.count < page.allCount {
                self.tableView.footer.hidden = self.datasource.count < page.pageSize
                print("没有达到最大值 \(self.tableView.footer.hidden)")
            } else {
                print("最大值了,noMoreData")
                self.tableView.footer.endRefreshingWithNoMoreData()
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "贡献列表"
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = ""
        self.navigationItem.backBarButtonItem = barButtonItem
        
        self.tableView.header = MJRefreshNormalHeader(refreshingBlock: {self.loadNewData()})
        self.tableView.footer = MJRefreshAutoNormalFooter(refreshingBlock: {self.loadMoreData()})

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadNewData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    func loadNewData() {
        //开始刷新
        //http://221.237.152.39:8081/interface.do?act=uploadList&userId=2&page=1
        if appUserIdSave == 0 {return}
        let dict = ["act":"uploadList", "userId": appUserIdSave, "page": 1]
        manager.GET(URL_MC,
            parameters: dict,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                //println(responseObject)
                self.isFirstLoad = false
                self.json = JSON(responseObject)
                self.tableView.header.endRefreshing()
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                self.tableView.header.endRefreshing()
                MCUtils.showCustomHUD(self, aMsg: "获取数据失败", aType: .Error)
        })
    }
    
    func loadMoreData() {
        let dict = ["act":"uploadList", "userId": appUserIdSave, "page": page.currentPage+1]
        //开始刷新
        manager.GET(URL_MC,
            parameters: dict,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                //println(responseObject)
                self.json = JSON(responseObject)
                self.tableView.footer.endRefreshing()
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                self.tableView.footer.endRefreshing()
                MCUtils.showCustomHUD(self, aMsg: "获取数据失败", aType: .Error)
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (!self.datasource.isEmpty) {
            self.tableView.backgroundView = nil
            return self.datasource.count
        } else {
            if appUserLogined {
                MCUtils.showEmptyView(self.tableView, aImg: UIImage(named: "empty_data")!, aText: "什么也没有,下拉刷新试试?")
            } else {
                MCUtils.showEmptyView(self.tableView, aImg: UIImage(named: "empty_data")!, aText: "你还没有登录,请先登录")
            }
            return 0
        }
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! contributionListCell
        
        let j = self.datasource[indexPath.row] as JSON
        cell.update(j)


        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)})
    }


    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.tableView.beginUpdates()
            self.datasource.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.tableView.endUpdates()
        }    
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func uploadQuestionAction(sender: UIBarButtonItem) {
        if(appUserIdSave<=0){
            LoginViewController.showLoginViewPage(self.navigationController, delegate: nil)
        }else{
            addQuestionController.showAddQuestionPage(self.navigationController)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        MobClick.beginLogPageView("contributionListController")
    }
    override func viewWillDisappear(animated: Bool) {
        MobClick.endLogPageView("contributionListController")
        
    }
    

}
