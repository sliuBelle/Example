//
//  NavigationFirstViewController.swift
//  Example
//
//  Created by liushuang on 2018/1/17.
//  Copyright © 2018年 liushuang. All rights reserved.
//

import UIKit
import MapKit

class NavigationFirstViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate {
    var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarDisplay()
        //        button()
        //        label()
        //        mylabel()
        //        uiSwitch()
        //        stepper()
        //        textField()
        //        showAlert()
        //        datePicker()
        //        indicatorView()
        //        webview()
        //        mapview()
        geocoder()
    }
    
    @objc func nextPage(){
        let viewController = NavigationSecondViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func navigationBarDisplay() {
        // Do any additional setup after loading the view.
        self.title = "First Page"
        self.view.backgroundColor = UIColor.purple
        //        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NavigationFirstViewController.nextPage))
        
        let leftBar = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(NavigationFirstViewController.refresh))
        self.navigationItem.leftBarButtonItem = leftBar
        
        let rightBar = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self,action: #selector(NavigationFirstViewController.save))
        self.navigationItem.rightBarButtonItem = rightBar
        
        //        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 30))
        //        label.text = "Happy Day"
        //        label.textAlignment = NSTextAlignment.center
        //        self.navigationItem.titleView = label
        
    }
    
    @objc func refresh(){
        let alert = UIAlertController(title: "Information",message: "Refresh my feeling", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func save(){
        print("save")
    }
    
    //需要导入mapkit，并加入代理集成类
    func mapview(){
        let map = MKMapView(frame: self.view.bounds)
        //显示当前用户的地理位置
        map.showsUserLocation = true
        //设置地图视图的显示样式，为卫星视图模式
        map.mapType = MKMapType.satellite
        //通过设定经纬度，来创建一个地图位置
        let coordinate2D = CLLocationCoordinate2D(latitude: 39.915352, longitude: 116.397105)
        //设置缩放级别
        let zoomLevel = 0.02
        //初始化一个常量，标识地图对象的显示区域
        let region = MKCoordinateRegionMake(coordinate2D, MKCoordinateSpanMake(zoomLevel, zoomLevel))
        //设置地图对象的显示区域
        map.setRegion(map.regionThatFits(region), animated: true)
        self.view.addSubview(map)
        
        //初始化一个点注释
        let objectAnnotation = MKPointAnnotation()
        //设置注释对象的地理位置
        objectAnnotation.coordinate = coordinate2D
        //设置注释对象的标题内容
        objectAnnotation.title = "Imperial Palace"
        //设置注释对象的子标题内容
        objectAnnotation.subtitle = "China's biggest palace"
        map.addAnnotation(objectAnnotation)
        
    }
    
    //地理位置解析，转化为实际的地理名词
    func geocoder(){
        //初始化一个地理位置解析类，使用该类进行地理坐标的反向解析
        let geocoder = CLGeocoder()
        //通过设定经纬度，来创建一个地理位置
        let location = CLLocation(latitude: 39.9, longitude: 116.3)
        geocoder.reverseGeocodeLocation(location, completionHandler: {(placeMarks:[CLPlacemark]?, error: Error?) -> Void in
            if (placeMarks?.count)! > 0
            {
                let placeMark = placeMarks?.first
                print(placeMark?.name ?? "")
                
            }
        })
    }
    
    func webview(){
        let webView = UIWebView(frame: CGRect(x: 0, y: 20, width: 320, height: 460))
        self.view.addSubview(webView)
        
        //加载网上内容
        //        let url = URL(string: "https://www.apple.com")
        //        let request = URLRequest(url: url!)
        //        webView.loadRequest(request)
        
        //加载本地html
        let html = "<font color='blue'>Hello</font>, <B>Xcode</B> and <i>Swift</i>"
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    func indicatorView() {
        //初始化环形进度条，并设置环形进度条的样式为大白
        //        indicator = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.center = CGPoint(x: 20, y: 120)
        indicator.startAnimating()
        self.view.addSubview(indicator)
        
        let button = UIButton(frame: CGRect(x: 20, y: 200, width: 280, height: 44))
        button.setTitle("stop", for: UIControlState())
        button.backgroundColor = UIColor.orange
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(NavigationFirstViewController.stopAnimation(_:)), for: UIControlEvents.touchUpInside)
        
        let button2 = UIButton(frame: CGRect(x: 20, y: 250, width: 280, height: 44))
        button2.setTitle("start", for: UIControlState())
        button2.backgroundColor = UIColor.orange
        self.view.addSubview(button2)
        button2.addTarget(self, action: #selector(NavigationFirstViewController.startAnimation(_:)), for: UIControlEvents.touchUpInside)
    }
    
    @objc func stopAnimation(_: UIActivityIndicatorView){
        if (indicator.isAnimating == true) {
            indicator.stopAnimating()
        }
    }
    
    @objc func startAnimation(_: UIActivityIndicatorView){
        if (indicator.isAnimating == false) {
            indicator.startAnimating()
        }
    }
    
    func datePicker(){
        let datePicker = UIDatePicker()
        datePicker.center = CGPoint(x: 160, y: 200)
        datePicker.tag = 1
        self.view.addSubview(datePicker)
        
        let tb = UIButton(frame: CGRect(x: 20, y: 50, width: 280, height: 44))
        tb.setTitle("Get date", for: UIControlState())
        tb.backgroundColor = UIColor.lightGray
        tb.addTarget(self, action: #selector(NavigationFirstViewController.getDate(_:)), for: .touchUpInside)
        self.view.addSubview(tb)
    }
    
    @objc func getDate(_ datePicker: UIDatePicker){
        let datePicker = self.view.viewWithTag(1) as! UIDatePicker
        let date = datePicker.date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm"
        let dateAndTime = dateFormater.string(from: date)//日期格式化
        
        let alert = UIAlertController(title:"Information", message: dateAndTime, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(){
        let tb = UIButton(frame: CGRect(x: 20, y: 120, width: 280, height: 44))
        tb.setTitle("Question", for: UIControlState())
        tb.backgroundColor = UIColor.lightGray
        tb.addTarget(self, action: #selector(NavigationFirstViewController.alert), for: .touchUpInside)
        self.view.addSubview(tb)
        
        let tb1 = UIButton(frame: CGRect(x: 20, y: 200, width: 280, height: 44))
        tb1.setTitle("Question", for: UIControlState())
        tb1.backgroundColor = UIColor.lightGray
        tb1.addTarget(self, action: #selector(NavigationFirstViewController.alertSheet), for: .touchUpInside)
        self.view.addSubview(tb1)
    }
    
    @objc func alert()
    {
        //        let alert = UIAlertController(title: "Infomation", message: "Are you a student?", preferredStyle: UIAlertControllerStyle.alert)
        let alert = UIAlertController.init(title: "Information", message: "Are you a student", preferredStyle: UIAlertControllerStyle.alert)
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler:{(alert: UIAlertAction) -> Void in print("Yes, I'm a student.")})
        let no = UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler:{(alert: UIAlertAction) -> Void in print("No, I'm not a student.")})
        alert.addAction(yes)
        alert.addAction(no)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func alertSheet(){
        let alert = UIAlertController(title: "Information", message: "What's your favorite postime?", preferredStyle: UIAlertControllerStyle.actionSheet)
        let fishing = UIAlertAction(title: "Fishing", style: UIAlertActionStyle.default, handler:{(alert: UIAlertAction) -> Void in print("I like fishing")})
        let hunting = UIAlertAction(title: "Hunting", style: UIAlertActionStyle.destructive, handler:{(alert: UIAlertAction) -> Void in print("I like hunting")})
        let noting = UIAlertAction(title: "Nothing", style: UIAlertActionStyle.cancel, handler:{(alert: UIAlertAction) -> Void in print("A life of Nonsense")})
        alert.addAction(fishing)
        alert.addAction(hunting)
        alert.addAction(noting)
        self.present(alert, animated: true, completion: nil)
    }
    
    func textField(){
        let textField = UITextField(frame: CGRect(x: 60, y: 80, width: 200, height: 30))
        //设置文本框边角
        textField.borderStyle = UITextBorderStyle.roundedRect
        //设置文本框占位符属性，用来描述输入字段预期值的提示信息。该提示会再输入字段为空时显示，并会再字段获得焦点是消失
        textField.placeholder = "Your Email"
        //关闭文本框对象的语法提示功能
        textField.autocorrectionType = UITextAutocorrectionType.no
        //设置在输入文字时，在键盘面板上，回车按钮的类型
        textField.returnKeyType = UIReturnKeyType.done
        //设置文本框第一项右侧的清除按钮，仅在编辑状态显示
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        //设置文本框对象的键盘类型，为系统提供的邮箱地址类型
        textField.keyboardType = UIKeyboardType.emailAddress
        //设置文本框对象的键盘为暗色主题
        textField.keyboardAppearance = UIKeyboardAppearance.dark
        //设置文本框对象的代理为当前视图控制器
        textField.delegate = self
        self.view.addSubview(textField)
    }
    //textField代理方法，当用户按下键盘上的回车键时，调用此方法
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //当用户按下回车键时，文本框对象失去焦点，键盘将自动隐藏
        textField.resignFirstResponder()
        return true
    }
    
    func stepper(){
        let label = UILabel(frame: CGRect(x: 80, y: 100, width: 100, height: 30))
        label.text = "0"
        label.tag = 1
        self.view.addSubview(label)
        
        let stepper = UIStepper(frame: CGRect(x: 130, y: 100, width: 0, height: 0))
        stepper.sizeToFit()
        stepper.value = 0
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.stepValue = 1
        stepper.addTarget(self, action: #selector(NavigationFirstViewController.valueChanged(_:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(stepper)
    }
    
    @objc func valueChanged(_ stepper: UIStepper){
        let value = stepper.value
        let label = self.view.viewWithTag(1) as! UILabel
        label.text = "\(value)"
    }
    
    func uiSwitch(){
        let uiSwitch = UISwitch(frame: CGRect(x: 130, y: 100, width: 0, height: 0))
        uiSwitch.setOn(true, animated: true)
        uiSwitch.addTarget(self, action: #selector(NavigationFirstViewController.switchChanged(_:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(uiSwitch)
    }
    @objc func switchChanged(_ uiSwitch: UISwitch){
        var message = "Turn on the switch"
        if (!uiSwitch.isOn) {
            message = "Turn off the switch"
        }
        let alert = UIAlertController(title: "Information", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func label(){
        let label = UILabel(frame: CGRect(x: 20, y: 50, width: 280, height: 300))
        label.text = "　Each of us holds a unique place in the world. You are special,no matter what others say or what you may think. So forget about being replaced. You can’t be."
        label.font = UIFont(name: "Arial", size: 24)
        label.textColor = UIColor.purple
        label.backgroundColor = UIColor.yellow
        //        label.textAlignment = NSTextAlignment.center
        label.shadowColor = UIColor.lightGray
        label.shadowOffset = CGSize(width: 2, height: 2)
        //设置标签文字的换行方式为：以空格为界，并保留整个单词
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        //设置标签对象不设置行数
        label.numberOfLines = 0
        self.view.addSubview(label)
    }
    
    func mylabel(){
        let lable = MyLable()
        lable.frame = CGRect(x: 20, y: 360, width: 240, height: 120)
        lable.text = "Enter >"
        lable.font = UIFont(name: "Georgia", size: 56)
        self.view.addSubview(lable)
        
    }
    
    func button(){
        let bt1 = UIButton(type: UIButtonType.infoDark)
        bt1.frame = CGRect(x: 80, y: 30, width: 40, height: 40)
        
        let bt2 = UIButton(type: UIButtonType.roundedRect)
        bt2.frame = CGRect(x: 80, y: 130, width: 150, height: 44)
        bt2.backgroundColor = UIColor.purple
        bt2.tintColor = UIColor.yellow
        bt2.setTitle("Tap me 2", for: UIControlState())
        bt2.addTarget(self, action: #selector(NavigationFirstViewController.buttonTap(_:)), for: UIControlEvents.touchUpInside)
        
        let bt3 = UIButton(type: UIButtonType.roundedRect)
        bt3.backgroundColor = UIColor.brown
        bt3.tintColor = UIColor.white
        bt3.setTitle("Tap me 3", for: UIControlState())
        bt3.frame = CGRect(x: 80, y: 230, width: 150, height: 44)
        bt3.layer.masksToBounds = true
        bt3.layer.borderWidth = 4
        bt3.layer.cornerRadius = 10
        bt3.layer.borderColor = UIColor.lightGray.cgColor
        
        let bt4 = UIButton(type: UIButtonType.roundedRect)
        bt4.frame = CGRect(x:13, y: 330, width: 343, height: 50)
        
        let img = UIImage(named: "butten")
        bt4.setBackgroundImage(img, for: UIControlState())
        bt4.setTitle("Tap me", for: UIControlState())
        bt4.setTitleColor(UIColor.white, for: UIControlState())
        bt4.titleLabel?.font = UIFont(name: "Arial", size: 24)
        bt4.addTarget(self, action: #selector(NavigationFirstViewController.buttonTap(_:)), for: UIControlEvents.touchDragInside)
        
        
        self.view.addSubview(bt1)
        self.view.addSubview(bt2)
        self.view.addSubview(bt3)
        self.view.addSubview(bt4)
    }
    
    @objc func buttonTap(_ button: UIButton){
        let alert = UIAlertController(title: "Information", message: "UIButton Event", preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //建立视图控制器生命周期中，视图即将显示的代理方式，视图再即将可见时，执行这个方法
    override func viewWillAppear(_ animated: Bool) {
        //覆盖父类同名方法
        super.viewWillAppear(animated)
        //显示底部工具栏
        self.navigationController?.setToolbarHidden(false, animated: false)
        //设置顶部导航区的提示文字
        //        self.navigationItem.prompt = "Loading..."
        //设置导航栏的背景是否透明
        self.navigationController?.navigationBar.isTranslucent = false
        //设置导航栏的系统样式
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        //设置导航栏的前景颜色
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        
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
