//
//  MyTabBarVC.swift
//  CustomTabBar
//
//  Created by 张昭 on 16/6/14.
//  Copyright © 2016年 张昭. All rights reserved.
//

import UIKit

class MyTabBarVC: UITabBarController {

    var selectBtn: UIButton!
    let myView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        creatTabBar()
        
        // 注册通知用来在需要的地方隐藏自定义的tabBar
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MyTabBarVC.hideTabBar(_:)), name: "hidetabbar", object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "hidetabbar", object: nil)
    }
    
    func hideTabBar(hidden: NSNotification) {
        
        if hidden.userInfo!["hidden"] as! String == "1" {
            myView.hidden = true
        } else {
            myView.hidden = false
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    func creatTabBar() {
        let rect = self.tabBar.frame
        
        self.tabBar.removeFromSuperview()
        myView.frame = rect
        myView.backgroundColor = UIColor.whiteColor()
        myView.alpha = 0.98
        self.view.addSubview(myView)
        
        let line = UIView.init(frame: CGRectMake(0, 0, rect.width, 0.3))
        line.backgroundColor = UIColor.redColor()
        myView.addSubview(line)
        
        
        for a in 0..<5 {
            
            let button = UIButton()
            let width = myView.frame.size.width / 5
            let x = CGFloat(a) * width
            button.frame = CGRectMake(x, 0.3, width, myView.frame.size.height)
            // 未选中
            let unSelectImage = UIImage.init(named: "icon-jia")?.imageWithRenderingMode(.AlwaysOriginal)
            button.setImage(unSelectImage, forState: .Normal)
            
            // 选中
            let selectImage = UIImage.init(named: "icon-cha")?.imageWithRenderingMode(.AlwaysOriginal)
            button.setImage(selectImage, forState: .Selected)
            
    
            button.adjustsImageWhenHighlighted = false
            myView.addSubview(button)
            button.tag = a
            button.addTarget(self, action: #selector(MyTabBarVC.onClicked(_:)), forControlEvents: .TouchUpInside)
            if a == 0 {
                button.selected = true
                self.selectBtn = button
            }
        }
    }
    func onClicked(sender: UIButton) {
        
        // 中间的button用来弹出自定义视图
        if sender.tag == 2 {
            let push = storyboard?.instantiateViewControllerWithIdentifier("push")
            self.presentViewController(push!, animated: true, completion: nil)
            return
        }
        self.selectBtn.selected = false
        sender.selected = true
        self.selectBtn = sender
        if sender.tag < 2 {
            self.selectedIndex = sender.tag
        } else {
            self.selectedIndex = sender.tag - 1
        }
        
    }

}
