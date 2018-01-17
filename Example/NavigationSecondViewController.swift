//
//  NavigationSecondViewController.swift
//  Example
//
//  Created by liushuang on 2018/1/17.
//  Copyright © 2018年 liushuang. All rights reserved.
//

import UIKit

//定义一个全局变量，用来记录当前显示视图的编号
var pageNum = 0

class NavigationSecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.purple
        
        pushAndPopPage()
        //        hideNavAndToolBar()
        
    }
    
    fileprivate func pushAndPopPage() {
        let btnPush = UIButton(frame: CGRect(x: 40, y:120, width: 240, height: 40))
        btnPush.setTitle("Push Page", for: UIControlState())
        btnPush.backgroundColor = UIColor.orange
        btnPush.addTarget(self, action: #selector(NavigationSecondViewController.pushPage), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btnPush)
        
        let btnPop = UIButton(frame: CGRect(x: 40, y: 180, width: 240, height: 40))
        btnPop.setTitle("Pop Page", for: UIControlState())
        btnPop.backgroundColor = UIColor.orange
        btnPop.addTarget(self, action: #selector(NavigationSecondViewController.popPage), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btnPop)
        
        let btnIndex = UIButton(frame: CGRect(x: 40, y: 280, width: 240, height: 40))
        btnIndex.setTitle("Goto Index Page", for: UIControlState())
        btnIndex.backgroundColor = UIColor.orange
        btnIndex.addTarget(self, action: #selector(NavigationSecondViewController.goIndexPage), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btnIndex)
        
        let btnRoot = UIButton(frame: CGRect(x: 40, y: 340, width: 240, height: 40))
        btnRoot.setTitle("Goto Root Page", for: UIControlState())
        btnRoot.backgroundColor = UIColor.orange
        btnRoot.addTarget(self, action: #selector(NavigationSecondViewController.goRootPage), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btnRoot)
        
        self.title = "Page\(pageNum)"
        
    }
    
    
    @objc func pushPage(){
        let viewController = NavigationSecondViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
        pageNum = pageNum + 1
        print("pageNumber:\(pageNum)")
    }
    
    @objc func popPage(){
        self.navigationController?.popViewController(animated: true)
        pageNum = pageNum - 1
        
        if (pageNum < 0) {
            pageNum = 0
        }
        print("pageNumber:\(pageNum)")
    }
    
    @objc func goIndexPage(){
        let index = pageNum - 2
        if index >= 0 {
            let viewController = self.navigationController?.viewControllers[index]
            self.navigationController?.popToViewController(viewController!, animated: true)
            pageNum = index
        }
        else {
            self.navigationController?.popToRootViewController(animated: true)
            pageNum = 0
        }
        
        print("pageNumber:\(pageNum)")
        
    }
    
    @objc func goRootPage(){
        self.navigationController?.popToRootViewController(animated: true)
        pageNum = 0
        print("pageNumber:\(pageNum)")
    }
    
    fileprivate func hideNavAndToolBar() {
        let btnHideNavBar = UIButton(frame: CGRect(x: 40, y:200, width: 240, height: 30))
        btnHideNavBar.setTitle("Hide navigation bar", for: UIControlState())
        btnHideNavBar.backgroundColor = UIColor.orange
        btnHideNavBar.addTarget(self, action: #selector(NavigationSecondViewController.hideNavigationBar), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btnHideNavBar)
        
        let btnHideToolBar = UIButton(frame: CGRect(x: 40, y: 260, width: 240, height: 30))
        btnHideToolBar.setTitle("Hide Tool bar", for: UIControlState())
        btnHideToolBar.backgroundColor = UIColor.orange
        btnHideToolBar.addTarget(self, action: #selector(NavigationSecondViewController.hideToolBar), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btnHideToolBar)
    }
    
    
    @objc func hideNavigationBar() {
        //隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func hideToolBar() {
        //隐藏工具栏
        self.navigationController?.setToolbarHidden(true, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
