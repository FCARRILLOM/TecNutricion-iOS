//
//  HistorialViewController.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 09/05/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//
// tutorial: https://medium.com/@felicity.johnson.mail/lets-make-some-charts-ios-charts-5b8e42c20bc9
//

import UIKit
import Charts

class HistorialViewController: UIViewController {
    
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var NAVBAR_HEIGHT: CGFloat!
    
    let SIDE_PADDING: CGFloat = 18
    let TOP_PADDING: CGFloat = 20
    
    let lineChartView = LineChartView()
    var lineDataEntry: [ChartDataEntry] = []
    // datos dummy
    var x = [Double]()
    var y = [Double]()
    
    var menuDelegate: MenuDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        NAVBAR_HEIGHT = self.navigationController?.navigationBar.bounds.height
        
        title = "Historial de CMI"
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        navigationItem.leftBarButtonItem = menuButtonItem
        
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEntry))
        
        navigationItem.rightBarButtonItem = addButtonItem
        
        view.backgroundColor = .white
        
        loadData()
        
        setupLineChart()
    }
    
    // MARK: - Bar buttons
    
    // Enseña o esconde el menu
    @objc func toggleMenu() {
        menuDelegate?.handleMenuToggle()
    }
    
    @objc func addEntry() {
        print("Add entry")
    }
    
    // MARK: - Charts
    func setupLineChart() {
        lineChartView.frame = CGRect(x: 0, y: NAVBAR_HEIGHT + TOP_PADDING*2, width: SCREEN_WIDTH, height: (SCREEN_HEIGHT - NAVBAR_HEIGHT) / 2)
        lineChartView.backgroundColor = .white
        lineChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInSine)
        lineChartView.legend.form = .circle
        
        // no data
        lineChartView.noDataText = "No data available"
        
        // population
        for i in 0..<x.count {
            let dataPoint = ChartDataEntry(x: x[i], y: y[i])
            lineDataEntry.append(dataPoint)
        }
        
        let chartDataSet = LineChartDataSet(entries: lineDataEntry, label: "CMI")
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartDataSet.colors = [UIColor.systemGreen]
        chartDataSet.setCircleColor(UIColor.systemGreen)
        chartDataSet.circleHoleColor = UIColor.systemGreen
        chartDataSet.circleRadius = 4.0
        
        // gradient
        let gradientColors = [UIColor.systemGreen.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else { print("error loading gradient"); return }
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        chartDataSet.drawFilledEnabled = true
        
        // axis
        lineChartView.rightAxis.enabled = false
        let xAxis = lineChartView.xAxis
        xAxis.labelCount = x.count
        xAxis.granularityEnabled = true
        xAxis.granularity = 1.0
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        
        
        lineChartView.data = chartData
        view.addSubview(lineChartView)
    }
    
    func loadData() {
        x = [1,2,3,4,5,6,7]
        y = [20,30,40,20,40,34,55]
    }
}
