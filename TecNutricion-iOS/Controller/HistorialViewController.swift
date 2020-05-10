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
    var x = [Date]()
    var y = [Double]()
    
    var initialDatePicker: UIDatePicker!
    var finalDatePicker: UIDatePicker!
    
    var initialLabel: UILabel!
    var finalLabel: UILabel!
    
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
        
        initDatePickers()
        initLabels()
        setFrames()
    }
    
    
    // MARK: - Bar buttons
    // Enseña o esconde el menu
    @objc func toggleMenu() {
        menuDelegate?.handleMenuToggle()
    }
    
    @objc func addEntry() {
        print("Add entry")
    }
    
    // MARK: - Date Picker
    func initDatePickers() {
        initialDatePicker = UIDatePicker()
        initialDatePicker.datePickerMode = .date
        
        finalDatePicker = UIDatePicker()
        finalDatePicker.datePickerMode = .date
    }
    
    func initLabels() {
        initialLabel = UILabel()
        initialLabel.text = "Fecha inicial"
        initialLabel.font = UIFont(name: "Arial", size: 18)
        initialLabel.textAlignment = .left
        initialLabel.textColor = UIColor.black
        
        finalLabel = UILabel()
        finalLabel.text = "Fecha final"
        finalLabel.font = UIFont(name: "Arial", size: 18)
        finalLabel.textAlignment = .left
        finalLabel.textColor = UIColor.black
    }
    
    func setFrames() {
        let LABEL_WIDTH: CGFloat = 180
        let LABEL_HEIGHT: CGFloat = 40
        
        let PICKER_HEIGHT: CGFloat = 80

        initialLabel.frame = CGRect(x: SIDE_PADDING,
                                    y: lineChartView.frame.origin.y + lineChartView.frame.height + TOP_PADDING,
                                    width: LABEL_WIDTH,
                                    height: LABEL_HEIGHT)
        
        initialDatePicker.frame = CGRect(x: 0,
                                         y: initialLabel.frame.origin.y + initialLabel.frame.height,
                                         width: SCREEN_WIDTH,
                                         height: PICKER_HEIGHT)
        
        finalLabel.frame = CGRect(x: SIDE_PADDING,
                                  y: initialDatePicker.frame.origin.y + initialDatePicker.frame.height + TOP_PADDING/2,
                                  width: LABEL_WIDTH,
                                  height: LABEL_HEIGHT)
        
        finalDatePicker.frame = CGRect(x: 0,
                                    y: finalLabel.frame.origin.y + finalLabel.frame.height,
                                    width: SCREEN_WIDTH,
                                    height: PICKER_HEIGHT)
        
        view.addSubview(initialDatePicker)
        view.addSubview(finalDatePicker)
        view.addSubview(initialLabel)
        view.addSubview(finalLabel)
    }
    
    // MARK: - Charts
    func setupLineChart() {
        lineChartView.frame = CGRect(x: 0, y: NAVBAR_HEIGHT + TOP_PADDING, width: SCREEN_WIDTH, height: (SCREEN_HEIGHT - NAVBAR_HEIGHT) / 2)
        lineChartView.backgroundColor = .white
        lineChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInSine)
        lineChartView.legend.form = .circle
        
        // no data
        lineChartView.noDataText = "No data available"
        
        // population
        for i in 0..<x.count {
            let dataPoint = ChartDataEntry(x: Double(x[i].timeIntervalSince1970), y: y[i])
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
        xAxis.valueFormatter = axisFormatDelegate
          
        lineChartView.data = chartData
        view.addSubview(lineChartView)
    }
    
    func loadData() {
        x = [Date(timeIntervalSince1970: 1589148301), Date(timeIntervalSince1970: 1588889101), Date(timeIntervalSince1970: 1588802701), Date(timeIntervalSince1970: 1588716301)]
        y = [20,30,40,20]
    }
}

extension ViewController: IAxisValueFormatter {
  
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}