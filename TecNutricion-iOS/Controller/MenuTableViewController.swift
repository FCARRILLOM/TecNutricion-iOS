//
//  MenuTableViewController.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 14/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    let NUM_SECTIONS = 2
    
    var menuDelegate: MenuDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sectionCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NUM_SECTIONS
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath)
        
        let section = MenuSection(rawValue: indexPath.row)
        cell.textLabel?.text = section?.description

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectecSection = MenuSection(rawValue: indexPath.row) {
            menuDelegate?.handleSectionTap(forSection: selectecSection)
        }
    }
}

protocol MenuDelegate {
    func handleSectionTap(forSection section: MenuSection)
}
