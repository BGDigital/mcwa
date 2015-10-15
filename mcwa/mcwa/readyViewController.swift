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
    
    let ta = ["test", "test", "test", "test", "test", "test"]
    var countDownTimer: NSTimer?
    var countDownNum = 10
    
    @IBOutlet weak var lb_countDown: UILabel!
    @IBOutlet weak var lb_S: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "准备"
        self.collectionTa.backgroundColor = UIColor.clearColor()
        self.collectionTa.dataSource = self

        //开始倒计时
        self.countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "run", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func run() {
        self.countDownNum--
        self.lb_countDown.text = "\(self.countDownNum)"
        if countDownNum == 0 {
            self.countDownTimer?.invalidate()
            
            self.lb_S.hidden = true
            self.lb_countDown.text = "GO!"
            
            //跳转到做题界面
            //let doWork = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("doWorkViewController") as! doWorkViewController
            //self.navigationController?.presentViewController(doWork, animated: true, completion: nil)
            //方法2
            self.performSegueWithIdentifier("doWork", sender: self)
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ta.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let Identifier = "taCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Identifier, forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor()
        
        let iv = UIImageView(frame: cell.bounds)
        iv.image = UIImage(named: ta[indexPath.row])
        iv.layer.cornerRadius = 15
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

}
