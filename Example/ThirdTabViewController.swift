//
//  ThirdTabViewController.swift
//  Example
//
//  Created by liushuang on 2018/1/18.
//  Copyright © 2018年 liushuang. All rights reserved.
//

import UIKit
import CoreData

class ThirdTabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameAndImage()
//        fillPath()
//        fileCreate()
//        writeText()
//        writeArray()
//        writeDictionary()
//        writeImage()
//        folder()
//        copyFile()
//        moveFile()
//        removefile()
//        removeFolder()
//        exit()
//        isFirstStart()
//        readPlist()
//        createPlist()
//        userMode()
//        coredata()
        // Do any additional setup after loading the view.
    }
    //CoreData实体：插入数据、查找、编辑、删除
    @available(iOS 10.0, *)
    func coredata(){
        //获得当前程序的应用代理。
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //通过应用代理对象，获得管理对象上下文。
        let manageObjectContext = appDelegate.persistentContainer.viewContext
        
//        //------------------------------插入----------------------------------
//        //通过管理对象上下文，插入一条实体数据。
//        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: manageObjectContext) as! User
//         newUser.userName = "John"
//        newUser.password = "123456"
//        //添加一条异常捕捉语句，用于执行数据的插入操作。
//        do
//        {
//            try manageObjectContext.save()
//            print("Success to save data.")
//        }
//        catch
//        {
//            print("Failed to save data")
//        }
//        
        //通过管理对象上下文，根据实体的名称，获得实体对象。
        let entity = NSEntityDescription.entity(forEntityName: "User", in: manageObjectContext)
        //然后创建一个数据提取请求对象。
        let request = NSFetchRequest<User>(entityName: "User")
        //接着设置提取数据的偏移值。
        request.fetchOffset = 0
        //设置提取数据的数量。
        request.fetchLimit = 10
        //继续设置需要提取数据的实体对象。
        request.entity = entity
        
        //然后创建一个谓词对象，设置提取数据的查询条件。谓词被用来指定数据被获取、或者过滤的方式。
        let predicate = NSPredicate.init(format: "userName= 'John'", "")
        //设置数据提取请求对象的谓词属性。
        request.predicate = predicate
        
        //------------------------------删除-----------------------------------
        do
        {
            let results:[AnyObject] = try manageObjectContext.fetch(request)
            for user:User in results as! [User]
            {
                manageObjectContext.delete(user)
            }
            try manageObjectContext.save()

            let results2:[AnyObject]? = try manageObjectContext.fetch(request)
            for user:User in results2 as! [User] {
                print("userName=\(user.userName)")
                print("password=\(user.password)")
            }
        }
        catch
        {
            print("Failed to modify data")
        }

        
        
        
        //------------------------------查询-------------------------------------
        //添加一条异常捕捉语句，用于执行数据的查询操作。
        do{
            //使用try语句，执行管理对象上下文的数据提取操作，并把提取的结果，存储在一个数组中。
            let results:[AnyObject]? = try manageObjectContext.fetch(request)
            for user:User in results as! [User]
            {
                print("userName=\(user.userName)")
                print("password=\(user.password)")
            }
        }
        catch
        {
            print("Failed to fetch data.")
        }
//        //------------------------------修改名字--------------------------------------
//        do
//        {
//            let requests:[AnyObject]? = try manageObjectContext.fetch(request)
//            for user:User in requests as! [User] {
//                user.userName = "Peter"
//            }
//            try manageObjectContext.save()
//            let results2:[AnyObject]? = try manageObjectContext.fetch(request)
//        }
//        catch
//        {
//            print("Failed to modify data")
//        }
        
    }
    
    //NSKeyedArchiver存储和解析数据
    func userMode(){
        //如何使用归档的方法，对模型对象进行持久化工作。在项目名称上点击鼠标右键，弹出右键菜单。
        //在弹出的模板选项窗口中，选择Swift文件选项，您将创建一个模型对象。
        //创建一个模型对象，并对其进行归档和恢复归档的操作。
        let user1 = UserModel()
        user1.name = "Jerry"
        user1.password = "123"
        
        //创建一个可变二进制数据对象，用来存储归档后的模型对象。
        let data = NSMutableData()
        //使数据对象，初始化一个键值归档对象。
        let archive = NSKeyedArchiver(forWritingWith: data)
        //对模型对象进行归档操作。归档指的是将Swift对象，存储为一个文件或者网络上的一个数据块。
        archive.encode(user1, forKey: "user1Key")
        //完成归档的编码，即序列化工作。
        archive.finishEncoding()
        
        //初始化一个字符串对象，作为归档文件的存储路径。
        let filePath = NSHomeDirectory() + "/Documents/contacts.data"
        //将归档文件，存储在程序包的指定位置。
        data.write(toFile: filePath, atomically: true)
        
        //现在来对归档文件进行加载和恢复归档的操作。首先读取刚刚保存的二进制数据文件。
        let fileData = NSMutableData(contentsOfFile: filePath)
        //然后对文件进行恢复归档的操作。恢复归档，指的是将一个来自文件或网络的归档数据块，恢复成内存中的一个Swift对象。
        let unarchiver = NSKeyedUnarchiver(forReadingWith: fileData! as Data)
        //根据设置的键名，对数据进行恢复归档操作，并获得最终结果。
        let savedUser = unarchiver.decodeObject(forKey: "user1Key") as! UserModel
        //完成对象的解码操作。
        unarchiver.finishDecoding()
        
        print(savedUser.name)
        print(savedUser.password)
    }
    
    func readPlist(){
        //获取属性列表文件，在项目中的路径。
        let plistPath = Bundle.main.path(forResource: "demoPlist", ofType: "plist")
        //加载属性列表文件，并存入一个可变字典对象中。
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: plistPath!)!
        //将字典对象，转换为字符串对象。
        let message = data.description
        let name = data["name"]
        let age = data["age"]
        
        print(message)
        print(name ?? "")
        print(age ?? "")
    }
    func createPlist(){
        let myArray = [["name":"liu"], ["Age":"22"]]
        let filePath:String = NSHomeDirectory() + "/Documents/demo2Plist"
        NSArray(array: myArray).write(toFile: filePath, atomically: true)
        folder()

    }
    
    func exit(){
        //获得一个应用实例。应用实例的核心作用是提供程序运行期间的控制和协作。每一个程序必须有，且仅有一个应用实例。
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(ThirdTabViewController.doSomething(_:)), name: .UIApplicationWillResignActive, object: app)
    }
    @objc func doSomething(_ sender: AnyObject){
        print("Saving data before exit.")
    }
    
    func isFirstStart(){
        //UserDefaults的使用，它常被用于存储程序的配置数据。当您关闭程序之后，再次打开程序时，之前存储的数据，依然可以从NSUserDefaults里读取。
        
        //创建一个字符串常量，作为是否启动过的标识名称。
        let EVERLAUNCHED = "everLaunched"
        //再创建一个字符串常量，作为是否首次启动的标识名称。
        let FIRSTLAUNCH = "firstLaunch"
        //获得变量的布尔值，当程序首次启动时，由于从未设置过此变量，所以它的默认值为否。
        if (!UserDefaults.standard.bool(forKey: EVERLAUNCHED)) {
            //将标识是否曾经启动过的变量，更改为真。表示当前程序，已经被启动过至少一次。
            UserDefaults.standard.set(true, forKey: EVERLAUNCHED)
            //将标识是否首次启动的变量，更改为真。表示当前程序，属于首次启动。对于首次运行的程序，可以根据业务需求，进行各种初始化工作。
            UserDefaults.standard.set(true, forKey: FIRSTLAUNCH)
            //调用同步方法，立即保存修改。
            UserDefaults.standard.synchronize()
        }
        else
        {
            //如果曾经启动过程序，则设置首次变量的布尔值为否。
            UserDefaults.standard.set(false, forKey: FIRSTLAUNCH)
            //调用同步方法，立即保存修改。
            UserDefaults.standard.synchronize()
        }
        
        var message = "It's the first show"
        //对于非首次运行的程序，设置不同的字符串文字。
        if (!UserDefaults.standard.bool(forKey: FIRSTLAUNCH)) {
            message = "It's not the first show"
        }
        print(message)
    }
    
    func itemNameAndImage(){
        self.title = "Item #3"
        self.tabBarItem.image = UIImage(named: "p_run_icon_on")
        self.view.backgroundColor = UIColor.orange
    }
    
    func folder(){
        let manage = FileManager.default
        let url = NSHomeDirectory() + "/Documents"
        do
        {
            let contents = try manage.contentsOfDirectory(atPath: url)
            print("contents:\(contents)\n")
            
            let contents2 = manage.enumerator(atPath: url)
            print("contents2:\(String(describing: contents2?.allObjects))")
        }
        catch
        {
            print("Error occurs.")
        }
    }
    
    func fileCreate(){
        let manage = FileManager.default
        let baseUrl = NSHomeDirectory() + "/Documents/txtFolder"
        
        let exist = manage.fileExists(atPath: baseUrl)
        if !exist {
            do
            {
                try manage.createDirectory(atPath: baseUrl, withIntermediateDirectories: true, attributes: nil)
                print("Success to create folder")
            }
            catch
            {
                print("Error to create folder")
            }
        }
    }
    
    func writeText(){
        let filePath:String = NSHomeDirectory() + "/Documents/swift.txt"
        let info = "Apple has introduced a brand new programming language alongside a brand new version of xcode. Swift is a big deal for developers"
        do
        {
            try info.write(toFile: filePath, atomically: true, encoding: .utf8)
            print("Success to write a file.\n")
        }
        catch
        {
            print("Error to write a file.\n")
        }
    }
    
    func writeArray(){
        let fruits = NSArray(objects: "Apple", "Banana", "Orange")
        let fruitsPath: String = NSHomeDirectory() + "/Documents/fruitsPath.plist"
        fruits.write(toFile: fruitsPath, atomically: true)
        print("Success to write an array.\n")
    }
    
    func writeDictionary(){
        var dictionary:Dictionary<String, String>
        dictionary = ["Software":"Xcode", "Language":"Swift"]
        let products = dictionary as NSDictionary
        let productsPath:String = NSHomeDirectory() + "/Documents/products.plist"
        products.write(toFile: productsPath, atomically: true)
        print("Success to write a dictionary.\n")
    }
    
    func writeImage(){
        let imagePath:String = NSHomeDirectory() + "/Documents/Pic.png"
        let image = UIImage(named: "1")
        let imageData:Data = UIImagePNGRepresentation(image!)!
        try? imageData.write(to: URL(fileURLWithPath: imagePath), options: [.atomic])
        print("Success to write an image.\n")
    }
    
    func copyFile(){
        let fileManage = FileManager.default
        let sourceUrl = NSHomeDirectory() + "/Documents/swift.txt"
        let targetUrl = NSHomeDirectory() + "/Documents/swift_bak.txt"
        do
        {
            try fileManage.copyItem(at: URL(fileURLWithPath: sourceUrl), to: URL(fileURLWithPath: targetUrl))
            print("Success to copy file")
        }
        catch
        {
            print("Failed to copy file")
        }
        
    }
    
    func moveFile(){
        let fileManager = FileManager.default
        let sourceUrl = NSHomeDirectory() + "/Documents/products.plist"
        let targetUrl = NSHomeDirectory() + "/Documents/backUp"
        do
        {
            try fileManager.moveItem(atPath: sourceUrl, toPath: targetUrl)
            print("Success to move file.")
        }
        catch
        {
            print("Failed to move file")
        }
    }
    
    func removefile(){
        let fileManage = FileManager.default
        let sourceUrl = NSHomeDirectory() + "/Document/Pic.png"
        do
        {
            try fileManage.removeItem(atPath: sourceUrl)
            print("Success to remove file")
        }
        catch
        {
            print("Failed to remove file")
        }
        
    }
    
