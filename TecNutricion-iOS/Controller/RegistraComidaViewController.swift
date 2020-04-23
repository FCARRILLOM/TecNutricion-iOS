//
//  RegistraComidaViewController.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 14/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class RegistraComidaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MiPlanCellDelegate {
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var NAVBAR_HEIGHT: CGFloat!
    
    let MiDiaData: MiDiaDataManager!
    
    var tableView: UITableView!
    
    var listaGpos: [GpoAlimenticio]!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        NAVBAR_HEIGHT = 70

        view.backgroundColor = UIColor.green

        createGroups()
        
        setupTableView()
        
        setupTitle(title: "Agrega una comida")
        
        setupSaveButton()

        view.backgroundColor = UIColor.white
    }
    
    @objc func addFood(_ sender:UIButton!) {
        saveFood()
        returnToMiDia()
    }

    @objc func returnToMiDia() {
        dismiss(animated: true, completion: nil)
    }

    func setupTitle(title: String) {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 0, width: 150, height: 50)
        label.center.x = self.view.center.x
        label.text = title
        view.addSubview(label)
    }

    func setupSaveButton() {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: self.view.center.x-75, y: SCREEN_HEIGHT - 150, width: 120, height: 50)

        button.setTitle("Guardar", for: .normal)
        button.backgroundColor = .lightGray

        button.addTarget(self, action: #selector(addFood(_:)), for: .touchUpInside)

        view.addSubview(button)
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

    // MARK: Save Data

    func dataFileURL() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathFile = url.appendingPathComponent("data.json")
        return pathFile
    }
    
    func saveFood() {
        do {
            var oldData = loadFoodForToday()
            if oldData.count != 0 {
                for i in 0...(oldData.count - 1) {
                    let newIndex = findGpoAlimIndex(grupo: oldData[i])

                    oldData[i].portions += listaGpos[newIndex].portions

                }

            }
            else {
                oldData = listaGpos
            }

            let data = try JSONEncoder().encode(oldData)
            try data.write(to: dataFileURL())
            MiDiaData.updateData(newData: oldData)
        }
        catch {
            print("Error registering food data")
        }
    }

    func loadFoodForToday() -> [GpoAlimenticio] {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
