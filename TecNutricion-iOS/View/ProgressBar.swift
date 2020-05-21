//
//  ProgressBar.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 17/05/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//
// Tutorial: https://www.youtube.com/watch?v=dI1-LdKmTuk
//

import UIKit

class ProgressBar: UIView {
    
    let okColor: CGColor = UIColor.systemBlue.cgColor
    let errColor: CGColor = UIColor.systemRed.cgColor
    
    var backgroundLayer: CAShapeLayer!
    var foregroundLayer: CAShapeLayer!
    //var textLayer: CATextLayer!
    
    var progress: CGFloat = 0
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        // only draw layers once
        guard layer.sublayers == nil else {
            return
        }
        
        let width = rect.width
        let height = rect.height
        
        let lineWidth = 0.1 * min(width, height)
        
        backgroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.lightGray.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        
        foregroundLayer = createCircularLayer(rect: rect, strokeColor: okColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        
//        textLayer = createTextLayer(rect: rect, textColor: UIColor.blue.cgColor)
                
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(foregroundLayer)
        //layer.addSublayer(textLayer)
        
        updateProgress(progress: progress)
    }
    
    func createCircularLayer(rect: CGRect, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
        let width = rect.width
        let height = rect.height
                
        let center = CGPoint(x: width / 2, y: height / 2)
        let radius = (min(width, height) - lineWidth) / 2
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = strokeColor
        shapeLayer.fillColor = fillColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = .round
        
        return shapeLayer
    }
    
//    func createTextLayer(rect: CGRect, textColor: CGColor) -> CATextLayer {
//        let width = rect.width
//        let height = rect.height
//
//        let fontSize = min(width, height) / 3
//        let offset = min(width, height) * 0.1
//
//        let layer = CATextLayer()
//        layer.string = "\(Int(progress * 100))"
//        layer.backgroundColor = UIColor.clear.cgColor
//        layer.foregroundColor = textColor
//        layer.fontSize = fontSize
//        layer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width, height: fontSize + offset)
//        layer.alignmentMode = .center
//
//        return layer
//    }
    
    func updateProgress(progress: CGFloat) {
        self.progress = progress

        if foregroundLayer != nil {
            if progress > 1.0 {
                foregroundLayer.strokeColor = errColor
            } else {
                foregroundLayer.strokeColor = okColor
            }
            foregroundLayer.strokeEnd = progress
        }
    }
}