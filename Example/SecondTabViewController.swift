//
//  SecondTabViewController.swift
//  Example
//
//  Created by liushuang on 2018/1/17.
//  Copyright © 2018年 liushuang. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation
//首先引入需要使用的流媒体基础框架，它能收集各种多媒体数据，这些数据可以来自不同的输入设备，比如摄像机、录音机等。

class SecondTabViewController: UIViewController {
    //初始化音频播放对象，并将音频播放对象，作为视图控制器类的属性。
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemNameAndImage()
        //        imageScaleApply()
        //        grayImageApply()
        //        ciImageOneColor()
        //        ciImageCIHueAdjust()
        //        ciImageCIPixellate()
        //        uiblurEffect()
        //        caTransactionReveal()
        //        caTransactionPush()
//                imagePlayAnimation()
//        frameAnimotion()
//        systemSound()
//        audio()
//        backgroundPlayer()
//        mvPlayer2()
        
    }
    
    func itemNameAndImage(){
        self.title = "Item #2"
        self.tabBarItem.image = UIImage(named: "p_run_icon_on")
        self.view.backgroundColor = UIColor.purple
    }
    
    func mvPlayer(){
        //定义一个视频文件路径
        let filePath = Bundle.main.path(forResource: "movie", ofType: "mp4")
        //将字符串路径，转换为网址路径。
        let videoURL = URL(fileURLWithPath: filePath!)
        //定义一个视频播放器，通过本地文件路径初始化
        let player = AVPlayer(url: videoURL)
        //设置大小和位置（全屏）
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    
    func mvPlayer2(){
        //定义一个视频文件路径
        let filePath = Bundle.main.path(forResource: "movie", ofType: "mp4")
        //将字符串路径，转换为网址路径。
        let videoURL = URL(fileURLWithPath: filePath!)
        
        //定义一个playerItem，并监听相关的通知
        let playerItem = AVPlayerItem(url: videoURL)
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        //定义一个视频播放器，通过本地文件路径初始化
        let player = AVPlayer(playerItem: playerItem)
        //设置大小和位置（全屏）
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    
    @objc func playerDidFinishPlaying(){
        print("播放完毕")
    }
    
    
    
    //info.plist中设置键Required background modes item0--App plays audio or streams audio/video using AirPlay
    func backgroundPlayer() {
        //设初始化音频播放对象，并将音频播放对象，作为视图控制器类的属性。
        //获得音频会话对象，该对象属于单例模式，也就是说不用开发者而自行实例化。这个类在各种音频环境中，起着非常重要的作用。
        let session = AVAudioSession.sharedInstance()
        do {
            //启动音频会话管理，此时会阻断后台音乐的播放。
            try session.setActive(true)
            //设置音频操作类别，表示该应用仅支持音频的播放。
            try session.setCategory(AVAudioSessionCategoryPlayback)
            //设置应用程序支持接受远程控制事件。
            UIApplication.shared.beginReceivingRemoteControlEvents()
            //定义一个字符串常量，描述声音文件的路径。
            let path = Bundle.main.path(forResource: "music", ofType: "mp3")
            //将字符串路径，转换为网址路径。
            let soundUrl = URL(fileURLWithPath: path!)
            //对音频播放对象，进行初始化，并加载指定的音频文件。
            try audioPlayer = AVAudioPlayer(contentsOf: soundUrl)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        }catch {
            print(error)
        }
    }
    
    //audio
    func audio(){
        //设初始化音频播放对象，并将音频播放对象，作为视图控制器类的属性。
        //获取沙箱目录中，音频文件的所在路径。
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        //将字符串路径，转换为网址路径。
        let soundUrl = URL(fileURLWithPath: path!)
        do {
            //在音频播放前，首先创建一个异常捕捉语句。对音频播放对象，进行初始化，并加载指定的音频文件。
            try audioPlayer = AVAudioPlayer(contentsOf: soundUrl)
            //设置音频播放对象的音量大小。
            audioPlayer.volume = 1.0
            //设置音频播放的次数，-1为无限循环播放。
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        } catch {
            print(error)
        }
    }
    
    //系统声音，小于30s
    func systemSound(){
//        //1.声音播放
//        //建立的SystemSoundID对象
//        var soundID:SystemSoundID = 0
//        //获取声音地址
//        let path = Bundle.main.path(forResource: "tap1", ofType: "mp3")
//        //地址转换
//        let baseURL = NSURL(fileURLWithPath: path!)
//        //赋值
//        AudioServicesCreateSystemSoundID(baseURL, &soundID)
//        //播放声音
//        AudioServicesPlaySystemSound(soundID)
        
        //2. 提醒(声音+震动)
        //建立的SystemSoundID对象
        var soundID:SystemSoundID = 0
        //获取声音地址:获取沙箱目录中，音频文件的所在路径。
        let path = Bundle.main.path(forResource: "tap1", ofType: "mp3")
        //地址转换
        let baseURL = NSURL(fileURLWithPath: path!)
        //赋值
        AudioServicesCreateSystemSoundID(baseURL, &soundID)
        //提醒（同上面唯一的一个区别）
        AudioServicesPlayAlertSound(soundID)
        
//        //3.振动
//        let soundID = SystemSoundID(kSystemSoundID_Vibrate)
//        AudioServicesPlaySystemSound(soundID)

    }
    
    //----------使用UIImageView制作帧动画
    func frameAnimotion(){
        //初始化一个数组用来存放素材
        var images = [UIImage]();
        //创建一个循环，导入图片
        for i in 1...12 {
            images.append(UIImage(named: "\(i)")!)
        }
        let imageView = UIImageView(frame: CGRect(x: 0, y: 60, width: 120, height: 120))
        //设置图像视图的动画图片属性
        imageView.animationImages = images
        imageView.animationDuration = 5
        //设置动画循环次数，0为无限次循环
        imageView.animationRepeatCount = 1
        //开始帧动画播放
        imageView.startAnimating()
        
        self.view.addSubview(imageView)
        
    }
    //----------UIView视图的动画块
    func imagePlayAnimation(){
        let image = UIImage(named: "pic")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: self.view.bounds.width/4, y: self.view.bounds.height/4, width: self.view.bounds.width/2, height: self.view.bounds.height/2)
        imageView.tag = 1
        self.view.addSubview(imageView)
        
        let button = UIButton(type: UIButtonType.system)
        button.frame = CGRect (x: self.view.bounds.width/4, y: self.view.bounds.height/4 * 3 + 1, width: self.view.bounds.width/2, height: 44)
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Tap", for: UIControlState())
        button.addTarget(self, action: #selector(SecondTabViewController.playAnimation), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
    }
    @objc func playAnimation(){
        //发出开始视图动画的请求，标志着视图动画块的开始，在它和提交动画请求之间，可以定义动画的各种展示方式
        UIView.beginAnimations(nil, context: nil)
        //设置动画的播放速度为淡入淡出
        UIView.setAnimationCurve(.easeInOut)
        UIView.setAnimationDuration(5)
        //设置动画从视图当前状态开始播放
        UIView.setAnimationBeginsFromCurrentState(true)
        if ((self.view.viewWithTag(1)) != nil) {
            let view = self.view.viewWithTag(1)
            //设置动画类型为翻转动画.flipFromLeft,卷曲动画.curlUp
            UIView.setAnimationTransition(.flipFromRight, for: view!, cache: true)
            //            UIView.setAnimationTransition(.curlUp, for: view!, cache: true)
            view?.frame = CGRect(x: 50, y: 50, width: 0, height: 0)
            //调用视图的提交动画方法，标志着动画块的结束
            ////检测UIView视图动画结束事件,设置动画的代理对象，为当前视图控制器，当动画结束时，在控制台打印输出日志
            UIView.setAnimationDelegate(self)
            ////设置动画结束时执行的方法
            UIView.setAnimationDidStop(#selector(SecondTabViewController.animationStop))
            UIView.commitAnimations()
        }
        else
        {
            let image = UIImage(named: "pic")
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: self.view.bounds.width/4, y: self.view.bounds.height/4, width: self.view.bounds.width/2, height: self.view.bounds.height/2)
            imageView.tag = 1
            self.view.addSubview(imageView)
        }
    }
    @objc func animationStop(){
        print("AnimationStop")
        self.view.viewWithTag(1)?.removeFromSuperview()
    }
    
    
    //----------使用CATransaction Reveal制作动画:渐显动画
    func caTransactionReveal(){
        let image = UIImage(named: "pic")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(imageView)
        
        //可以使用两种方法来实现动画效果，一种是使用视图层面的，一种是使用过渡动画，它实现了层的过渡动画，因此可以进行更低层次的控制
        let animation = CATransition()
        //设置动画时间两秒
        animation.duration = 4
        //设置动画的播放速度由慢到快
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        //设置动画的类型为渐显动画
        animation.type = kCATransitionReveal
        //将动画指定给图像视图层
        imageView.layer.add(animation, forKey: "Reveal")
    }
    
    //----------使用CATransaction push制作动画:渐显动画
    func caTransactionPush(){
        let image = UIImage(named: "pic")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(imageView)
        
        //可以使用两种方法来实现动画效果，一种是使用视图层面的，一种是使用过渡动画，它实现了层的过渡动画，因此可以进行更低层次的控制
        let animation = CATransition()
        //设置动画时间两秒
        animation.duration = 4
        //设置动画的播放速度由慢到快
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        //设置动画的类型为入场动画
        animation.type = kCATransitionPush
        //将动画指定给图像视图层
        imageView.layer.add(animation, forKey: "Push")
    }
    
    
    //----------使用UIBlurEffect给图片添加模糊效果(毛玻璃效果)
    func uiblurEffect(){
        let image = UIImage(named: "pic")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(imageView)
        
        //8.0版本开始，系统提供了模糊效果的功能
        if #available(iOS 8.0, *) {
            //初始化一个模糊效果对象，模糊效果对象可以帮助您快速制作类似于导航栏、通知中心或者控制中心毛玻璃效果
            let blur = UIBlurEffect(style: .light)
            //初始化一个基于模糊效果的视觉效果视图
            let blurView = UIVisualEffectView(effect: blur)
            blurView.frame = CGRect(x: 40, y: 40, width: 200, height: 200)
            //设置模糊视图的圆角半径为30
            blurView.layer.cornerRadius = 30
            //设置模糊视图层的遮罩覆盖属性，进行边界裁切
            blurView.layer.masksToBounds = true
            //将模糊视图，添加到图像视图，作为图像视图的自视图
            imageView.addSubview(blurView)
        }
        else
        {
            print("UIBlurEffect is only available on iOS8.0 or newer")
        }
    }
    
    
    //----------使用CoreImage框架给图片添加马赛克效果（像素化滤镜）
    func ciImageCIPixellate(){
        let image = UIImage(named: "pic")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(imageView)
        
        let ciImage = CIImage(image: image!)
        let filter = CIFilter(name: "CIPixellate")
        //设置像素化滤镜，采用默认配置选项
        filter?.setDefaults()
        //设置需要应用像素化滤镜的图像
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        let outImage = filter?.outputImage
        imageView.image = UIImage.init(ciImage: outImage!)
        
    }
    
    //----------使用CoreImage框架更改图片的色相(色相调整滤镜)
    func ciImageCIHueAdjust(){
        let image = UIImage(named: "pic")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(imageView)
        
        let ciImage = CIImage(image: image!)
        let filter = CIFilter(name: "CIHueAdjust")
        //设置色相调整滤镜的输入角度值为30度
        filter?.setValue(3.14/6, forKey: kCIInputAngleKey)
        //设置需要应用色相调整滤镜的图像
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        let outImage = filter?.outputImage
        
        imageView.image = UIImage.init(ciImage: outImage!)
        
    }
    //----------使用CoreImage框架设置图片的单色效果（单色滤镜）
    func ciImageOneColor(){
        let image = UIImage(named: "pic")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(imageView)
        //初始化一个CoreImage图像对象，并加载之前导入的图片
        let ciImage = CIImage(image: image!)
        //初始化一个颜色对象，并设置其颜色值为棕色。其参数数值介于0和1之间
        let color = CIColor(red: 0.8, green: 0.6, blue: 0.4)
        //初始化一个滤镜对象，并设置滤镜类型为单色调滤镜
        let filter = CIFilter(name: "CIColorMonochrome")
        //设置单色调滤镜的颜色值
        filter?.setValue(color, forKey: kCIInputColorKey)
        //设置单色调滤镜的颜色浓度值
        filter?.setValue(1.0, forKey: kCIInputIntensityKey)
        //设置需要应用单色调滤镜的图像
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        //获得应用单色调滤镜后的图像
        let outImage = filter?.outputImage
        //更改图像视图的内容，为应用滤镜后的图像
        imageView.image = UIImage.init(ciImage: outImage!)
    }
    
    //----------使用图形上下文按一定比例缩放图片-------------
    func imageScaleApply() {
        let image = UIImage(named: "23")
        let scaleImage = self.scaleImage(image: (image)!, newSize: CGSize(width: 160, height: 240))
        let imageView = UIImageView(image: scaleImage)
        imageView.center = CGPoint(x: 160, y: 240)
        self.view.addSubview(imageView)
    }
    
    //创建一个方法，传递一个图形参数，和一个缩放比例参数，实现将图像缩放至指定比例的功能
    func scaleImage(image: UIImage, newSize: CGSize) -> UIImage {
        let imageSize = image.size
        let width = imageSize.width
        let height = imageSize.height
        
        //获取新尺寸和就尺寸的比例
        let widthFactor = newSize.width/width
        let heigthFactor = newSize.height/height
        //获取最小的比例
        let scaleFactor = (widthFactor<heigthFactor) ? widthFactor : heigthFactor
        
        //计算图像新的高度和宽度，并将新的宽度和高度构成标注cgsize对象
        let scaleWidth = width * scaleFactor
        let scaleHeigth = height * scaleFactor
        let targetSize = CGSize(width: scaleWidth, height: scaleHeigth)
        
        //创建绘图上下文环境
        UIGraphicsBeginImageContext(targetSize)
        //将之前的对象画到之前计算的新尺寸里，原点为 0 0
        image.draw(in: CGRect(x: 0, y: 0, width: scaleWidth, height: scaleHeigth))
        //获取上下文里的内容，将内容写入新的图像对象
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //返回生成的新的图像对象
        return newImage!
    }
    
    //-----------------使用图形上下文转换图片为灰色---------
    func grayImageApply() {
        let image = UIImage(named: "pic")
        let grayImage = self.grayImage(image: image!)
        let imageView = UIImageView(image: grayImage)
        imageView.center = CGPoint(x: 160, y: 240)
        self.view.addSubview(imageView)
    }
    
    func grayImage(image: UIImage)->UIImage{
        let imageSize = image.size
        let width = imageSize.width
        let height = imageSize.height
        //创建灰色色彩空间对象，各种设备对待颜色的方式不同，颜色必须有一个相关的颜色空间，否则图形上下文将不知道如何解释相关的颜色值
        let spaceRef = CGColorSpaceCreateDeviceGray()
        //参数1：指向要渲染的绘制内存的地址；参数2，3：分别表示宽度和高度；参数4：表示内存中像素的每个组件的位数；参数5：表示每一行，在内存所占的比特数；参数6：表示上下文使用的颜色空间；参数7：表示是否包含alpha通道
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: spaceRef, bitmapInfo: CGBitmapInfo().rawValue)!
        
        //然后创建一个和源图像同样尺寸的空间
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        //在灰度上下文中画入图片
        context.draw(image.cgImage!, in: rect)
        //从上下文中，获取并生成转为灰色的图片
        let grayImage = UIImage(cgImage: context.makeImage()!)
        return grayImage
    }
    
    //遍历系统提供的所有滤镜
    func builtInFilters(){
        //获得系统内置滤镜名称，并将滤镜名称放置到数组中
        let builtInFilters = CIFilter.filterNames(inCategory: kCICategoryBuiltIn)
        for filter in builtInFilters {
            //根据滤镜的名称获取对应的滤镜
            let filter = CIFilter(name: filter as String)
            //获得滤镜的所有属性
            let attributes = filter?.attributes
            print("[\(String(describing: filter))]\n")
            print(attributes)
            print("\n -------------------------------")
        }
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
