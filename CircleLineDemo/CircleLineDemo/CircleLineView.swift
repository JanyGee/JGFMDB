//
//  CircleLineView.swift
//  CircleLineDemo
//
//  Created by JanyGee on 2020/10/22.
//

import UIKit
enum CircleLineViewType {
    case ZeroStart //第一种：0 -- CGFloat(Double.pi) * 2
    case OneStart //第二种：pi -- CGFloat(Double.pi) * 3
}
class CircleLineView: UIView {
    
    let lineWidth: CGFloat = 10
    open var strokeColor: UIColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    open var circleType: CircleLineViewType = .ZeroStart
    
    open var progressValue: CGFloat {
        willSet{
            progressLayer.strokeEnd = newValue
            animateP.toValue = newValue
        }
        didSet{
            animateP.fromValue = oldValue
            progressLayer.add(animateP, forKey: nil)
            setNeedsDisplay()
        }
    }
    
    fileprivate lazy var bgLayer: CAShapeLayer = {
        
        let circelPath = UIBezierPath(arcCenter: center, radius: (bounds.width - lineWidth) / 2, startAngle: -CGFloat(Double.pi) / 2, endAngle: CGFloat(Double.pi) / 2 * 3, clockwise: true)
        #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1).set()
        circelPath.lineWidth = lineWidth
        circelPath.stroke()
        
        let bgLayer = CAShapeLayer()
        bgLayer.frame = bounds
        bgLayer.fillColor = UIColor.clear.cgColor
        bgLayer.lineWidth = lineWidth
        bgLayer.strokeColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1).cgColor
        bgLayer.strokeStart = 0
        bgLayer.strokeEnd = 1
        bgLayer.lineCap = .round
        bgLayer.path = circelPath.cgPath
        return bgLayer
    }()
    
    fileprivate lazy var progressLayer: CAShapeLayer = {
        
        var startP: CGFloat = 0.0
        var endP: CGFloat = 0.0
        if circleType == .ZeroStart {
            startP = 0
            endP = CGFloat(Double.pi) * 2
        } else {
            startP = CGFloat(Double.pi)
            endP = CGFloat(Double.pi) * 3
        }
        
        let circelPath = UIBezierPath(arcCenter: center, radius: (bounds.width - lineWidth) / 2, startAngle: startP, endAngle: endP, clockwise: true)
        UIColor.clear.set()
        circelPath.lineWidth = lineWidth
        circelPath.stroke()
        
        let pLayer = CAShapeLayer()
        pLayer.frame = bounds
        pLayer.fillColor = UIColor.clear.cgColor
        pLayer.lineWidth = lineWidth
        pLayer.strokeColor = strokeColor.cgColor
        pLayer.strokeStart = 0
        pLayer.strokeEnd = progressValue
        pLayer.lineCap = .round
        pLayer.path = circelPath.cgPath
        return pLayer
    }()
    
    fileprivate lazy var animateP: CABasicAnimation = {
        let ani = CABasicAnimation(keyPath: "strokeEnd")
        ani.toValue = 0
        ani.fromValue = 0
        ani.duration = 0.5
        ani.fillMode = .forwards
        ani.isRemovedOnCompletion = false
        return ani
    }()
    
    override init(frame: CGRect) {
        
        progressValue = 0.0
        
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    convenience init(frame: CGRect, type: CircleLineViewType, strokColor: UIColor) {
        self.init(frame: frame)
        strokeColor = strokColor
        circleType = type
        createLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createLayer() -> Void {
        layer.addSublayer(bgLayer)
        layer.addSublayer(progressLayer)
    }
    
}
