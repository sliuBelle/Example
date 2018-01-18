//
//  ThirdTabViewController.swift
//  Example
//
//  Created by liushuang on 2018/1/18.
//  Copyright © 2018年 liushuang. All rights reserved.
//

import UIKit

class ThirdTabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameAndImage()

        // Do any additional setup after loading the view.
    }
    
    func itemNameAndImage(){
        self.title = "Item #3"
        self.tabBarItem.image = UIImage(named: "p_run_icon_on")
        self.view.backgroundColor = UIColor.orange
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
