//
//  ViewController.swift
//  LayerDemo
//
//  Created by john on 16/5/9.
//  Copyright © 2016年 jhon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var layer:CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        创建图层
        let layer = CALayer()
//        设置图层属性
        layer.bounds = CGRectMake(0, 0, 100, 100)
        layer.cornerRadius = 50;
        layer.backgroundColor = UIColor.purpleColor().CGColor
//        显示图层
        layer.position = CGPointMake(300, 600)
//        添加图层
        self.view.layer.addSublayer(layer)
        self.layer = layer;
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(_:)))
        self.view.addGestureRecognizer(tap)

        
    }
    
    func tapClick(tapEvent:UITapGestureRecognizer) {
        print("touches")
        let secondVC = SecondViewController()
        self .presentViewController(secondVC, animated: true) { 
            print("jump suc")
        }
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.layer?.position = CGPointMake(100, 100)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

