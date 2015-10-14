//
//  rankinglistController.swift
//  mcwa
//
//  Created by XingfuQiu on 15/10/10.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

class rankinglistController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "排行榜"
        self.view.layer.contents = UIImage(named: "other_bg")!.CGImage

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("rankinglistCell", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 56))
        headView.backgroundColor = UIColor(hexString: "#362259")
        //添加排名图片
        let img_rankNo = UIImageView(frame: CGRectMake(8, 0, 40, 56))
        img_rankNo.image = UIImage(named: "ready_bg")
        headView.addSubview(img_rankNo)
        //添加用户头像
        let img_Avatar = UIImageView(frame: CGRectMake(56, 8, 40, 40))
        img_Avatar.image = UIImage(named: "ready_bg")
        headView.addSubview(img_Avatar)
        //添加用户名称
        let lb_userName = UILabel(frame: CGRectMake(104, 18, 186, 21))
        lb_userName.textColor = UIColor.whiteColor()
        lb_userName.text = "萌萌哒的小仙仙"
        headView.addSubview(lb_userName)
        //添加用户分数
        let lb_userSource = UILabel(frame: CGRectMake(tableView.bounds.size.width - 75, 18, 71, 21))
        lb_userSource.textColor = UIColor.whiteColor()
        lb_userSource.text = "1234 分"
        headView.addSubview(lb_userSource)
        return headView
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

}
