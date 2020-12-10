//
//  ChartView.swift
//  ChartViewDemo
//
//  Created by Jany on 2020/10/24.
//  Copyright © 2020 Jany. All rights reserved.
//

import UIKit
enum ChartViewType {
    case week
    case moth
}
class ChartView: UIView {
    
    open var viewType: ChartViewType = .week
    
    //数据线
    fileprivate lazy var lineShapeLayer: CAShapeLayer = {
        let l_Layer = CAShapeLayer()
        l_Layer.lineWidth = 5
        l_Layer.lineCap = .round
        l_Layer.lineJoin = .round
        l_Layer.strokeColor = #colorLiteral(red: 1, green: 0.5401175022, blue: 0.1066650525, alpha: 1)
        l_Layer.shadowOpacity = 1
        l_Layer.shadowRadius = 3
        l_Layer.shadowOffset = CGSize(width: 0, height: 10)
        l_Layer.shadowColor = #colorLiteral(red: 1, green: 0.5401175022, blue: 0.1066650525, alpha: 1)
        l_Layer.fillColor = UIColor.clear.cgColor
        return l_Layer
    }()
    
    //选中点
    fileprivate lazy var circleLayer: CAShapeLayer = {
        let c_Layer = CAShapeLayer()
        c_Layer.lineWidth = 5
        c_Layer.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        c_Layer.strokeColor = #colorLiteral(red: 1, green: 0.5401175022, blue: 0.1066650525, alpha: 1)
        //c_Layer.isHidden = true
        c_Layer.speed = 0
        c_Layer.fillColor = UIColor.white.cgColor
        c_Layer.path = UIBezierPath.init(ovalIn: c_Layer.frame).cgPath
        return c_Layer
    }()
    
    //显示数据
    fileprivate lazy var titleView: IndicatorView = {
        let indicator = IndicatorView()
        indicator.isHidden = true
        indicator.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        return indicator
    }()
    
    //显示线
    fileprivate lazy var indicatorLineLayer: CAShapeLayer = {
        let lineLayer = CAShapeLayer()
        lineLayer.strokeColor = #colorLiteral(red: 1, green: 0.5401175022, blue: 0.1066650525, alpha: 1)
        lineLayer.lineWidth = 1
        lineLayer.isHidden = true
        lineLayer.lineDashPattern = [5, 5]
        return lineLayer
    }()
    
