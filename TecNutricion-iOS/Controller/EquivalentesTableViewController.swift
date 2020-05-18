//
//  EquivalentesTableViewController.swift
//  TecNutricion-iOS
//
//  Created by user168639 on 5/17/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class EquivalentesTableViewController: UITableViewController {
    
    let grupos = [
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
    
    var menuDelegate: MenuDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EquivalenteTableViewCell.self, forCellReuseIdentifier: "sectionCell")
        
        title = "Equivalentes"
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        navigationItem.leftBarButtonItem = menuButtonItem
    }
    
    // MARK: - Menu delegate
    
    // Enseña o esconde el menu
    @objc func toggleMenu() {
        menuDelegate?.handleMenuToggle()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return grupos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as! EquivalenteTableViewCell

        cell.gpoAlim = grupos[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eqView = EquivalentesDetailTableViewController()
        
        eqView.grupo = grupos[indexPath.row]
        
        present(eqView, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EquivalenteTableViewCell.CELL_HEIGHT
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
