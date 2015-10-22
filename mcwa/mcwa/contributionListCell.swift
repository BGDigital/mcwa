//
//  contributionListCell.swift
//  mcwa
//
//  Created by XingfuQiu on 15/10/21.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

class contributionListCell: UITableViewCell {

    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var lb_answerCount: UILabel!
    @IBOutlet weak var lb_accuracy: UILabel!
    @IBOutlet weak var lb_time: UILabel!
    @IBOutlet weak var iv_statusIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .None
        // Configure the view for the selected state
    }
    
    func update(json: JSON) {
        //        println(json)
        
        lb_title.text = json["title"].stringValue
        let dt = json["insertTime"].stringValue
        lb_time.text = dt
        
        //nopass(未通过) pass(通过) passing(审核中)
        let st = json["status"].stringValue
        switch st {
        case "pass":
            iv_statusIcon.image = UIImage(named: "cont_1")
            lb_answerCount.textColor = UIColor.whiteColor()
            lb_answerCount.text = json["allCount"].stringValue
            let accuracy = (json["rightCount"].floatValue / json["allCount"].floatValue) * 100
            lb_accuracy.text = "正确率:\(accuracy)"
            lb_accuracy.hidden = false
        case "passing":
            iv_statusIcon.image = UIImage(named: "cont_2")
            lb_answerCount.textColor = UIColor(hexString: "#9090C6")
            lb_answerCount.text = "审核中"
            lb_accuracy.hidden = true
        case "nopass":
            iv_statusIcon.image = UIImage(named: "cont_3")
            lb_answerCount.textColor = UIColor(hexString: "#9090C6")
            lb_answerCount.text = "未通过"
            lb_accuracy.hidden = true
        default: break
        }

    }


}