    //渐变填充
    fileprivate lazy var gradientLayer: CAGradientLayer = {
        let g_Layer = CAGradientLayer()
        g_Layer.masksToBounds = true
        g_Layer.startPoint = CGPoint(x: 0, y: 0)
        g_Layer.endPoint = CGPoint(x: 0, y: 1)
        //g_Layer.frame = CGRect(x: 0, y: 0, width: self.bounds.w, height: self.bounds.height)
        g_Layer.colors = [#colorLiteral(red: 1, green: 0.5401175022, blue: 0.1066650525, alpha: 1).withAlphaComponent(0.3).cgColor, #colorLiteral(red: 1, green: 0.5401175022, blue: 0.1066650525, alpha: 1).withAlphaComponent(0.3).cgColor]
        //g_Layer.locations = [0.8, 0.9]
        return g_Layer
    }()
    
    //蒙版
    fileprivate lazy var clouseLayer: CAShapeLayer = {
        let c_Layer = CAShapeLayer()
        c_Layer.fillColor = UIColor.blue.cgColor
        c_Layer.lineJoin = .round
        c_Layer.lineCap = .round
        c_Layer.lineWidth = 1
        return c_Layer
    }()
    
    fileprivate lazy var bottomLayer: CAShapeLayer = {
        let b_Layer = CAShapeLayer()
        b_Layer.strokeColor = #colorLiteral(red: 1, green: 0.5401175022, blue: 0.1066650525, alpha: 1)
        return b_Layer
    }()
    
    internal var data: [ChartViewData] = [ChartViewData]()
    internal var preRect: CGRect = CGRect.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        addGestureRecognizer(tap)
        addGestureRecognizer(pan)

        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initUI(){

        let baseLayer = CALayer()
        baseLayer.addSublayer(gradientLayer)
        baseLayer.mask = clouseLayer
        layer.addSublayer(baseLayer)
        //layer.addSublayer(bottomLayer)
        layer.addSublayer(lineShapeLayer)
        layer.addSublayer(indicatorLineLayer)
        layer.addSublayer(circleLayer)
        
        addSubview(titleView)
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white
        
//        lineShapeLayer.add(Util.strokeAnimation(), forKey: nil)
//        gradientLayer.add(Util.widthAnimation(toValue: bounds.width * 2), forKey: "bw")
        
        layoutBottom()
    }
    
    open func loadView(_ dataArr: [Int], _ timeArr: [String]) -> Void {
        
        guard dataArr.count != 0, timeArr.count != 0 else { return }
        
        //画底部line
        //drawBottomLine(count: b_count)
        
        //数据线
        drawDataLine(dataArr, timeArr)
        
    }
    
    fileprivate func drawDataLine(_ dataArr: [Int], _ timeArr: [String]) -> Void {
        
        guard let maxValue: Int = dataArr.max() else {
            return
        }
        
        let count = dataArr.count
        let height = bounds.height
        let width = bounds.width
        let scaleY: CGFloat = (height - 70) / CGFloat(maxValue)
        let scaleX: CGFloat = (width-1)/CGFloat(count - 1)
        var dataPoints: [CGPoint] = [CGPoint]()
        
        let scaleWidth = width / CGFloat(count)
        
        for i in 0..<count {
            
            let value: Int = dataArr[i]
            let y = (height - scaleY * CGFloat(value)) - 30
            let point: CGPoint = CGPoint(x: scaleX * CGFloat(i), y: y)
            
            dataPoints.append(point)
            
            let d = ChartViewData(point, CGRect(x: scaleWidth * CGFloat(i), y: 0, width: scaleWidth, height: height), v: value, t: timeArr[i])
            data.append(d)
            
            if i == 1 {
                showIndicator(point, false, false, value)
            }
        }

        let path = Util.openPath(points: dataPoints, isCurve: true)
        lineShapeLayer.path = path?.cgPath
        
        let closePath = Util.closePath(points: dataPoints, isCurve: true, maxY: height)
        clouseLayer.path = closePath?.cgPath
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 0, height: height - 20)
        
        lineShapeLayer.removeAnimation(forKey: "lineAnimation")
        gradientLayer.removeAnimation(forKey: "bw")
        lineShapeLayer.add(Util.strokeAnimation(), forKey: "lineAnimation")
        gradientLayer.add(Util.widthAnimation(toValue: bounds.width * 2), forKey: "bw")
        
        circleLayer.timeOffset = 0
        circleLayer.removeAnimation(forKey: "circleLayer")
        circleLayer.add(Util.positionAnimation(path: path?.cgPath), forKey: "circleLayer")
    }
    
    fileprivate func showIndicator(_ touchPoint: CGPoint, _ start: Bool, _ end: Bool, _ val: Int) -> Void {
        var ratio = touchPoint.x / bounds.width
        ratio = fmin(fmax(0.0, ratio), 1.0)
        circleLayer.timeOffset = CFTimeInterval(ratio)
        //circleLayer.position = touchPoint
        
        if start == true {
            titleView.center = CGPoint(x: titleView.bounds.width / 2, y: touchPoint.y - 20)
        } else if end == true {
            titleView.center = CGPoint(x: bounds.width - titleView.bounds.width / 2, y: touchPoint.y - 20)
        } else {
            titleView.center = CGPoint(x: touchPoint.x, y: touchPoint.y - 20)
        }

        titleView.setTitle(title: String(val))
        
        let dashLinePath = UIBezierPath()
        dashLinePath.move(to: CGPoint(x: touchPoint.x, y: touchPoint.y))
        dashLinePath.addLine(to: CGPoint(x: touchPoint.x, y: bounds.height - 20))
        indicatorLineLayer.path = dashLinePath.cgPath

    }
    
    
    @objc fileprivate func tapGestureRecognized(recognized: UITapGestureRecognizer) -> Void {
        
        let point = recognized.location(in: self)
        
        if preRect.contains(point) {
            
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            titleView.isHidden = !titleView.isHidden
            //circleLayer.isHidden = !circleLayer.isHidden
            indicatorLineLayer.isHidden = !indicatorLineLayer.isHidden
            CATransaction.commit()
            
        } else {
            
            showIndicator(hidden: false)

            for i in 0..<data.count {
                let d: ChartViewData = data[i]
                if d.rect.contains(point) {
                    
                    preRect = d.rect
                    
                    if i == 0 {
                        showIndicator(d.point, true, false, d.value)
                    } else if i == data.count - 1 {
                        showIndicator(d.point, false, true, d.value)
                    } else {
                        showIndicator(d.point, false, false, d.value)
                    }
                }
            }
        }
    }
    
