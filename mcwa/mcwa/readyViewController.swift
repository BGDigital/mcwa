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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionTa.backgroundColor = UIColor.clearColor()
        self.collectionTa.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        let iv = UIImageView(frame: CGRectMake(0, 0, 30, 30))
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