//    func removeFolder(){
//        //首先获得文件管理对象，它的主要功能包括：读取文件中的数据、向一个文件中写入数据、删除或复制文件、移动文件、比较两个文件的内容或测试文件的存在性等。
//        let fileManager = FileManager.default
//        //创建一个字符串对象，该字符串对象表示文档目录。
//        let folder = NSHomeDirectory() + "/Documents/bak"
//        //获得文档目录下的所有内容，以及子文件夹下的内容，并存储在一个数组对象中。然后在控制台打印输出数组内容。
//        let files:[AnyObject]? = fileManager.subpaths(atPath: folder)! as [AnyObject]
//        for file in files!
//        {
//            do
//            {
//                try fileManager.removeItem(atPath: folder + "/\(file)")
//                print("Success to remove folder")
//            }
//            catch
//            {
//                print("Failed to remove folder")
//            }
//        }
//
//
//    }
    
    func fillPath(){
        //首先获得应用程序目录的路径，在该目录下有三个文件夹：文档目录、库目录、临时目录以及一个程序包。该目录就是应用程序的沙盒，应用程序只能访问该目录下的内容。
        //在控制台打印输出程序包主目录的路径。

        let homePath = NSHomeDirectory()
        print("homePath:\(homePath)")
        
        //系统会为每个程序，生成一个私有目录，并随即生成一个数字字母串作为目录名。在每次程序启动时，这个目录名称都是不同的。而使用此方法，则可以获得对应的目录集合。
        let documentPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        //获得并输出目录集合中的第一个元素，即沙箱中的文档目录。您应该将应用程序的所有数据文件，写入到这个目录下。这个目录通常用于存储用户数据。
        print("documentsPath1:\(documentPaths[0])")
        //创建一个字符串对象，该字符串对象同样表示沙箱中的文档目录。
        let documentPaths2 = NSHomeDirectory() + "/Documents"
        //在控制台打印输出该目录，并与上一条日志比较是否相同。
        print("documentsPath2:\(documentPaths2)")
        //使用相同的方式，获得沙箱下的库目录。这个目录下，包含两个子目录：缓存目录和参数目录。
        let libraryPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print("libraryPath1:\(libraryPaths[0])")
        //创建一个字符串对象，该字符串对象同样表示沙箱中的库目录。
        let libraryPath2 = NSHomeDirectory() + "/Library"
        print("libraryPath2:\(libraryPath2)")
        //使用相同的方式，获得沙箱下的缓存目录。
        let cachePaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        //获得并在控制台打印输出缓存目录。该目录用于存放应用程序专用的支持文件，保存应用程序再次启动过程中，需要的信息。
        print("cachePath1:\(cachePaths[0])")
        //创建一个字符串对象，该字符串对象同样表示沙箱中的缓存目录。然后在控制台打印输出该目录，并与上一条日志比较是否相同。
        let cachePath2 = NSHomeDirectory() + "/Library/Caches"
        print("cachePath2:\(cachePath2)")
        //创建一个常量，用来存储当前用户的临时路径。然后在控制台打印输出该目录。
        let tmpPath1 = NSTemporaryDirectory()
        print(tmpPath1)
        //创建一个字符串对象，该字符串对象同样表示沙箱中的临时目录。
        let tmpPath2 = NSHomeDirectory() + "/tmp"
        print(tmpPath2)
        /* ----------
        homePath:/var/mobile/Containers/Data/Application/9108D695-F75F-4495-9218-1BE17A52D865
        documentsPath1:/var/mobile/Containers/Data/Application/9108D695-F75F-4495-9218-1BE17A52D865/Documents
        documentsPath2:/var/mobile/Containers/Data/Application/9108D695-F75F-4495-9218-1BE17A52D865/Documents
        libraryPath1:/var/mobile/Containers/Data/Application/9108D695-F75F-4495-9218-1BE17A52D865/Library
        libraryPath2:/var/mobile/Containers/Data/Application/9108D695-F75F-4495-9218-1BE17A52D865/Library
        cachePath1:/var/mobile/Containers/Data/Application/9108D695-F75F-4495-9218-1BE17A52D865/Library/Caches
        cachePath2:/var/mobile/Containers/Data/Application/9108D695-F75F-4495-9218-1BE17A52D865/Library/Caches
        /private/var/mobile/Containers/Data/Application/9108D695-F75F-4495-9218-1BE17A52D865/tmp/
        /var/mobile/Containers/Data/Application/9108D695-F75F-4495-9218-1BE17A52D865/tmp */
 
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
