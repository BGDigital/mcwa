//
//  rankinglistCell.swift
//  mcwa
//
//  Created by XingfuQiu on 15/10/21.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

class rankinglistCell: UITableViewCell {

    @IBOutlet weak var iv_left_bg: UIImageView!
    @IBOutlet weak var iv_Avatar: UIImageView!
    @IBOutlet weak var lb_userName: UILabel!
    @IBOutlet weak var lb_source: UILabel!
    @IBOutlet weak var lb_No: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iv_Avatar.layer.masksToBounds = true
        self.iv_Avatar.layer.cornerRadius = 20
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .None
        // Configure the view for the selected state
    }
    
    func update(json: JSON) {
        //        println(json)
        let avatar_url = json["headImg"].stringValue
        self.iv_Avatar.yy_imageURL = NSURL(string: avatar_url)
        self.lb_userName.text = json["nickName"].stringValue
        self.lb_source.text = json["allScore"].stringValue+"分"
        self.lb_No.text = json["scoreRank"].stringValue
        if lb_No.text == "1" {
            self.iv_left_bg.backgroundColor = UIColor(hexString: "#5BB524")
        } else {
            self.iv_left_bg.backgroundColor = UIColor(hexString: "#8581C7")
        }
    }

}
