//
//  Util.swift
//  ChartViewDemo
//
//  Created by Jany on 2020/10/25.
//  Copyright © 2020 Jany. All rights reserved.
//

import UIKit

class Util: NSObject {
    
    class func points(_ data: [ChartViewData]) -> [CGPoint] {
        
        if data.count<=0 {
            return [CGPoint]()
        }
        
        var ps: [CGPoint] = [CGPoint]()
        for i in 0..<data.count {
            let p = data[i].point
            ps.append(p)
        }
        
        return ps
    }
    
    class func openPath(points: Array<CGPoint>, isCurve: Bool) -> UIBezierPath? {
        closePath(points: points, isCurve: isCurve, maxY: -10086)
    }
    
    class func closePath(points: Array<CGPoint>, isCurve: Bool, maxY: CGFloat) -> UIBezierPath? {
        if points.count <= 0 {
            return nil
        }
        
        let isClose = maxY != -10086
        
        guard let p1: CGPoint = points.first else {
            return nil
        }
        
        let path = UIBezierPath()
        
        if isClose {
            path.move(to: CGPoint(x: p1.x, y: maxY))
            path.addLine(to: p1)
        } else {
            path.move(to: p1)
        }
        
        for i in 1..<points.count {
            let prePoint: CGPoint = points[i-1]
            let nextPoint: CGPoint = points[i]
            
            if isCurve {
                path.addCurve(to: nextPoint, controlPoint1: CGPoint(x: (nextPoint.x+prePoint.x)/2, y: prePoint.y), controlPoint2: CGPoint(x: (nextPoint.x+prePoint.x)/2, y: nextPoint.y))
            } else {
                path.addLine(to: nextPoint)
            }
            
            if i == points.count - 1 && isClose {
                path.addLine(to: CGPoint(x: nextPoint.x, y: maxY))
                path.close()
            }
        }
        
        return path
    }
    
    class func strokeAnimation() -> CAAnimation {
        let animate = CABasicAnimation(keyPath: "strokeEnd")
        animate.fromValue = 0
        animate.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animate.toValue = 1
        animate.duration = 1.5
        return animate
    }
    
    class func widthAnimation(toValue: CGFloat) -> CABasicAnimation {
        let animate = CABasicAnimation(keyPath: "bounds.size.width")
        animate.duration = 1.5
        animate.toValue = toValue
        animate.timingFunction = CAMediaTimingFunction.init(name: .easeOut)
        animate.fillMode = .forwards
        animate.autoreverses = false
        animate.isRemovedOnCompletion = false
        return animate
    }
    
    class func positionAnimation(path: CGPath?) -> CAAnimation {
        let animate = CAKeyframeAnimation(keyPath: "position")
        animate.duration = 1
        animate.path = path
        animate.isRemovedOnCompletion = false
        animate.autoreverses = false
        animate.fillMode = .both
        return animate
    }
}
