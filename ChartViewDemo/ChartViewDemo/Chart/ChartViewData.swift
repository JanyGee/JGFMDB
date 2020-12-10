//
//  ChartViewData.swift
//  ChartViewDemo
//
//  Created by Jany on 2020/10/25.
//  Copyright © 2020 Jany. All rights reserved.
//

import UIKit

struct ChartViewData {
    var title: String = ""
    var value: Int = 0
    var point: CGPoint = CGPoint(x: 0, y: 0)
    var rect: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    init(_ p: CGPoint, _ r: CGRect, v: Int, t: String) {
        point = p
        rect = r
        value = v
        title = t
    }
}
