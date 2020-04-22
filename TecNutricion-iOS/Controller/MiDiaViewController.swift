//
//  MiDiaViewController.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 14/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class MiDiaViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var NAVBAR_HEIGHT: CGFloat!
    
    var delegate: MenuDelegate!
    var collectionView: UICollectionView!
    
    var listaGpos: [GpoAlimenticio]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Mi Día"
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        navigationItem.leftBarButtonItem = menuButtonItem
        
        createGroups()

        setupCollectionView()

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
        let layout: UICollectionViewLayout = UICollectionViewLayout()

        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layour.itemSize = CGSize(width:60, height: 60)

        collectionView = UICollectionView(frame: selfe.view.frame, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(MiDiaCollectionViewCell.self, forCellReuseIdentifier: "miDiaCell")
        view.addSubview(collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaGpos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "miDiaCell", for: indexPath)
            myCell.gpoAlim = listaGpos[indexPath.row]
            return myCell
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! MiPlanTableViewCell
        
        cell.gpoAlim = listaGpos[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MiPlanTableViewCell.CELL_HEIGHT
    }

    // Enseña o esconde el menu
    @objc func toggleMenu() {
        delegate?.handleMenuToggle()
    }
}
