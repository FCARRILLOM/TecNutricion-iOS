//
//  MiPlanViewController.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 14/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class MiPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var NAVBAR_HEIGHT: CGFloat!
    
    var delegate: MenuDelegate!
    
    var tableView: UITableView!
    
    var listaGpos: [GpoAlimenticio]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NAVBAR_HEIGHT = self.navigationController?.navigationBar.bounds.height
        
        title = "Mi Plan"
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        navigationItem.leftBarButtonItem = menuButtonItem
        
        createGroups()
        
        setupTableView()
        
        view.backgroundColor = UIColor.white
    }
    
    func createGroups(){
        listaGpos = [
            GpoAlimenticio(name: "Vegetales", icon: UIImage(named: "vegetales")!, portions: 0),
            GpoAlimenticio(name: "Carnes", icon: UIImage(named: "vegetales")!, portions: 0),
            GpoAlimenticio(name: "Azucares", icon: UIImage(named: "vegetales")!, portions: 0),
            GpoAlimenticio(name: "Cereales", icon: UIImage(named: "vegetales")!, portions: 0),
            GpoAlimenticio(name: "Leguminosas", icon: UIImage(named: "vegetales")!, portions: 0),
            GpoAlimenticio(name: "Frutas", icon: UIImage(named: "vegetales")!, portions: 0),
            GpoAlimenticio(name: "Grasas", icon: UIImage(named: "vegetales")!, portions: 0),]
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
        
        cell.gpoAlim = listaGpos[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MiPlanTableViewCell.CELL_HEIGHT
    }
    
    // MARK: - Menu
    // Enseña o esconde el menu
    @objc func toggleMenu() {
        delegate?.handleMenuToggle()
    }

}
