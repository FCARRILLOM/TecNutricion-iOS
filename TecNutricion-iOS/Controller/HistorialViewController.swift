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

class HistorialViewController: UIViewController, historialManager {
    
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var NAVBAR_HEIGHT: CGFloat!
    
    let SIDE_PADDING: CGFloat = 18
    let TOP_PADDING: CGFloat = 20
    
    let lineChartView = LineChartView()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        print("iniclalizando HIstorial")
        NAVBAR_HEIGHT = self.navigationController?.navigationBar.bounds.height
        
        title = "Historial de C.C."
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        menuButtonItem.tintColor = .white
        navigationItem.leftBarButtonItem = menuButtonItem
        
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEntry))
        addButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = addButtonItem
        
        view.backgroundColor = .white
        
        axisFormatDelegate = self
        
        setupLineChart()
        initDatePickers()
        initLabels()
        setFrames()
        
        if FileManager.default.fileExists(atPath: dataFileURL().path) {
            updateLineChart()
        } else {
            notifyNoData()
        }
    }
    
    func notifyNoData() {
        let alert = UIAlertController(title: "Advertencia", message: "Aun no hay datos para mostrar", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Bar buttons
    // Enseña o esconde el menu
    @objc func toggleMenu() {
        menuDelegate?.handleMenuToggle()
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
        initialDatePicker.setDate(Date().addingTimeInterval(-14*secondsInDay), animated: true)
        
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
        
        var allLineChartDataSets: [LineChartDataSet] = [LineChartDataSet]()
        
        // datos de peso
        var lineDataEntries1: [ChartDataEntry] = []
        for i in 0..<valoresPeso.count {
            let dataPoint = ChartDataEntry(x: Double(valoresPeso[i].0.timeIntervalSince1970), y: valoresPeso[i].1)
            lineDataEntries1.append(dataPoint)
        }
        let chartDataSet1 = LineChartDataSet(entries: lineDataEntries1, label: "Peso")
        chartDataSet1.colors = [UIColor.systemGreen]
        chartDataSet1.setCircleColor(UIColor.systemGreen)
        chartDataSet1.circleHoleColor = UIColor.systemGreen
        chartDataSet1.circleRadius = 4.0
        allLineChartDataSets.append(chartDataSet1)
        
        // datos de masa
        var lineDataEntries2: [ChartDataEntry] = []
        for i in 0..<valoresMasa.count {
            let dataPoint = ChartDataEntry(x: Double(valoresMasa[i].0.timeIntervalSince1970), y: valoresMasa[i].1)
            lineDataEntries2.append(dataPoint)
        }
        let chartDataSet2 = LineChartDataSet(entries: lineDataEntries2, label: "Masa")
        chartDataSet2.colors = [UIColor.systemBlue]
        chartDataSet2.setCircleColor(UIColor.systemBlue)
        chartDataSet2.circleHoleColor = UIColor.systemBlue
        chartDataSet2.circleRadius = 4.0
        allLineChartDataSets.append(chartDataSet2)
        
        // datos de grasa
        var lineDataEntries3: [ChartDataEntry] = []
        for i in 0..<valoresGrasa.count {
            let dataPoint = ChartDataEntry(x: Double(valoresGrasa[i].0.timeIntervalSince1970), y: valoresGrasa[i].1)
            lineDataEntries3.append(dataPoint)
        }
        let chartDataSet3 = LineChartDataSet(entries: lineDataEntries3, label: "Grasa")
        chartDataSet3.colors = [UIColor.systemYellow]
        chartDataSet3.setCircleColor(UIColor.systemYellow)
        chartDataSet3.circleHoleColor = UIColor.systemYellow
        chartDataSet3.circleRadius = 4.0
        allLineChartDataSets.append(chartDataSet3)
        
        // axis
        lineChartView.rightAxis.enabled = false
        let xAxis = lineChartView.xAxis
        xAxis.labelCount = valoresPeso.count
        xAxis.granularityEnabled = true
        xAxis.granularity = 1.0
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.valueFormatter = axisFormatDelegate
          
        let lineChartData = LineChartData(dataSets: allLineChartDataSets)
        lineChartView.data = lineChartData
        view.addSubview(lineChartView)
    }
    
    @objc func updateLineChart() {
        loadData()
        lineChartView.removeFromSuperview()
        setupLineChart()
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
            if reg.dia >= initialDatePicker.date
                && reg.dia <= (finalDatePicker.date.addingTimeInterval(secondsInDay)) {
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
