//
//  readyViewController.swift
//  mcwa
//
//  Created by XingfuQiu on 15/10/14.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

class readyViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionTa: UICollectionView!
    
    var countDownNum = 3
    var countDownTimer: NSTimer?
    var questions: Array<JSON>?
    var users: Array<JSON>?

    
    @IBOutlet weak var lb_countDown: UILabel!
    @IBOutlet weak var lb_S: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "准备"
        self.collectionTa.backgroundColor = UIColor.clearColor()
        self.collectionTa.dataSource = self

        //开始倒计时
        //self.countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "run", userInfo: nil, repeats: true)
        self.countDownTimer = NSTimer.new(every:1, { () -> Void in
                self.countDownNum--
                self.lb_countDown.text = "\(self.countDownNum)"
                print(self.countDownNum)
            if self.countDownNum == 0 {
                self.countDownTimer?.invalidate()
                self.lb_S.hidden = true
                self.lb_countDown.text = "GO!"
                
                //跳转到做题界面
                self.performSegueWithIdentifier("doWork", sender: self)
            }
        })
        
        self.countDownTimer?.start()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func run() {
//        self.countDownNum--
//        self.lb_countDown.text = "\(self.countDownNum)"
//        if countDownNum == 0 {
//            self.countDownTimer?.invalidate()
//            
//            self.lb_S.hidden = true
//            self.lb_countDown.text = "GO!"
//            
//            //跳转到做题界面
//            //let doWork = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("doWorkViewController") as! doWorkViewController
//            //self.navigationController?.presentViewController(doWork, animated: true, completion: nil)
//            //方法2
//            self.performSegueWithIdentifier("doWork", sender: self)
//        }
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "doWork" {
            let receive = segue.destinationViewController as! doWorkViewController
            receive.questions = self.questions
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = self.users?.count {
            return count
        } else{
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let Identifier = "taCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Identifier, forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor()
        
        let iv = UIImageView(frame: cell.bounds)
        print(iv.bounds)
        iv.layer.cornerRadius = iv.bounds.size.height / 2
        iv.layer.masksToBounds = true
        iv.sd_setImageWithURL(NSURL(string: self.users![indexPath.row]["headImg"].stringValue))
        
        cell.addSubview(iv)
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(animated: Bool) {
        MobClick.beginLogPageView("readyViewController")
    }
    override func viewWillDisappear(animated: Bool) {
        MobClick.endLogPageView("readyViewController")
        
    }

}
