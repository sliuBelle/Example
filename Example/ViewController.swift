//
//  ViewController.swift
//  Example
//
//  Created by liushuang on 2018/1/17.
//  Copyright © 2018年 liushuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //        TapGesture()
        //        viewTransform()
        //        viewPattern()
        //        viewGradient()
        //        ViewDisplayEffect()
        //        dynamicAddView()
        //        addSubView()
        //        addTwoView()
        //        super.viewDidLoad()
        //        addImage()
        //        logcat()
        //        appInfo()
        //
        //        //NotificationCenter用于不同类间的通信
        //        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.orientationChanged(_ :)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        //
        //        //在状态了显示菊花转动效果
        //        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
    
    //屏幕方向检测
    @objc func orientationChanged(_ notification: Notification){
        let device = UIDevice.current
        switch device.orientation {
        case .portrait:
            print("面向设备保持垂直，Home键位于下部")
        case .portraitUpsideDown:
            print("面向设备保持垂直，Home键位于上部")
        case .landscapeLeft:
            print("面向设备保持水平，Home键位于右侧")
        case .landscapeRight:
            print("面向设备保持水平，Home键位于左侧")
        case .faceUp:
            print("设备平放，Home键朝上")
        case .faceDown:
            print("设备平方，Home键朝下")
        case .unknown:
            print("方向未知")
        }
    }
    
    //添加image方法
    fileprivate func addImage() {
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "1")
        let imgView = UIImageView(image: image)
        self.view.addSubview(imgView)
    }
    
    //输入log方法
    fileprivate func logcat() {
        print("It's a print")
        let str = "Xcode"
        print("Hello" + str)
        print("Hello \(str)")
        debugPrint("It's a debugPrintln")
        let position = (x : 10.5, y : 20)
        dump(position)
    }
    
    //获取程序相关信息
    fileprivate func appInfo() {
        //获得当前程序可执行文件所在目录
        let mainBundle = Bundle.main
        
        //获得程序包的识别标识符，该标识符是应用程序唯一的标识，应用于标识符之间是一一对应关系。请注意：应用新建成功后，该标识符将不可修改
        let identifier = mainBundle.bundleIdentifier
        
        //获得程序包的所有配置信息，并存储在字典对象中
        let info = mainBundle.infoDictionary
        
        //获得当前应用程序的名称
        let bundleId = mainBundle.object(forInfoDictionaryKey: "CFBundleName")
        
        //获得当前应用程序的版本号
        let version = mainBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString")
        
        print("[identifier]:\(identifier)")
        print("[info]:\(info)")
        print("[bundleId]:\(bundleId)")
        print("[version]:\(version)")
    }
    
    fileprivate func addTwoView() {
        let rect1 = CGRect(x: 30, y: 50, width:200, height: 200)
        let view1 = UIView(frame: rect1)
        view1.backgroundColor = UIColor.brown
        
        let rect2 = CGRect(x: 90, y: 120, width: 200, height: 200)
        let view2 = UIView(frame: rect2)
        view2.backgroundColor = UIColor.purple
        
        self.view.addSubview(view1)
        self.view.addSubview(view2)
    }
    
    fileprivate func extractedFunc() {
        let view1 = UIView(frame: CGRect(x: 20, y: 80, width: 280, height: 280))
        view1.backgroundColor = UIColor.red
        self.view.addSubview(view1)
        
        let view2 = UIView(frame: CGRect(x: 20, y: 80, width: 200, height: 200))
        //设置视图本地坐标系中的位置和大小，它会影响子视图的位置和显示
        view2.bounds = CGRect(x: -10, y: -20, width: 200, height: 200)
        view2.backgroundColor = UIColor.yellow
        self.view.addSubview(view2)
        
        let subView = UIView(frame: CGRect(x: 0, y:0, width: 100, height: 100))
        subView.backgroundColor = UIColor.blue
        view2.addSubview(subView)
    }
    
    //通过按钮动态操作视图
    func dynamicAddView(){
        let rect = CGRect(x: 30, y: 50, width: 200, height: 200)
        let view = UIView(frame: rect)
        view.backgroundColor = UIColor.brown
        self.view.addSubview(view)
        
        let btAdd = UIButton(frame: CGRect(x: 30, y:350, width: 80, height: 30))
        btAdd.backgroundColor = UIColor.gray
        btAdd.setTitle("Add", for: UIControlState())
        btAdd.addTarget(self, action: #selector(ViewController.addView(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btAdd)
        
        let btBack = UIButton(frame: CGRect(x: 120, y: 350, width: 80, height: 30))
        btBack.backgroundColor = UIColor.gray
        btBack.setTitle("Switch", for: UIControlState())
        btBack.addTarget(self, action: #selector(ViewController.bringViewBack(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btBack)
        
        let btRemove = UIButton(frame: CGRect(x: 210, y: 350, width: 80, height: 30))
        btRemove.backgroundColor = UIColor.gray
        btRemove.setTitle("Remove", for: UIControlState())
        btRemove.addTarget(self, action: #selector(ViewController.removeView(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btRemove)
    }
    
    @objc func addView(_ sender:UIButton){
        let view = UIView(frame: CGRect(x: 60, y: 90, width: 200, height: 200))
        view.backgroundColor = UIColor.purple
        //给视图设定一个标识，这样可以在需要的时候，通过标识找到这个视图
        view.tag = 1
        self.view.addSubview(view)
    }
    
    @objc func bringViewBack(_ sender:UIButton){
        //通过tag找到之前添加的视图
        let view = self.view.viewWithTag(1)
        //判断是否存在此视图，如果存在，将此视图移动到所有兄弟视图的后方
        if ((view) != nil) {
            self.view.sendSubview(toBack: view!)
        }
    }
    
    @objc func removeView(_ sender:UIButton){
        let view = self.view.viewWithTag(1)
        //将此视图，从父视图中移除
        view?.removeFromSuperview()
    }
    
    //给图像视图添加边框效果、圆角效果、阴影效果
    func ViewDisplayEffect(){
        let image = UIImage(named:"5")
        let imageView = UIImageView(image: image)
        
        //---------设置视图显示区域---------------
        imageView.frame = CGRect(x: 10, y: 10, width: (self.view.bounds.width - 20), height: (self.view.bounds.height - 20))
        
        //---------设置视图边框宽度、颜色----------
        //设置图片视图的图层边框宽度为10.视图真正的绘图部分，是由一个叫CALayer的图层类来管理的
        imageView.layer.borderWidth = 10
        //视图的本身，更像是一个图层的管理器，访问它的 跟 绘图和坐标有关的属性，实际上就是在访问它所包含的图层的相关属性
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        //---------设置圆角效果-----------------
        //设置圆角半径
        imageView.layer.cornerRadius = 10.0
        //设置图像视图层的遮罩覆盖属性，进行边界裁切，添加阴影效果时，裁切会把阴影裁掉
        imageView.layer.masksToBounds = true
        
        //---------设置视图阴影效果--------------
        //设置图像视图层的阴影颜色为黑色
        imageView.layer.shadowColor = UIColor.black.cgColor
        //设置图像视图层，阴影的横向和纵向偏移值
        imageView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        //设置图像视图层，阴影的透明度
        imageView.layer.shadowOpacity = 0.9
        //设置图像视图层阴影半径大小
        imageView.layer.shadowRadius = 5.0
        
        self.view.addSubview(imageView)
    }
    
    //视图的渐变填充
    func viewGradient(){
        let gradientView = UIView(frame: CGRect(x: 30, y: 60, width: 200, height: 200))
        //创建一个渐变层
        let gradientLayer = CAGradientLayer()
        //设置渐变层的位置和尺寸与视图对象保持一致
        gradientLayer.frame = gradientView.frame
        //设置渐变的起始颜色、中间颜色、最后颜色
        let fromColor = UIColor.yellow.cgColor
        let midColor = UIColor.red.cgColor
        let toColor = UIColor.purple.cgColor
        let finalColor = UIColor.blue.cgColor
        //将渐变层的颜色数组属性，设置为由三个颜色所构成的数组
        gradientLayer.colors = [fromColor, midColor, toColor, finalColor]
        //将配置好的渐变层，添加到视图对象的层中
        view.layer.addSublayer(gradientLayer)
        self.view.addSubview(gradientView)
        
    }
    
    //利用图片视图纹理
    func viewPattern() {
        let image = UIImage(named:"7")
        //用图片作为纹理颜色初始化
        let patternColor = UIColor.init(patternImage: image!)
        //设置视图的背景颜色
        self.view.backgroundColor = patternColor
    }
    
    //CGAffineTransform仿射变换的使用:仿射变换可以平移、旋转、缩放变换路径或者图形上下文
    func viewTransform(){
        let rect = CGRect(x: 50, y:150, width: 200, height: 50)
        let view = UIView(frame: rect)
        view.backgroundColor = UIColor.brown
        self.view.addSubview(view)
        
        var transform = view.transform
        //旋转45度
        transform = transform.rotated(by: 3.14/4)
        view.transform = transform
        
    }
    
    //UITapGestureRecognizer手势点击--图像视图
    func TapGesture(){
        let rect = CGRect(x: 30, y:80, width: 256, height:256)
        let imageView = UIImageView(frame: rect)
        
        let image = UIImage(named: "7")
        imageView.image = image
        
        //开启图像视图的交互功能
        imageView.isUserInteractionEnabled = true
        self.view.addSubview(imageView)
        
        //创建一个手势检测类，这是一个抽象类，它定义了所有手势的基本行为，并拥有6个子类，来检测发生在设备中的各种手势
        //        //点击
        //        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.singleTap))
        //        //将创建的手势指给图像视图
        //        imageView.addGestureRecognizer(gestureTap)
        
        //长按
        let gestureLongPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(_:)))
        imageView.addGestureRecognizer(gestureLongPress)
        
        //双击
        let gesturedDoubleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.DoubleTap))
        gesturedDoubleTap.numberOfTapsRequired = 2//设置2次数为2，模拟双击事件
        gesturedDoubleTap.numberOfTouchesRequired = 1 //设置手势为单次双击事件
        imageView.addGestureRecognizer(gesturedDoubleTap)
    }
    
    //接收手势事件
    @objc func singleTap(){
        //当接收到手势事件后，弹出一个提示窗口
        let alertView = UIAlertController(title: "Information", message: "Single tap", preferredStyle: UIAlertControllerStyle.alert)
        //创建一个按钮，作为提示窗口中的确定按钮，当用户点击按钮时，将关闭提示窗口
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: {_ in})
        //将确定按钮，添加到提示窗口中
        alertView.addAction(OKAction)
        //在当前视图控制器中，展示提示窗口
        self.present(alertView, animated: true, completion: nil)
    }
    
    @objc func longPress(_ gusture:UILongPressGestureRecognizer){
        //检测一下手势时间的阶段
        if (gusture.state == UIGestureRecognizerState.began) {
            let alertView = UIAlertController(title: "Information", message: "Long Press", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: {_ in})
            //将确定按钮，添加到提示窗口中
            alertView.addAction(OKAction)
            //在当前视图控制器中，展示提示窗口
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    @objc func DoubleTap(){
        let alertView = UIAlertController(title: "information", message: "Double Tap", preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: {_ in})
        alertView.addAction(OKAction)
        self.present(alertView, animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

