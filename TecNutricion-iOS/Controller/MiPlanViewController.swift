//
//  MiPlanViewController.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 14/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class MiPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MiPlanCellDelegate {
    
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var NAVBAR_HEIGHT: CGFloat!
    
    var menuDelegate: MenuDelegate!
    
    var tableView: UITableView!
    
    var listaGpos: [GpoAlimenticio]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NAVBAR_HEIGHT = self.navigationController?.navigationBar.bounds.height
        
        title = "Mi Plan"
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        navigationItem.leftBarButtonItem = menuButtonItem
        
        let saveButtonItem = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(savePlanButton))
        navigationItem.rightBarButtonItem = saveButtonItem
        
        createGroups()
        
        setupTableView()
        
        view.backgroundColor = UIColor.white
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
        
        view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaGpos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! MiPlanTableViewCell
        cell.delegate = self
        
        cell.gpoAlim = listaGpos[indexPath.row]

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
        menuDelegate?.handleMenuToggle()
    }
    
    
    func createGroups(){
        listaGpos = loadPlan()
        
        if listaGpos.count == 0 {
            listaGpos = [
                GpoAlimenticio(name: "Vegetales", icon: "carrot-icon", portions: 0),
                GpoAlimenticio(name: "Carnes", icon: "meat-icon", portions: 0),
                GpoAlimenticio(name: "Azucares", icon: "candy-icon", portions: 0),
                GpoAlimenticio(name: "Cereales", icon: "wheat-icon", portions: 0),
                GpoAlimenticio(name: "Leguminosas", icon: "pea-icon", portions: 0),
                GpoAlimenticio(name: "Frutas", icon: "apple", portions: 0),
                GpoAlimenticio(name: "Grasas", icon: "avocado-icon", portions: 0),
                GpoAlimenticio(name: "Leche", icon: "milk-icon", portions: 0),
                GpoAlimenticio(name: "Agua", icon: "milk-icon", portions: 0),
            ]
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
