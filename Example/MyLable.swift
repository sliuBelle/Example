//
//  MyLable.swift
//  Example
//
//  Created by liushuang on 2018/1/17.
//  Copyright © 2018年 liushuang. All rights reserved.
//

import UIKit

class MyLable: UILabel {
    //重载父类的绘图方法，这样可以从底层来自定义标签的形状
    override func draw(_ rect: CGRect) {
        //获取当前图形环境的上下文
        let context = UIGraphicsGetCurrentContext()
        //设置在上下文中，文字的渲染模式为描边模式
        context?.setTextDrawingMode(CGTextDrawingMode.stroke)
        //设置文字描边的边框宽度为2
        context?.setLineWidth(2)
        //设置文字描边的顶点连接方式为圆角方式
        context?.setLineJoin(CGLineJoin.round)
        //设置文字的描边颜色为白色
        self.textColor = UIColor.white
        //将文字的描边信息绘制在制定区域内
        super.drawText(in: rect)
        
        //设置在上下文中，文字渲染模式为填充
        context?.setTextDrawingMode(CGTextDrawingMode.fill)
        self.textColor = UIColor.black
        super.drawText(in: rect)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
