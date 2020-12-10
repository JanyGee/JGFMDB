//
//  IndicatorView.swift
//  ChartViewDemo
//
//  Created by Jany on 2020/10/24.
//  Copyright © 2020 Jany. All rights reserved.
//

import UIKit

class IndicatorView: UIView {

    fileprivate lazy var titleLabel: UILabel = {
        let t_Label = UILabel()
        t_Label.textAlignment = .center
        t_Label.font = UIFont.systemFont(ofSize: 15)
        t_Label.textColor = UIColor.white
        return t_Label
    }()
    
    fileprivate lazy var backLayer: CAShapeLayer = {
        let b_Layer = CAShapeLayer()
        b_Layer.fillColor = #colorLiteral(red: 1, green: 0.5401175022, blue: 0.1066650525, alpha: 1)
        return b_Layer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        layer.insertSublayer(backLayer, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTitle(title: String) -> Void {
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        let width = titleLabel.bounds.size.width
        let height = titleLabel.bounds.size.height
        self.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let path = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: height/2)
        backLayer.path = path.cgPath
    }
    
}
