//
//  EquivalentesDetailTableViewController.swift
//  TecNutricion-iOS
//
//  Created by user168639 on 5/17/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class EquivalentesDetailTableViewController: UITableViewController {
    
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var grupo: GpoAlimenticio!
    
    var info: [EquivalenciaEntry] = equivalencias
    
    var selectedEquivalencia: [DetailEntry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EquivalenteDetailTableViewCell.self, forCellReuseIdentifier: "sectionCell")
        tableView.allowsSelection = false
        selectGrupo()
        addTVCHeader()
    }
    
    func addTVCHeader() {
        let header = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT*0.08))
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT*0.06))
        title.backgroundColor = .theme
        title.center.x = header.center.x
        title.textAlignment = .center
        title.text = "Una porción equivale a..."
        title.font = UIFont(name: "Arial", size: 20.0)
        title.textColor = .white
        header.addSubview(title)
        self.tableView.tableHeaderView = header
        self.tableView.reloadData()
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