    @objc fileprivate func panGestureRecognized(recognized: UIPanGestureRecognizer) -> Void {
        
        showIndicator(hidden: false)
        let point = recognized.location(in: self)
        
        for i in 0..<data.count {
            let d: ChartViewData = data[i]
            if d.rect.contains(point) {
                
                preRect = d.rect
                
                if i == 0 {
                    showIndicator(d.point, true, false, d.value)
                } else if i == data.count - 1 {
                    showIndicator(d.point, false, true, d.value)
                } else {
                    showIndicator(d.point, false, false, d.value)
                }
            }
        }
    }
    
    fileprivate func layoutBottom() -> Void {
        
        if viewType == .week {
            let weeks: [String] = ["日", "一", "二", "三", "四", "五", "六"]
            let height = bounds.height
            let width = bounds.width
            let scaleX: CGFloat = (width)/6
            for i in 0..<7 {
                let t: String = weeks[i]
                let x = scaleX * CGFloat(i)
                var rect: CGRect
                
                if i == 0  {
                    rect = CGRect(x: x, y: height - 12, width: 13, height: 12)
                } else if i == 6 {
                    rect = CGRect(x: x - 13, y: height - 12, width: 13, height: 12)
                } else {
                    rect = CGRect(x: x - 13/2, y: height - 12, width: 13, height: 12)
                }
                
                let label = UILabel(frame: rect)
                label.font = UIFont.systemFont(ofSize: 12)
                label.textColor = #colorLiteral(red: 1, green: 0.5401175022, blue: 0.1066650525, alpha: 1)
                label.text = t
                self.addSubview(label)
            }
        }
    }
    
    fileprivate func showIndicator(hidden: Bool) -> Void {
        if titleView.isHidden == hidden {
            return
        }
        titleView.isHidden = hidden
        //circleLayer.isHidden = hidden
        indicatorLineLayer.isHidden = hidden
    }
    
    fileprivate func drawBottomLine(count: Int) -> Void {
        
        //月份不能打点，因为月份数据点不确定，无法确定点位
        if viewType == .week {
            
            let path = UIBezierPath.init(roundedRect: CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1), cornerRadius: 0)
            let width = bounds.width
            let tmp: CGFloat = (width-1)/CGFloat(count - 1)
            let y = bounds.height - 3
            
            for i in 0...count {
                let x: CGFloat = tmp * CGFloat(i)
                let p = UIBezierPath.init(roundedRect: CGRect(x: x, y: y, width: 1, height: 3), cornerRadius: 0)
                path.append(p)
            }
            
            bottomLayer.path = path.cgPath

        } else {
            let path = UIBezierPath.init(roundedRect: CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1), cornerRadius: 0)
            let width = bounds.width
            let tmp: CGFloat = (width-1)/CGFloat(3 - 1)
            let y = bounds.height - 3
            
            for i in 0...3 {
                let x: CGFloat = tmp * CGFloat(i)
                let p = UIBezierPath.init(roundedRect: CGRect(x: x, y: y, width: 1, height: 3), cornerRadius: 0)
                path.append(p)
            }
            
            bottomLayer.path = path.cgPath
        }
    }
}
