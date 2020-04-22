//
//  RegistraComidaViewController.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 14/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class RegistraComidaViewController: UIViewController {
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var NAVBAR_HEIGHT: CGFloat!
    
    var menuDelegate: MenuDelegate!
    
    var tableView: UITableView!
    
    var listaGpos: [GpoAlimenticio]!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Agrega una comida"

        view.backgroundColor = UIColor.green

        createGroups()
        
        setupTableView()
        
        let menuButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(returnToMiDia))
            navigationItem.leftBarButtonItem = menuButtonItem
        
        let saveButtonItem = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(addFood))
            navigationItem.rightBarButtonItem = saveButtonItem


        view.backgroundColor = UIColor.white
    }
    
    @objc func addFood() {
        saveFood()
    }

    @objc func returnToMiDia() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table View
    
    func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MiPlanTableViewCell.self, forCellReuseIdentifier: "celdaComida")
        tableView.frame = CGRect(x: 0,
                                 y: NAVBAR_HEIGHT,
                                 width: SCREEN_WIDTH,
                                 height: SCREEN_HEIGHT - 60)
        
        view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaGpos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaComida", for: indexPath) as! MiPlanTableViewCell
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

    func createGroups(){
        listaGpos = loadPlan()
        
        if listaGpos.count == 0 {
            listaGpos = [
                GpoAlimenticio(name: "Vegetales", icon: "vegetales", portions: 0),
                GpoAlimenticio(name: "Carnes", icon: "vegetales", portions: 0),
                GpoAlimenticio(name: "Azucares", icon: "vegetales", portions: 0),
                GpoAlimenticio(name: "Cereales", icon: "vegetales", portions: 0),
                GpoAlimenticio(name: "Leguminosas", icon: "vegetales", portions: 0),
                GpoAlimenticio(name: "Frutas", icon: "vegetales", portions: 0),
                GpoAlimenticio(name: "Grasas", icon: "vegetales", portions: 0),
                GpoAlimenticio(name: "Agua", icon: "vegetales", portions: 0),
            ]
        }
    }

    // MARK: Save Data

    func dataFileURL() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathFile = url.appendingPathComponent("data.json")
        return pathFile
    }
    
    func saveFood() {
        do {
            let data = try JSONEncoder().encode(listaGpos)
            try data.write(to: dataFileURL())
        }
        catch {
            print("Error registering food data")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
