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
        let accuracy = json["rightCount"].floatValue / json["allCount"].floatValue
        lb_accuracy.text = "正确率:\(accuracy)"
//        let dt = json["insertTime"].stringValue

        lb_time.text = "强仔服务器处理"
        //let st = json["status"].stringValue
        //if st == "pass" then
        
        lb_answerCount.text = json["allCount"].stringValue

    }


}
