//
//   addQuestionController.swift
//  mcwa
//
//  Created by 陈强 on 15/10/13.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//


import UIKit

class  addQuestionController: UIViewController,UITextFieldDelegate,UMSocialUIDelegate,DBCameraViewControllerDelegate,UITextViewDelegate {
    var manager = AFHTTPRequestOperationManager()
    
    @IBOutlet weak var segmentedbtn: UISegmentedControl!
    
    @IBOutlet weak var oneUploadBtn: UIButton!
    @IBOutlet weak var twoUploadBtn: UIButton!
    @IBOutlet weak var answerSegment: UISegmentedControl!
    @IBOutlet weak var titleView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageBtn: UIImageView!
    var textView:UITextView!
    var containerView:UIView!
    var cancleButton:UIButton!
    var sendButton:UIButton!
    var lableView:UILabel!
    
    @IBOutlet weak var oneView: UIView!
    @IBOutlet weak var twoView: UIView!
    
    @IBOutlet weak var threeView: UIView!
    @IBOutlet weak var fourView: UIView!
    @IBOutlet weak var answerOne: UILabel!
    @IBOutlet weak var answerTwo: UILabel!
    @IBOutlet weak var answerThree: UILabel!
    @IBOutlet weak var answerFour: UILabel!
    var answerFlag:Int = 1
    
    var questionType:String! = "选择题"
    var reallyAnswer:String! = "正确"
    var icon:UIImage!
    
