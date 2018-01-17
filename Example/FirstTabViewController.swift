//
//  FirstTabViewController.swift
//  Example
//
//  Created by liushuang on 2018/1/17.
//  Copyright © 2018年 liushuang. All rights reserved.
//

import UIKit

class FirstTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        itemNameAndImage()
        table()
    }
    
    func itemNameAndImage() {
        self.title = "Item #1"
        let image = UIImage(named:"p_match_icon_off")
        self.tabBarItem.image = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.view.backgroundColor = UIColor.brown
    }
    
    func table(){
        let tableView = UITableView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-64))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = true
        //
        //        //初始化一个索引路径对象，用来标识表格中的第一个段落和第十二行的位置
        //        let indexPath = IndexPath(row: 11, section: 0)
        //        tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return 5
        return months.count
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 80
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //创建一个字符串作为单元格的标识符
        let identifier = "reusedCell"
        //单元格的标识符可以看做是一种复用机制。此方法可以从，所有已经开辟内存的单元格里面，选择一个具有同样标识符的，空闲的单元格
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: identifier)
        }
        //索引路径用来标识单元格再表格中的位置，它有section和row两属性，前者标识单元格处于第几个段落，后者标识单元格在段落中的第几行
        let rowNum = indexPath.row
        cell?.textLabel?.text = months[rowNum]
        
        //        cell?.textLabel?.text = "Cell Title here."
        //        cell?.detailTextLabel?.text = "Detail Information here."
        //        cell?.imageView?.image = UIImage(named: "p_match_icon_off")
        //        cell?.imageView?.highlightedImage = UIImage(named: "p_run_icon_on")
        
        //背景设置
        //        if (rowNum == 1) {
        //            cell?.backgroundColor = UIColor.yellow
        //        }
        //        else{
        //            let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        //            view.backgroundColor = UIColor.brown
        //            cell?.backgroundView = view
        //        }
        //        if (rowNum % 2 == 0) {
        //            cell?.backgroundColor = UIColor.purple
        //        }
        //        else
        //        {
        //            cell?.backgroundColor = UIColor.orange
        //        }
        //
        return cell!
    }
    
    //添加一个代理方法，用来相应单元格点击事件
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        //获取表格中被点击的单元格
    //        let cell = tableView.cellForRow(at: indexPath)
    //        //如果被点击的单元格没有附加图标，则显示复选标记图标，表示当前单元格处于选中状态
    //        if cell?.accessoryType == UITableViewCellAccessoryType.none {
    //            cell?.accessoryType = UITableViewCellAccessoryType.checkmark
    //        }
    //        else
    //        {
    //            cell?.accessoryType = UITableViewCellAccessoryType.none
    //        }
    //    }
    
    //添加一个代理方法，用来设置单元格的编辑模式为删除模式或者插入模式
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        switch indexPath.row {
        case 0,1,2,3:
            return UITableViewCellEditingStyle.delete
        case 4,5,6,7:
            return UITableViewCellEditingStyle.insert
        default:
            return UITableViewCellEditingStyle.none
        }
        
        //        if indexPath.row == 0 {
        //            return UITableViewCellEditingStyle.delete
        //        }
        //        else
        //        {
        //            return UITableViewCellEditingStyle.insert
        //        }
    }
    
    //添加代理方法，设置单元格是否允许拖动换行
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //再添加代理方法，用来响应单元格的移动事件
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let fromRow = sourceIndexPath.row
        let toRow = destinationIndexPath.row
        //获取数组再单元格移动前的对象
        let obj = months[fromRow]
        //删除数组中单元格移动前位置的对象
        months.remove(at: fromRow)
        months.insert(obj, at: toRow)
        tableView.reloadData()
    }
    
    //添加一个代理方法，用来响应单元格的删除事件或者插入事件
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            //获取待删除的单元格，再段落中的行数
            let rowNum = indexPath.row
            months.remove(at: rowNum)
            //创建一个包含待删除单元格位置信息的数组
            let indexPaths = [indexPath]
            //再从表格视图中，清除改单元格
            tableView.deleteRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        }
        //--------------------------insert-----------------------
        if (editingStyle == UITableViewCellEditingStyle.insert) {
            let rowNum = indexPath.row
            months.insert("Honey Moon", at: rowNum)
            
            let indexPaths = [indexPath]
            tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.right)
            
        }
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
