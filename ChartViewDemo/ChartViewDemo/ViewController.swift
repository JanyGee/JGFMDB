//
//  ViewController.swift
//  ChartViewDemo
//
//  Created by Jany on 2020/10/24.
//  Copyright © 2020 Jany. All rights reserved.
//

import UIKit
import YTKKeyValueStore

class ViewController: UIViewController {
    
    fileprivate var _store : YTKKeyValueStore!
    fileprivate var _table : YTKTable!
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var baseScrollView: UIScrollView!
    @IBOutlet weak var baseWidth: NSLayoutConstraint!
    @IBOutlet weak var baseHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        do{
//            _store = try YTKKeyValueStore("dbtest.sqlite3")
//        }catch let error as NSError{
//            print(error.localizedDescription)
//            return
//        }
//
//        do{
//            try _store.createTable(tableName: "test_table")
//            _table = _store["test_table"]
//        }catch let error as NSError{
//            print(error.localizedDescription)
//            return
//        }
//
//        let str = "abc"
//        let num1 : NSNumber = 1
//        let num2 : NSNumber = 1.3
//        let user : Dictionary<String,AnyObject> = ["id":1 as AnyObject , "name" : "tangqiao" as AnyObject , "age" : 30 as AnyObject]
//
//        try! _table.put("str" <- str )
//        try! _table.put("num1" <- num1)
//        try! _table.put("num2" <- num2)
//        try! _table.put("user" <- user)
        
        
        view.backgroundColor = UIColor.darkGray
        
//        let chartView = ChartView()
//        chartView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 50, height: 300)
//        chartView.center = view.center
//        chartView.viewType = .moth
//        view.addSubview(chartView)
//        let data: [Int] = [322,443,543,600,567,499,789,555,443,543,367,567,443,543,765,567]
//        let time: [String] = ["10-12","10-13","10-14","10-15","10-16","10-17","10-18","10-19","10-16","10-17","10-18","10-19","10-16","10-17","10-18","10-19"]
//        chartView.loadView(data, time)
        
        baseScrollView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        baseWidth.constant = UIScreen.main.bounds.width
        //baseHeight.constant = UIScreen.main.bounds.height
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let user1 : Dictionary<String,AnyObject> = ["id":2 as AnyObject , "name" : "3232332" as AnyObject , "age" : 56 as AnyObject]
//        try! _table.put("user" <- user1)
        
        let userArr = ["dasdsa", "222e2e3", "3343543"]
        try! _table.put("userArr" <- userArr)
        
        if let result = try! _table.get("userArr")?.arrayValue{
            print(result)
        }else{

        }
    }

}

