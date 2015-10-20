//
//  doWorkViewController.swift
//  mcwa
//
//  Created by XingfuQiu on 15/10/15.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

class doWorkViewController: UIViewController {

    var countDownTimer: NSTimer?
    var countDownNum: Float = 100      //到计时时间 10秒
    var currentQuestion: Int = 0  //当前做到的题目Idx
    var rightAnswer: String?      //当前题目的正确答案
    var rightBtn: UIButton?
    var questionSource: Int?      //当前题目的分数
    var totalSource: Int = 0      //总得分
    var questions: Array<JSON>?   //题目数组
    let arrAnswer = ["answerOne":1, "answerTwo":2, "answerThree":3, "answerFour":4]

    @IBOutlet weak var lb_addSource: UILabel!
    @IBOutlet weak var lb_Source: UILabel!
    @IBOutlet weak var iv_avatar: UIImageView!
    @IBOutlet weak var lb_time: UILabel!
    @IBOutlet weak var lb_contributionUser: UILabel!
    @IBOutlet weak var lb_Ques_Title: UILabel!
    @IBOutlet weak var v_Ques_Image: UIView!
    @IBOutlet weak var iv_Ques_Image: UIImageView!
    @IBOutlet weak var btn_Ques_One: UIButton!
    @IBOutlet weak var btn_Ques_Two: UIButton!
    @IBOutlet weak var btn_Ques_Three: UIButton!
    @IBOutlet weak var btn_Ques_Four: UIButton!
    @IBOutlet weak var co_Ques_One: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lb_addSource.hidden = true
        lb_Source.text = "0"
    }
    
    override func viewDidAppear(animated: Bool) {
        self.refresh(currentQuestion)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //传消息到下一个界面
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //
    }
    
    //加载/刷新界面
    func refresh(Idx: Int) {
        if let singleQuestion = self.questions?[Idx] {
            
            rightBtn = nil
            rightAnswer = ""
            
            v_Ques_Image.hidden = true
            btn_Ques_One.hidden = false
            btn_Ques_Two.hidden = false
            btn_Ques_Three.hidden = false
            btn_Ques_Four.hidden = false
            
            btn_Ques_One.tag = 0
            btn_Ques_Two.tag = 0
            btn_Ques_Three.tag = 0
            btn_Ques_Four.tag = 0
            
            btn_Ques_One.backgroundColor = UIColor(hexString: "#676598")
            btn_Ques_Two.backgroundColor = UIColor(hexString: "#676598")
            btn_Ques_Three.backgroundColor = UIColor(hexString: "#676598")
            btn_Ques_Four.backgroundColor = UIColor(hexString: "#676598")
            
            let questionType = singleQuestion["questionType"].stringValue
            rightAnswer = singleQuestion["rightAnswer"].stringValue
            lb_Ques_Title.text = singleQuestion["title"].stringValue
            questionSource = singleQuestion["score"].intValue
            //是否显示图片
            if let icon = singleQuestion["icon"].string  {
                //有图
                print("有图")
                v_Ques_Image.hidden = false
                self.co_Ques_One.constant = 10
                iv_Ques_Image.sd_setImageWithURL(NSURL(string: icon), placeholderImage: UIImage(named: "test"))
            } else {
                print("无图")
                v_Ques_Image.hidden = true
                self.co_Ques_One.constant = -v_Ques_Image.bounds.size.height
            }

            //题目类型
            if questionType == "judge" {
                //判断题目
                btn_Ques_One.setTitle("对", forState: .Normal)
                btn_Ques_Two.setTitle("错", forState: .Normal)
                btn_Ques_Three.hidden = true
                btn_Ques_Four.hidden = true
                
                if rightAnswer == "对" {
                    btn_Ques_One.tag = 1
                    rightBtn = btn_Ques_One
                } else {
                    btn_Ques_Two.tag = 1
                    rightBtn = btn_Ques_Two
                }
            } else {
                //选择题目
                for (name, btnidx) in arrAnswer {
                    let answer = singleQuestion[name].stringValue
                    switch btnidx {
                    case 1:
                        if answer == rightAnswer {
                            btn_Ques_One.tag = 1
                            rightBtn = btn_Ques_One
                        }
                        btn_Ques_One.setTitle(answer, forState: .Normal)
                    case 2:
                        if answer == rightAnswer {
                            btn_Ques_Two.tag = 1
                            rightBtn = btn_Ques_Two
                        }
                        btn_Ques_Two.setTitle(answer, forState: .Normal)
                    case 3:
                        if answer == rightAnswer {
                            btn_Ques_Three.tag = 1
                            rightBtn = btn_Ques_Three
                        }
                        btn_Ques_Three.setTitle(answer, forState: .Normal)
                    case 4:
                        if answer == rightAnswer {
                            btn_Ques_Four.tag = 1
                            rightBtn = btn_Ques_Four
                        }
                        btn_Ques_Four.setTitle(answer, forState: .Normal)
                    default:
                        print("加载答案失败")
                    }
                    
                }
            }
            self.lb_contributionUser.text = "贡献者:"+singleQuestion["authorName"].stringValue
            
            //这里应该要等一下,有个加载过程
            
            //开始倒计时
//            countDownNum = 100
            countDownNum = 50
            //做题目倒计时
            self.countDownTimer = NSTimer.new(every: 0.1.second, { () -> Void in
                self.countDownNum--
                if self.countDownNum <= 40 {
                    self.lb_time.textColor = UIColor.redColor()
                } else {
                    self.lb_time.textColor = UIColor.whiteColor()
                }
                self.lb_time.text = "\(self.countDownNum / 10)"
                
                //时间到了,没有选出答案,取下一到题目
                if self.countDownNum == 0 {
                    self.countDownTimer?.invalidate()
                    
                    self.currentQuestion++
                    print(self.currentQuestion)
                    if self.currentQuestion < self.questions?.count {
                        self.refresh(self.currentQuestion)
                    } else {
                        print("做完了,自动!")
                        print("做完,总计得分:\(self.totalSource)")
                        self.performSegueWithIdentifier("showSource", sender: self)
                    }
                }
            })
            self.countDownTimer?.start()
        }
    }
    
    //用户做的题目
    @IBAction func chooseAnswer(sender: UIButton) {
        //点了按钮,先停计时器
        self.countDownTimer?.invalidate()
        //判断对错,颜色区分
        if (sender.tag == 1) {
            //回答正确,加分
            sender.backgroundColor = UIColor(hexString: "#5BB524")
            self.totalSource  = self.totalSource + self.questionSource!
            
            self.lb_Source.text = "\(self.totalSource)"
            self.lb_addSource.text = "+\(self.questionSource!)"
            self.lb_addSource.hidden = false
            
        } else {
            //回答错误,不加分
            sender.backgroundColor = UIColor.redColor()
            //显示正确答案
            rightBtn?.backgroundColor = UIColor(hexString: "#5BB524")
        }
        //刷新题目,准备下一题
        NSTimer.after(2) { () -> Void in
            self.currentQuestion++
            print(self.currentQuestion)
            if self.currentQuestion < self.questions?.count {
                self.lb_addSource.hidden = true
                self.refresh(self.currentQuestion)
            } else {
                print("做完啦,手动")
                print("做完,总计得分:\(self.totalSource)")
                
                self.performSegueWithIdentifier("showSource", sender: self)
            }
        }
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
