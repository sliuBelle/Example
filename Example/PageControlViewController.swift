//
//  PageControlViewController.swift
//  Example
//
//  Created by liushuang on 2018/1/17.
//  Copyright © 2018年 liushuang. All rights reserved.
//

import UIKit

class PageControlViewController: UIViewController,UIScrollViewDelegate {
    
    //创建一个滚动视图，它是一个可以拖动的组件
    var scrollView = UIScrollView()
    //添加一个控制翻页的属性，使用它来控制滚动视图的翻页，通过小白点，来观察当前页面的位置
    var pageControl = UIPageControl()
    //添加一个状态属性，用来标志页面的滑动状态
    var isPageControlUsed = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var screenFrame = UIScreen.main.bounds
        let screenWidth = screenFrame.width
        let screenHeight = screenFrame.height
        
        scrollView.frame = screenFrame
        //设置滚动视图为分页模式，每滚动一次就是一页
        scrollView.isPagingEnabled = true
        //设置滚动视图的尺寸，因有两个页面，所以滚动视图的宽度设置为两个页面的宽度
        scrollView.contentSize = CGSize(width: screenWidth * 2, height: screenHeight)
        scrollView.backgroundColor = UIColor.black
        //设置滚动视图对象的代理未当前类，这样就可以再当前文件中，编写代理方法，以捕捉滚动视图的相关动作
        scrollView.delegate = self
        
        //创建一个高度常量，作为页面控制器对象的高度
        let pcHeight: CGFloat = 50.0
        //创建一个区域，用来显示控制器对象
        let pcRect = CGRect(x: 0, y: screenHeight - pcHeight, width: screenWidth, height: pcHeight)
        //设置页面控制器对象的显示区域
        pageControl.frame = pcRect
        //设置页面控制器总页数为两页
        pageControl.numberOfPages = 2
        //设置页面控制器当前页编号
        pageControl.currentPage = 0
        //        pageControl.backgroundColor = UIColor.gray
        //给页面控制器对象，添加监听页面切换事件的方法
        pageControl.addTarget(self, action: #selector(PageControlViewController.pageControlDidChange(_:)), for: UIControlEvents.valueChanged)
        
        let firstController = FirstPageSubViewController()
        screenFrame.origin.x = 0
        firstController.view.frame = screenFrame
        
        let secondController = SecondPageSubViewController()
        screenFrame.origin.x = screenFrame.size.width
        secondController.view.frame = screenFrame
        
        scrollView.addSubview(firstController.view)
        scrollView.addSubview(secondController.view)
        
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl)
    }
    
    @objc func pageControlDidChange(_ sender:AnyObject){
        //获得当前页面
        let crtPage = (CGFloat)(pageControl.currentPage)
        //获得滚动当前的显示区域
        var frame = scrollView.frame
        //根据页面控制器对象的目标页码，计算滚动视图在下一个页面中的显示区域
        frame.origin.x = frame.size.width * crtPage
        frame.origin.y = 0
        //滚动视图到目标区域
        scrollView.scrollRectToVisible(frame, animated: true)
        //设置通过页面控制器对象切换页面
        isPageControlUsed = true
        
    }
    
    //创建监听滚动视图的滚动事件的代理方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //如果是通过页面控制器对象切换页面，则不执行后面的代码
        if (!isPageControlUsed) {
            //获得滚动视图的宽度值
            let pageWidth = scrollView.frame.size.width
            //根据滚动视图的宽度值和横向位移量，计算当前的页码
            let page = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1
            pageControl.currentPage = Int(page)
        }
    }
    
    //创建监听滚动视图的滚动减速事件的代理方法，重置标识变量的默认值
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isPageControlUsed = false
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