    var type:String!
    var answerTitle:String! = ""
    var one:String! = ""
    var two:String! = ""
    var three:String! = ""
    var four:String! = ""
    var iconValue:String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.leftBarButtonItem?.title = ""
        self.titleView.tag = 10
        self.titleView.delegate = self
        self.view.userInteractionEnabled = true
        self.scrollView.userInteractionEnabled = true
        self.answerSegment.hidden = true
        self.twoUploadBtn.hidden = true
        self.navigationItem.title = "出题"
        
//        imageView.layer.borderWidth = 5.0
//        imageView.layer.borderColor = UIColor(patternImage: UIImage(named:"DotedImage.png")!).CGColor
//        let attributes = [NSForegroundColorAttributeName:UIColor(red: 0.329, green: 0.318, blue: 0.518, alpha: 1.00) ]
//        segmentedBtn.setTitleTextAttributes(attributes, forState: UIControlState.Normal)
//        let highlightedAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
//        segmentedBtn.setTitleTextAttributes(highlightedAttributes, forState: UIControlState.Selected)
        self.navigationItem.title = "出题"
//        one = UITextField(frame: CGRectMake(0, 100, 300, 100))
//        one.backgroundColor = UIColor.whiteColor()
//        one.font = UIFont.systemFontOfSize(40)
//        one.delegate = self
//        self.view.addSubview(one)
//        

        
//        segmentedControl = HMSegmentedControl(sectionTitles: kindsArray)
//        segmentedControl.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 40)
//        segmentedControl.backgroundColor = UIColor.blueColor()
//        segmentedControl.tintColor = UIColor.redColor()
//        segmentedControl.textColor = UIColor(red: 0.694, green: 0.694, blue: 0.694, alpha: 1.00)
//        segmentedControl.selectedTextColor = UIColor(red: 0.255, green: 0.788, blue: 0.298, alpha: 1.00)
//        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone
//        segmentedControl.addTarget(self, action: "segmentSelected:", forControlEvents: UIControlEvents.ValueChanged)
//        self.view.addSubview(segmentedControl)
        initSegmented()
        initAddImage()
        initReplyBar();
//        initTextField()
        initView();
        
    }
    
    func initView(){
        self.textView.delegate = self
        oneView.userInteractionEnabled = true
        let oneTapGR = UITapGestureRecognizer(target: self, action: "oneQuestionAction:")
        oneView.addGestureRecognizer(oneTapGR)
        
        twoView.userInteractionEnabled = true
        let twoTapGR = UITapGestureRecognizer(target: self, action: "twoQuestionAction:")
        twoView.addGestureRecognizer(twoTapGR)
        
        threeView.userInteractionEnabled = true
        let threeTapGR = UITapGestureRecognizer(target: self, action: "threeQuestionAction:")
        threeView.addGestureRecognizer(threeTapGR)
        
        fourView.userInteractionEnabled = true
        let fourTapGR = UITapGestureRecognizer(target: self, action: "fourQuestionAction:")
        fourView.addGestureRecognizer(fourTapGR)
    }
    
    func oneQuestionAction(sender:UITapGestureRecognizer) {
        self.containerView.alpha = 1
        answerFlag = 1
        self.textView.text = ""
        self.textView.becomeFirstResponder()
    }
    func twoQuestionAction(sender:UITapGestureRecognizer) {
        self.containerView.alpha = 1
        answerFlag = 2
        self.textView.text = ""
        self.textView.becomeFirstResponder()
    }
    func threeQuestionAction(sender:UITapGestureRecognizer) {
        self.containerView.alpha = 1
        answerFlag = 3
        self.textView.text = ""
        self.textView.becomeFirstResponder()
    }
    func fourQuestionAction(sender:UITapGestureRecognizer) {
        self.containerView.alpha = 1
        answerFlag = 4
        self.textView.text = ""
        self.textView.becomeFirstResponder()
    }
    func initReplyBar() {
        self.containerView = UIView(frame: CGRectMake(0, self.view.bounds.height, self.view.bounds.width, 110))
        self.containerView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.00)
        
        self.cancleButton = UIButton(frame: CGRectMake(5, 5, 50, 30))
        self.cancleButton.setTitle("取消", forState: UIControlState.Normal)
        self.cancleButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        self.cancleButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        self.cancleButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.cancleButton.addTarget(self, action: "cancleReply", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.sendButton = UIButton(frame: CGRectMake(self.containerView.frame.size.width-5-50, 5, 50, 30))
        self.sendButton.setTitle("确定", forState: UIControlState.Normal)
        self.sendButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        self.sendButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        self.sendButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.sendButton.addTarget(self, action: "sendReply", forControlEvents: UIControlEvents.TouchUpInside)
        self.lableView = UILabel(frame: CGRectMake((self.containerView.frame.size.width)/2-40, 5, 80, 30))
        self.lableView.text = "限制10字"
        self.lableView.textAlignment = NSTextAlignment.Center
        self.lableView.textColor = UIColor.grayColor()
        
        self.textView = UITextView(frame: CGRectMake(15, 50, self.containerView.frame.size.width-30, 40))
        self.textView.delegate = self
        textView.layer.borderColor = UIColor.grayColor().CGColor;
        textView.layer.borderWidth = 1;
        textView.layer.cornerRadius = 6;
        textView.layer.masksToBounds = true;
        textView.userInteractionEnabled = true;
        textView.font = UIFont.systemFontOfSize(18)
        textView.scrollEnabled = true;
        textView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        let tapDismiss = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapDismiss)
        self.scrollView.addGestureRecognizer(tapDismiss)
        
        self.containerView.addSubview(self.cancleButton)
        self.containerView.addSubview(self.lableView)
        self.containerView.addSubview(self.sendButton)
        self.containerView.addSubview(self.textView)
        self.view.addSubview(containerView)
        self.containerView.alpha = 0
    }
    
    
    func textViewDidBeginEditing(textView: UITextView) {
        if(textView.tag == 10){
            if(textView.text == "   这里写题目"){
                textView.text = ""
            }
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        textView.scrollRangeToVisible(textView.selectedRange)
    }
    
    
    func textViewDidEndEditing(textView: UITextView) {
        if(textView.tag == 10){
            if(textView.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == ""){
                textView.text = "   这里写题目"
            }
        }
    }
    
    func keyboardDidShow(notification:NSNotification) {
        
        self.view.bringSubviewToFront(containerView)
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let v : NSValue = userInfo.objectForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        
        let keyHeight = v.CGRectValue().size.height
        let duration = userInfo.objectForKey(UIKeyboardAnimationDurationUserInfoKey) as! NSNumber
        let curve:NSNumber = userInfo.objectForKey(UIKeyboardAnimationCurveUserInfoKey) as! NSNumber
        let temp:UIViewAnimationCurve = UIViewAnimationCurve(rawValue: curve.integerValue)!
        UIView.animateWithDuration(duration.doubleValue, animations: {
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationCurve(temp)
            
            self.containerView.frame = CGRectMake(0, self.view.frame.size.height-keyHeight-110, self.view.bounds.size.width, 110)
            
        })
        
    }
    
    func keyboardDidHidden(notification:NSNotification) {
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.25)
        self.containerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.bounds.size.width, 110)
        self.containerView.alpha = 0
        
        UIView.commitAnimations()
    }

    func dismissKeyboard(){
        self.textView.resignFirstResponder()
        self.titleView.resignFirstResponder()
    }
    func cancleReply() {
        self.textView.resignFirstResponder()
    }
    
    func sendReply() {
        let answer:String! = self.textView.text
        if(answer.characters.count > 10 || answer!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == ""){
            MCUtils.showCustomHUD("不能为空或者超过最大字数限制", aType: .Error)
        }else{
            if(answerFlag == 1){
                self.answerOne.text = answer
            }else if(answerFlag == 2){
                self.answerTwo.text = answer
            }else if(answerFlag == 3){
                self.answerThree.text = answer
            }else if(answerFlag == 4){
                self.answerFour.text = answer
            }
            dismissKeyboard()
        }
    }

