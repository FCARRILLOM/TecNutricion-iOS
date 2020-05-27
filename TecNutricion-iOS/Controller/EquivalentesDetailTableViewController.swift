//
//  EquivalentesDetailTableViewController.swift
//  TecNutricion-iOS
//
//  Created by user168639 on 5/17/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class EquivalentesDetailTableViewController: UITableViewController {
    
    var grupo: GpoAlimenticio!
    
    var info: [EquivalenciaEntry] = equivalencias
    
    var selectedEquivalencia: [DetailEntry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EquivalenteDetailTableViewCell.self, forCellReuseIdentifier: "sectionCell")
        tableView.allowsSelection = false
        selectGrupo()
    }
    
    func selectGrupo() {
        for i in info {
            if i.grupo == grupo.name {
                selectedEquivalencia = i.entradas
            }
        }
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return selectedEquivalencia.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as! EquivalenteDetailTableViewCell

        cell.entry = selectedEquivalencia[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return EquivalenteDetailTableViewCell.CELL_HEIGHT
       }

}
