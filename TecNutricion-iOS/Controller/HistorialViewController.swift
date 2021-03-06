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

class HistorialViewController: UIViewController, historialManager, showable {
    
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var NAVBAR_HEIGHT: CGFloat!
    
    let SIDE_PADDING: CGFloat = 18
    let TOP_PADDING: CGFloat = 20
    
    let LINE_CHART_HEIGHT: CGFloat = 80
    
    let lineChartContainer = UIView()
    var valoresPeso: [(Date, Double)]  = []
    var valoresMasa: [(Date, Double)]  = []
    var valoresGrasa: [(Date, Double)]  = []
    
    var initialDatePicker: UIDatePicker!
    var finalDatePicker: UIDatePicker!
    let secondsInDay: Double = 24*60*60
    
    var initialLabel: UILabel!
    var finalLabel: UILabel!
    
    var menuDelegate: MenuDelegate!
    var axisFormatDelegate: IAxisValueFormatter!

    var touchable: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("iniclalizando HIstorial")
        touchable = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideMenu))
        navigationController?.navigationBar.addGestureRecognizer(tap)
        title = "Historial de C.C."
        
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        menuButtonItem.tintColor = .white
        navigationItem.leftBarButtonItem = menuButtonItem
        
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEntry))
        addButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = addButtonItem
        
        view.backgroundColor = .white
        
        if let height = self.navigationController?.navigationBar.frame.height,
            let origin = self.navigationController?.navigationBar.frame.origin.y {
            NAVBAR_HEIGHT = origin + height
        } else {
            NAVBAR_HEIGHT = 40.0
        }
        
        axisFormatDelegate = self
        setupLineCharts()
        
        initDatePickers()
        initLabels()
        
        setFrames()
        
        if FileManager.default.fileExists(atPath: dataFileURL().path) {
            loadInitData()
        } else {
            notifyNoData()
        }
        
        setupLineCharts()
        
        view.addGestureRecognizer(tap)
        
    }
    
    func setTouchable(touchable: Bool) {
        self.touchable = touchable
    }
    
    func notifyNoData() {
        let alert = UIAlertController(title: "Advertencia", message: "Aun no hay datos para mostrar", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Bar buttons
    // Enseña o esconde el menu
    @objc func toggleMenu() {
        touchable = !touchable
        menuDelegate?.handleMenuToggle()
    }
    
    @objc func hideMenu() {
        if !touchable {
            toggleMenu()
        }
    }
    
    @objc func addEntry() {
        let RegistraCMI = RegistraCMIViewController()
        RegistraCMI.delegate = self
        
        present(RegistraCMI, animated: true, completion: nil)
        
        print("Add entry")
    }
    
    // MARK: - Date Picker
    func initDatePickers() {
        initialDatePicker = UIDatePicker()
        initialDatePicker.datePickerMode = .date
        initialDatePicker.addTarget(self, action: #selector(updateLineChart), for: .valueChanged)
        
        // pone la fecha inicial a dos semanas antes
        //initialDatePicker.setDate(initialDate, animated: true)
        
        finalDatePicker = UIDatePicker()
        finalDatePicker.datePickerMode = .date
        finalDatePicker.addTarget(self, action: #selector(updateLineChart), for: .valueChanged)
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
        let LABEL_HEIGHT: CGFloat = 30
        
        let PICKER_HEIGHT: CGFloat = 80

        initialLabel.frame = CGRect(x: SIDE_PADDING,
                                    y: lineChartContainer.frame.origin.y + lineChartContainer.frame.height + TOP_PADDING,
                                    width: LABEL_WIDTH,
                                    height: LABEL_HEIGHT)
        
        initialDatePicker.frame = CGRect(x: 0,
                                         y: initialLabel.frame.origin.y + initialLabel.frame.height,
                                         width: SCREEN_WIDTH,
                                         height: PICKER_HEIGHT)
        
        finalLabel.frame = CGRect(x: SIDE_PADDING,
                                  y: initialDatePicker.frame.origin.y + initialDatePicker.frame.height + TOP_PADDING,
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
    func setupLineCharts() {
        let top_padding: CGFloat = 12
        
        lineChartContainer.frame = CGRect(x: 0,
                                          y: NAVBAR_HEIGHT,
                                          width: SCREEN_WIDTH,
                                          height: LINE_CHART_HEIGHT * 3 + top_padding * 4)
        let containerFrame = lineChartContainer.frame
        
        let chart_size: CGSize = CGSize(width: containerFrame.width, height: LINE_CHART_HEIGHT)
        let pesoLineChart = createLineChart(valores: valoresPeso, color: UIColor.systemGreen, label: "Peso", size: chart_size)
        pesoLineChart.frame.origin = CGPoint(x: 0,
                                             y: top_padding)
        
        let masaLineChart = createLineChart(valores: valoresMasa, color: UIColor.systemBlue, label: "Masa", size: chart_size)
        masaLineChart.frame.origin = CGPoint(x: 0,
                                             y: LINE_CHART_HEIGHT + top_padding * 2)
        
        let grasaLineChart = createLineChart(valores: valoresGrasa, color: UIColor.systemOrange, label:"Grasa", size: chart_size)
        grasaLineChart.frame.origin = CGPoint(x: 0,
                                              y: (LINE_CHART_HEIGHT * 2) + (top_padding * 3))
        
        lineChartContainer.addSubview(pesoLineChart)
        lineChartContainer.addSubview(masaLineChart)
        lineChartContainer.addSubview(grasaLineChart)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideMenu))
        lineChartContainer.addGestureRecognizer(tap)
        
        view.addSubview(lineChartContainer)
    }
    
    func createLineChart(valores: [(Date, Double)], color: UIColor, label: String, size: CGSize) -> LineChartView {
        let side_padding: CGFloat = 20
        let tempChartView = LineChartView()
        tempChartView.frame.size = size
        tempChartView.backgroundColor = .white
        tempChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInSine)
        tempChartView.isUserInteractionEnabled = false
        tempChartView.setViewPortOffsets(left: side_padding, top: side_padding,
                                         right: side_padding, bottom: side_padding)
        
        // no data
        tempChartView.noDataText = "No data available"
        
        var lineChartDataSets: [LineChartDataSet] = [LineChartDataSet]()
        
        // datos de peso
        var lineDataEntries: [ChartDataEntry] = []
        let tempXValues: [Int] = Array(0...valores.count)
        print(tempXValues)
        for i in 0..<valores.count {
            let dataPoint = ChartDataEntry(x: Double(tempXValues[i]), y: valores[i].1)
            lineDataEntries.append(dataPoint)
        }
        let chartDataSet = LineChartDataSet(entries: lineDataEntries, label: label)
        chartDataSet.colors = [color]
        chartDataSet.setCircleColor(color)
        chartDataSet.circleHoleColor = color
        chartDataSet.circleRadius = 4.0
        lineChartDataSets.append(chartDataSet)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        
        chartDataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
        
        // axis
        tempChartView.rightAxis.enabled = false
        tempChartView.leftAxis.enabled = false
        let xAxis = tempChartView.xAxis
        xAxis.drawLabelsEnabled = false
        xAxis.labelCount = valores.count
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.valueFormatter = axisFormatDelegate
          
        let lineChartData = LineChartData(dataSets: lineChartDataSets)
        if valores.count < 8 {
            lineChartData.setDrawValues(true)
        } else {
            lineChartData.setDrawValues(false)
        }
        lineChartData.setValueFont(NSUIFont.init(name: "arial", size: 12)!)
        
        tempChartView.legend.form = .circle
        tempChartView.legend.orientation = .horizontal
        tempChartView.legend.horizontalAlignment = .right
        tempChartView.legend.verticalAlignment = .bottom
        tempChartView.legend.font = NSUIFont.init(name: "arial", size: 12)!
        tempChartView.data = lineChartData
        
        return tempChartView
    }
    
    @objc func updateLineChart() {
        loadData()
        lineChartContainer.removeFromSuperview()
        setupLineCharts()
    }
    
    // MARK: - Load/Save Data
    
    func dataFileURL() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathFile = url.appendingPathComponent("historial.json")
        return pathFile
    }
    
    func loadData() {
        valoresPeso.removeAll()
        valoresMasa.removeAll()
        valoresGrasa.removeAll()
        
        var registros: [RegistroCMI] = []
        
        do {
            let data = try Data.init(contentsOf: dataFileURL())
            registros = try JSONDecoder().decode([RegistroCMI].self, from: data)
        } catch {
            print("Error obteniendo registros de CMI")
            return
        }
        
        for reg in registros {
            // checha que este entre las fechas indicadas
            if (dateGreater(d1: reg.dia, d2: initialDatePicker.date) || datesEqual(d1: reg.dia, d2: initialDatePicker.date)) && !dateGreater(d1: reg.dia, d2: finalDatePicker.date) {
                valoresPeso.append((reg.dia, reg.peso))
                valoresMasa.append((reg.dia, reg.masa))
                valoresGrasa.append((reg.dia, reg.grasa))
            }
        }
        
        /*
        x = [Date(timeIntervalSince1970: 1589148301), Date(timeIntervalSince1970: 1588889101), Date(timeIntervalSince1970: 1588802701), Date(timeIntervalSince1970: 1588716301)]
        y = [20,25,15,22]
        */
        
        //TODO: cambiar tres listas por una lista del objeto RegistroCMI y averiguar como hacer el sort
        valoresPeso.sort(by: { $0.0 < $1.0 })
        valoresMasa.sort(by: { $0.0 < $1.0 })
        valoresGrasa.sort(by: { $0.0 < $1.0 })
    }
    
    func loadInitData() {
        valoresPeso.removeAll()
        valoresMasa.removeAll()
        valoresGrasa.removeAll()
        
        var registros: [RegistroCMI] = []
        
        do {
            let data = try Data.init(contentsOf: dataFileURL())
            registros = try JSONDecoder().decode([RegistroCMI].self, from: data)
        } catch {
            print("Error obteniendo registros de CMI")
            return
        }
        
        for reg in registros {
            valoresPeso.append((reg.dia, reg.peso))
            valoresMasa.append((reg.dia, reg.masa))
            valoresGrasa.append((reg.dia, reg.grasa))
        }

        
        //TODO: cambiar tres listas por una lista del objeto RegistroCMI y averiguar como hacer el sort
        valoresPeso.sort(by: { $0.0 < $1.0 })
        valoresMasa.sort(by: { $0.0 < $1.0 })
        valoresGrasa.sort(by: { $0.0 < $1.0 })
        
        if valoresPeso.count < 5 {
            initialDatePicker.setDate(valoresPeso[0].0, animated: true)
            print("VALORES ", valoresPeso)
            return
        }
        
        valoresPeso = Array(valoresPeso.dropFirst(valoresPeso.count-5))
        valoresMasa = Array(valoresMasa.dropFirst(valoresMasa.count-5))
        valoresGrasa = Array(valoresGrasa.dropFirst(valoresGrasa.count-5))
        
        initialDatePicker.setDate(valoresPeso[0].0, animated: true)
        
        print("VALORES ", valoresPeso)
    }
    
    func saveData(registro: RegistroCMI) {
        //registro.dia = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: registro.dia)!
        
        do {
            if FileManager.default.fileExists(atPath: dataFileURL().path) {
                let saved = try Data.init(contentsOf: dataFileURL())
                var registros = try JSONDecoder().decode([RegistroCMI].self, from: saved)
                
                var found = false
                
                for reg in registros {
                    if datesEqual(d1: reg.dia, d2: registro.dia) {
                        found = true
                        reg.peso = registro.peso
                    }
                }
                
                if !found {
                    print("NO hay en fecha")
                    registros.append(registro)
                } else {
                    print("Fecha ya existe")
                }
                
                let data = try JSONEncoder().encode(registros)
                try data.write(to: dataFileURL())
                print(registros	)
            } else {
                let data = try JSONEncoder().encode([registro])
                try data.write(to: dataFileURL())
            }
        } catch {
            print("Error guardando datos")
        }
    }
    
    func addRegistro(registro: RegistroCMI) {
        // Mi logica para esto es que primero se guarda la data en el archivo, luego para updatear la grafica pues hay que sacar los datos del archivo con loadData y luego una vez que los arreglos x y y estan actualizados construimos otra vez la chart. Estoy seguro que debe de haber una mejor forma de hacer esto
        saveData(registro: registro)
        updateLineChart()
    }
    
    func datesEqual(d1: Date, d2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.component(.year, from: d1) == calendar.component(.year, from: d2) && calendar.component(.month, from: d1) == calendar.component(.month, from: d2) && calendar.component(.day, from: d1) == calendar.component(.day, from: d2)
        
    }
    
    func dateGreater(d1: Date, d2: Date) -> Bool {
        let calendar = Calendar.current
        if calendar.component(.year, from: d1) > calendar.component(.year, from: d2) {
            return true
        }
        
        if calendar.component(.year, from: d1) == calendar.component(.year, from: d2) {
            if calendar.component(.month, from: d1) > calendar.component(.month, from: d2) {
                return true
            }
            
            if calendar.component(.month, from: d1) == calendar.component(.month, from: d2) {
                return calendar.component(.day, from: d1) > calendar.component(.day, from: d2)
            }
        }
        
        return false
        
    }

}

extension HistorialViewController: IAxisValueFormatter {
  
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}

protocol historialManager {
    func addRegistro(registro: RegistroCMI)
}
