//
//  MiPlanViewController.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 14/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class MiPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MiPlanCellDelegate, UIGestureRecognizerDelegate, showable {
    func setTouchable(touchable: Bool) {
        self.touchable = touchable
    }
    
    
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var NAVBAR_HEIGHT: CGFloat!
    var touchable: Bool!
    var menuDelegate: MenuDelegate!
    
    var tableView: UITableView!
    
    var listaGpos: [GpoAlimenticio]!

    override func viewDidLoad() {
        super.viewDidLoad()
        touchable = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideMenu))

        navigationController?.navigationBar.addGestureRecognizer(tap)
        title = "Mi Plan"
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        menuButtonItem.tintColor = .white
        navigationItem.leftBarButtonItem = menuButtonItem
        
        let saveButtonItem = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(savePlanButton))
        saveButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = saveButtonItem
        
        if let height = self.navigationController?.navigationBar.frame.height,
            let origin = self.navigationController?.navigationBar.frame.origin.y {
            NAVBAR_HEIGHT = origin + height
        } else {
            NAVBAR_HEIGHT = 40.0
        }
        
        createGroups()
        
        setupTableView()
        
        view.backgroundColor = UIColor.white
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
    
    @objc func savePlanButton() {
        var zeroes = true
        
        for g in listaGpos {
            if g.portions > 0 {
                zeroes = false
            }
        }
        
        if zeroes {
            let alert = UIAlertController(title: "Error", message: "Debe haber al menos un grupo alimenticio con porciones", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        savePlan()
    }
    
    // MARK: - Table View
    
    func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MiPlanTableViewCell.self, forCellReuseIdentifier: "celda")
        tableView.frame = CGRect(x: 0,
                                 y: NAVBAR_HEIGHT,
                                 width: SCREEN_WIDTH,
                                 height: SCREEN_HEIGHT - 40)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideMenu))
        tap.delegate = self
        tableView.addGestureRecognizer(tap)
        
        view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaGpos.count
    }
    
    @objc func hideMenu() {
        if !touchable {
            toggleMenu()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hideMenu()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! MiPlanTableViewCell
        cell.delegate = self
        
        cell.gpoAlim = listaGpos[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MiPlanTableViewCell.CELL_HEIGHT
    }
    
    // MARK: MiPlanCell Delegate
    
    func increasePortion(cell: MiPlanTableViewCell) {
        if let gpoAlim = cell.gpoAlim {
            let index = findGpoAlimIndex(grupo: gpoAlim)
            if index != -1 {
                listaGpos[index].portions += 1
                tableView.reloadData()
            }
        } else {
            print("Error al encontrar grupo")
        }
    }
    
    func decreasePortion(cell: MiPlanTableViewCell) {
        if let gpoAlim = cell.gpoAlim {
            let index = findGpoAlimIndex(grupo: gpoAlim)
            if index != -1 && gpoAlim.portions > 0 {
                listaGpos[index].portions -= 1
                tableView.reloadData()
            }
        } else {
            print("Error al encontrar grupo")
        }
    }
    
    func findGpoAlimIndex(grupo: GpoAlimenticio) -> Int {
        for i in 0...(listaGpos.count - 1) {
            if listaGpos[i] == grupo {
                return i
            }
        }
        
        return -1
    }
    
    // MARK: - Menu delegate
    
    // Enseña o esconde el menu
    @objc func toggleMenu() {
        touchable = !touchable
        menuDelegate?.handleMenuToggle()
    }
    
    
    func createGroups(){
        listaGpos = loadPlan()
        
        if listaGpos.count == 0 {
            listaGpos = GpoAlimenticio.NewBase()
        }
    }
    
    // MARK: Save/Load Data
    
    func dataFileURL() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathFile = url.appendingPathComponent("Plan.json")
        return pathFile
    }
    
    func savePlan() {
        do {
            let data = try JSONEncoder().encode(listaGpos)
            try data.write(to: dataFileURL())
            
            let alert = UIAlertController(title: "Cambios registrados", message: "Los cambios al plan han sido registrados correctamente", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        catch {
            print("Error saving mi plan data")
        }
    }
    
    func loadPlan() -> [GpoAlimenticio] {
        do {
            let data = try Data.init(contentsOf: dataFileURL())
            let newListaGpos = try JSONDecoder().decode([GpoAlimenticio].self, from: data)
            return newListaGpos
        }
        catch {
            print("Error loading mi plan data")
            return []
        }
    }
}
