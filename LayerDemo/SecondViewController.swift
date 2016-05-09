//
//  SecondViewController.swift
//  LayerDemo
//
//  Created by john on 16/5/9.
//  Copyright © 2016年 jhon. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
//    第二段动画中用到的背景view
    var callView:UIView?
//    作为头像占据的imageview
    var recIconView:UIImageView?
//    在正向第一向第二段动画转折时的背景view的坐标
    var oldCallFrame:CGRect?
//    在动画一开始的时候的头像的坐标
    var oldIconFrame:CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let btn = UIButton(type: .Custom)
        btn.setTitle("back", forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.backgroundColor = UIColor.magentaColor()
        btn.addTarget(self, action: #selector(backClick(_:)), forControlEvents: .TouchUpInside)
        btn.frame = CGRectMake(100, 100, 100, 50)
        self.view.addSubview(btn)
        
        self.view.backgroundColor = UIColor.lightGrayColor()
//        第二段动画中用到的背景视图的初始化
        self.callView = UIView()
//        
        self.recIconView = UIImageView(frame: CGRectMake(250, 500, 100, 100))
        self.recIconView?.backgroundColor = UIColor.purpleColor()
        self.recIconView?.layer.cornerRadius = 50
        self.recIconView?.userInteractionEnabled = true
        self.view.addSubview(self.recIconView!)
//        为了触发动画添加的点击事件
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(_:)))
        self.recIconView?.addGestureRecognizer(tap)
    }
    
    func backClick(sender:UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func tapClick(tapEvent:UITapGestureRecognizer) {
        
        print("get in")
        
        var frame = self.recIconView?.frame
//        记录下原始坐标，便于逆向过程的进行。
        self.oldIconFrame = frame!
        frame?.origin.x = 100;
        frame?.origin.y = 100;
        frame?.size.width = 120;
        frame?.size.height = 120;
        UIView .animateWithDuration(0.3, animations: { 
            self.recIconView?.frame = frame!
            self.recIconView?.layer.cornerRadius = 60
            }){
            (true) in
                let window = UIApplication.sharedApplication().keyWindow
                let winFrame = self.recIconView?.convertRect((self.recIconView?.bounds)!, toView: window)
//                第二段动画开始时的原始坐标备份
                self.oldCallFrame = winFrame!
//                背景视图开始的原始坐标的设定
                self.callView?.frame = winFrame!
                self.callView?.backgroundColor = UIColor.brownColor()
                self.callView?.alpha = 1
                self.callView?.layer.cornerRadius = 60
                window?.addSubview(self.callView!)
//                通话头像视图（这个是一个全新的头像视图，因为它是加载背景视图上面的）
                let imageView = UIImageView(frame: CGRectMake(0, 0, winFrame!.width, winFrame!.height))
                imageView.backgroundColor = UIColor.purpleColor()
                imageView.layer.cornerRadius = 60;
                imageView.tag = 10000
                self.callView?.addSubview(imageView)
    
                UIView .animateWithDuration(0.5, animations: { 
                    self.callView?.frame = self.view.frame
                    self.callView?.layer.cornerRadius = 0
                    imageView.frame = winFrame!
                    }, completion: { (true) in
//                        这里可以进行第二段动画结束之后视图的布局，这里我只是添加了一个button，当然还可以添加很多的东西
                        let button = UIButton(type: .Custom)
                        button.setTitle("fold", forState: .Normal)
                        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                        button.backgroundColor = UIColor.magentaColor()
                        button.frame = CGRectMake(10, 30, 60, 40)
                        self.callView?.addSubview(button)
                        button.addTarget(self, action: #selector(self.buttonClick(_:)), forControlEvents: .TouchUpInside)
                })
        }
    }
    
    func buttonClick(sender:UIButton) {
        let imgVC:UIImageView = self.callView?.viewWithTag(10000) as! UIImageView
        sender.removeFromSuperview()
        
        UIView.animateWithDuration(0.5, animations: { 
            self.callView?.frame = self.oldCallFrame!
            imgVC.frame = CGRectMake(0, 0, self.oldCallFrame!.width, self.oldCallFrame!.height)
            }) { (true) in
                self.callView?.removeFromSuperview()
                imgVC.removeFromSuperview()
                UIView.animateWithDuration(0.3, animations: { 
                    self.recIconView?.frame = self.oldIconFrame!
                    self.recIconView?.layer.cornerRadius = 50
                })
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