//    func initTextField(){
//        print(self.imageBtn.frame.origin.y)
//        one = UITextField(frame: CGRectMake(0, 800, 300, 300))
//        one.borderStyle = UITextBorderStyle.None
//        one.backgroundColor = UIColor.redColor()
//        self.scrollView.addSubview(one)
//    }
    
    func initAddImage() {
        imageBtn.userInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: "tapHandler:")
        imageBtn.addGestureRecognizer(tapGR)
    }
    func tapHandler(sender:UITapGestureRecognizer) {
        let cameraContainer:DBCameraContainerViewController = DBCameraContainerViewController(delegate: self)
        cameraContainer.delegate = self
        cameraContainer.setFullScreenMode()
        let nav:UINavigationController = UINavigationController(rootViewController: cameraContainer)
        nav.navigationBarHidden = true
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    func camera(cameraViewController: AnyObject!, didFinishWithImage image: UIImage!, withMetadata metadata: [NSObject : AnyObject]!) {
        imageBtn.image = image
        icon = image
//        self.icon = image
        cameraViewController.restoreFullScreenMode()
        self.presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dismissCamera(cameraViewController: AnyObject!) {
        self.presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
        cameraViewController.restoreFullScreenMode()
    }
    


    
    func initSegmented() {
        let attributes = [NSForegroundColorAttributeName:UIColor(red: 0.329, green: 0.318, blue: 0.518, alpha: 1.00) ]
        segmentedbtn.setTitleTextAttributes(attributes, forState: UIControlState.Normal)
        let highlightedAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        segmentedbtn.setTitleTextAttributes(highlightedAttributes, forState: UIControlState.Selected)
        
        
        answerSegment.setTitleTextAttributes(attributes, forState: UIControlState.Normal)
        answerSegment.setTitleTextAttributes(highlightedAttributes, forState: UIControlState.Selected)
        
    }
    @IBAction func answerSegmentAction(sender: UISegmentedControl) {
        reallyAnswer = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)
    }
    @IBAction func segmentedAction(sender: UISegmentedControl) {
        questionType = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)
        if(sender.selectedSegmentIndex == 0){
            self.oneView.hidden = false
            self.twoView.hidden = false
            self.threeView.hidden = false
            self.fourView.hidden = false
            self.oneUploadBtn.hidden = false
            
            self.twoUploadBtn.hidden = true
            self.answerSegment.hidden = true
        }else if(sender.selectedSegmentIndex == 1){
            self.oneView.hidden = true
            self.twoView.hidden = true
            self.threeView.hidden = true
            self.fourView.hidden = true
            self.oneUploadBtn.hidden = true
            
            self.twoUploadBtn.hidden = false
            self.answerSegment.hidden = false
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func shareFunction(sender: UIButton) {
        let shareImg: UIImage! = UIImage(named: "share_default")
        let shareText:String! = "jdskfjlskdjflkdsjflkdjf"
        
        ShareUtil.shareInitWithTextAndPicture(self, text: shareText, image: shareImg!,shareUrl:"http://www.baidu.com", callDelegate: self)
    }
    
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        if(response.responseCode == UMSResponseCodeSuccess) {
            
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        MobClick.beginLogPageView("addQuestion")
        //        //注册键盘通知事件
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHidden:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        MobClick.endLogPageView("addQuestion")
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    @IBAction func addQuestionAction(sender: UIButton) {
        self.oneUploadBtn?.enabled = false
        self.twoUploadBtn?.enabled = false
        self.type = "choice"
        self.answerTitle = self.titleView.text
        self.one = self.answerOne.text
        self.two = self.answerTwo.text
        self.three = self.answerThree.text
        self.four = self.answerFour.text
        
        if(answerTitle.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" || answerTitle == "   这里写题目"){
            print("题目不能为空,必填项")
            MCUtils.showCustomHUD("题目不能为空,必填项", aType: .Error)
            return
        }
        if(answerTitle.characters.count > 50){
            print("题目字数不能超过50字")
            MCUtils.showCustomHUD("题目字数不能超过50字", aType: .Error)
            return
        }
        
        if(self.questionType == "判断题"){
            self.one = reallyAnswer
            self.type = "judge"
        }else{
            if(one!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" || one == "正确答案"){
                print("答案不能为空,必填项")
                MCUtils.showCustomHUD("答案不能为空,必填项", aType: .Error)
                return
            }
            if(two!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" || two == "错误答案"){
                print("答案不能为空,必填项")
                MCUtils.showCustomHUD("答案不能为空,必填项", aType: .Error)
                return
            }
            if(three!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" || three == "错误答案"){
                print("答案不能为空,必填项")
                MCUtils.showCustomHUD("答案不能为空,必填项", aType: .Error)
                return
            }
            if(four!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" || four == "错误答案"){
                print("答案不能为空,必填项")
                MCUtils.showCustomHUD("答案不能为空,必填项", aType: .Error)
                return
            }
        }
        
        if(self.icon != nil){
            manager.POST(upload_url,
                parameters:nil,
                constructingBodyWithBlock: { (formData:AFMultipartFormData!) in
                    let key = "fileIcon"
                    let value = "fileNameIcon.jpg"
                    let imageData = UIImageJPEGRepresentation(self.icon, 0.0)
                    formData.appendPartWithFileData(imageData, name: key, fileName: value, mimeType: "image/jpeg")
                },
                success: { (operation: AFHTTPRequestOperation!,
                    responseObject: AnyObject!) in
                    var json = JSON(responseObject)
                    if "ok" == json["state"].stringValue {
                        self.iconValue = json["dataObject"].stringValue
                        self.postTalkToServer()
                    }else{
                        self.oneUploadBtn?.enabled = true
                        self.twoUploadBtn?.enabled = true
                        MCUtils.showCustomHUD("图片上传失败,请稍候再试", aType: .Error)
                    }
                    
                },
                failure: { (operation: AFHTTPRequestOperation!,
                    error: NSError!) in
                    self.oneUploadBtn?.enabled = true
                    self.twoUploadBtn?.enabled = true
                    MCUtils.showCustomHUD("图片上传失败,请稍候再试", aType: .Error)
            })

        }else{
            self.postTalkToServer()
        }
    }
    
    func postTalkToServer() {

            let params = [
                "authorId":String(appUserIdSave),
                "authorName":String(appUserNickName),
                "questionType":self.type,
                "title":self.answerTitle,
                "icon":self.iconValue,
                "answerOne":self.one,
                "answerTwo":self.two,
                "answerThree":self.three,
                "answerFour":self.four
            ]

        
        self.manager.POST(addTalk_url,
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                var json = JSON(responseObject)
                
                if "ok" == json["state"].stringValue {
                    self.oneUploadBtn?.enabled = true
                    self.twoUploadBtn?.enabled = true
                    //                                    NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "returnPage", userInfo: nil, repeats: false)
                    MCUtils.showCustomHUD("提交成功,返回查看", aType: .Success)
                }else{
                    self.oneUploadBtn?.enabled = true
                    self.twoUploadBtn?.enabled = true
                    MCUtils.showCustomHUD("提交失败,请稍候再试", aType: .Error)
                }
                
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                self.oneUploadBtn?.enabled = true
                self.twoUploadBtn?.enabled = true
                MCUtils.showCustomHUD("提交失败,请稍候再试", aType: .Error)
        })
    }
    
    
    class func showAddQuestionPage(fromNavigation:UINavigationController?){
        let addQuestion = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("addQuestion") as! addQuestionController
        if (fromNavigation != nil) {
            fromNavigation?.pushViewController(addQuestion, animated: true)
        } else {
            fromNavigation?.presentViewController(addQuestion, animated: true, completion: nil)
        }
        
    }
    

    
    
}