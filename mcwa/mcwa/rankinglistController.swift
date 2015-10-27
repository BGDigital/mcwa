//
//  rankinglistController.swift
//  mcwa
//
//  Created by XingfuQiu on 15/10/10.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

class rankinglistController: UITableViewController {
    
    let cellIdentifier = "rankinglistCell"
    var isFirstLoad = true
    var manager = AFHTTPRequestOperationManager()
    var page: PageInfo!
    var json: JSON! {
        didSet {
            if "ok" == self.json["state"].stringValue {
                page = PageInfo(j: self.json["dataObject", "list", "pageBean"])
                if let d = self.json["dataObject", "list", "data"].array {
                    if page.currentPage == 1 {
                        //                        println("刷新数据")
                        self.datasource = d
                    } else {
                        //                        println("加载更多")
                        self.datasource = self.datasource + d
                    }
                }
                //个人信息
                self.user = self.json["dataObject", "user"]
            }
        }
    }
    var user: JSON?
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
        self.navigationItem.title = "排行榜"
        self.view.layer.contents = UIImage(named: "other_bg")!.CGImage
        
        self.tableView.header = MJRefreshNormalHeader(refreshingBlock: {self.loadNewData()})
        self.tableView.footer = MJRefreshAutoNormalFooter(refreshingBlock: {self.loadMoreData()})

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        if isFirstLoad {
            loadDataWithoutMJRefresh()
        }
    }
    
    func loadDataWithoutMJRefresh() {
//        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//        hud?.labelText = MCUtils.TEXT_LOADING
        loadNewData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadNewData() {
        //开始刷新
        //http://221.237.152.39:8081/interface.do?act=rankList&userId=1&page=1
        let dict = ["act":"rankList", "userId": appUserIdSave, "page": 1]
        manager.GET(URL_MC,
            parameters: dict,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                //println(responseObject)
                self.isFirstLoad = false
                self.json = JSON(responseObject)
                self.tableView.header.endRefreshing()
//                self.hud?.hide(true)
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                //                println("Error: " + error.localizedDescription)
                self.tableView.header.endRefreshing()
//                self.hud?.hide(true)
                MCUtils.showCustomHUD("数据加载失败", aType: .Error)
        })
    }
    
    func loadMoreData() {
        //        println("开始加载\(self.page.currentPage+1)页")
        let dict = ["act":"rankList", "userId": appUserIdSave, "page": page.currentPage+1]
        //println("加载:\(self.liveType),\(self.liveOrder)======")
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
                //                println("Error: " + error.localizedDescription)
                self.tableView.footer.endRefreshing()
                MCUtils.showCustomHUD("数据加载失败", aType: .Error)
        })
    }

    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (!self.datasource.isEmpty) {
//            self.tableView.backgroundView = nil
            return self.datasource.count
        } else {
//            MCUtils.showEmptyView(self.tableView, aImg: Load_Empty!, aText: "什么也没有,下拉刷新试试?")
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! rankinglistCell
        
        // Configure the cell
        let j = self.datasource[indexPath.row] as JSON
        cell.update(j)

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if appUserIdSave > 0 {
            return 56
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (self.user == nil)
        {
            return nil
        } else {
            if appUserIdSave > 0 {
                let headView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 56))
                headView.backgroundColor = UIColor(hexString: "#2C1B49")
                //我的排名前面那个No.
                let lb_no = UILabel(frame: CGRectMake(14, 8, 30, 17))
                lb_no.textAlignment = .Center
                lb_no.font = UIFont(name: lb_no.font.fontName, size: 13)
                lb_no.textColor = UIColor.whiteColor()
                lb_no.text = "No."
                headView.addSubview(lb_no)
                //我的排名
                let lb_rankNo = UILabel(frame: CGRectMake(12, 25, 33, 24))
                lb_rankNo.textAlignment = .Center
                lb_rankNo.font = UIFont(name: lb_rankNo.font.fontName, size: 20)
                lb_rankNo.textColor = UIColor.whiteColor()
                lb_rankNo.text = self.user!["scoreRank"].stringValue
                headView.addSubview(lb_rankNo)
                //添加用户头像
                let img_Avatar = UIImageView(frame: CGRectMake(56, 8, 40, 40))
                let avater_Url = self.user!["headImg"].stringValue
                print(avater_Url)
                img_Avatar.sd_setImageWithURL(NSURL(string: avater_Url))
                img_Avatar.layer.masksToBounds = true
                img_Avatar.layer.cornerRadius = 20
                headView.addSubview(img_Avatar)
                //添加用户名称
                let lb_userName = UILabel(frame: CGRectMake(104, 18, 186, 21))
                lb_userName.textColor = UIColor.whiteColor()
                lb_userName.text = "自己"//self.user!["nickName"].stringValue
                headView.addSubview(lb_userName)
                //添加用户分数
                let lb_userSource = UILabel(frame: CGRectMake(tableView.bounds.size.width - 74, 18, 71, 21))
                lb_userSource.textColor = UIColor.whiteColor()
                lb_userSource.textAlignment = .Center
                lb_userSource.text = self.user!["allScore"].stringValue+" 分"
                headView.addSubview(lb_userSource)
                return headView
            } else {
                return nil
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
    
    override func viewWillAppear(animated: Bool) {
        MobClick.beginLogPageView("rankinglistController")
    }
    override func viewWillDisappear(animated: Bool) {
        MobClick.endLogPageView("rankinglistController")
        
    }

}
