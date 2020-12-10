//
//  ViewController.swift
//  CircleLineDemo
//
//  Created by JanyGee on 2020/10/22.
//

import UIKit
import CRBoxInputView

class ViewController: UIViewController {
    let smallCircleView = CircleLineView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: .OneStart, strokColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
    let middleCircleView = CircleLineView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), type: .ZeroStart, strokColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
    let bigCircleView = CircleLineView(frame: CGRect(x: 0, y: 0, width: 150, height: 150), type: .OneStart, strokColor: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        smallCircleView.progressValue = 1
        smallCircleView.center = view.center
        view.addSubview(smallCircleView)


        middleCircleView.progressValue = 0.3
        middleCircleView.center = view.center
        view.addSubview(middleCircleView)


        bigCircleView.progressValue = 0.2
        bigCircleView.center = view.center
        view.addSubview(bigCircleView)
        
//        let boxInputView = CRBoxInputView(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
////        boxInputView.mainCollectionView()?.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//        boxInputView.boxFlowLayout?.itemSize = CGSize(width: 50, height: 50)
////        boxInputView.inputType = .number
//        boxInputView.loadAndPrepare(withBeginEdit: true)
//        boxInputView.center = view.center
//        view.addSubview(boxInputView)
        
    }

    @IBAction func clickButton(_ sender: Any) {
        
//        smallCircleView.progressValue = 0.2
//        middleCircleView.progressValue = 0.6
//        bigCircleView.progressValue = 0.8
    }
}

