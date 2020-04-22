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
        NAVBAR_HEIGHT = self.navigationController?.navigationBar.bounds.height
        
        title = "Mi Día"
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        navigationItem.leftBarButtonItem = menuButtonItem
        
        createGroups()

        setupCollectionView()
        
        setupAddFoodButton()

        view.backgroundColor = UIColor.white
    }

     func createGroups(){
        listaGpos = [
            GpoAlimenticio(name: "Vegetales", icon: "Apple", portions: 0),
            GpoAlimenticio(name: "Carnes", icon: "Apple", portions: 0),
            GpoAlimenticio(name: "Azucares", icon: "Apple", portions: 0),
            GpoAlimenticio(name: "Cereales", icon: "Apple", portions: 0),
            GpoAlimenticio(name: "Leguminosas", icon: "Apple", portions: 0),
            GpoAlimenticio(name: "Frutas", icon: "Apple", portions: 0),
            GpoAlimenticio(name: "Grasas", icon: "Apple", portions: 0),
            GpoAlimenticio(name: "Agua", icon: "Apple", portions: 0),
        ]
    }
    
    // MARK: - Table View
    func setupCollectionView() {
        let layout: UICollectionViewLayout = MiDiaCollectionViewFlowLayout()

        collectionView = UICollectionView(frame: CGRect(x: 10,
                                                        y: NAVBAR_HEIGHT+10,
                                                        width: SCREEN_WIDTH - 20,
                                                        height: SCREEN_HEIGHT - 100),
                                                        collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MiDiaCollectionViewCell.self, forCellWithReuseIdentifier: "miDiaCell")
        view.addSubview(collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaGpos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "miDiaCell", for: indexPath) as! MiDiaCollectionViewCell
        
        myCell.gpoAlim = listaGpos[indexPath.row]
        myCell.layer.borderWidth = 1
        myCell.layer.borderColor = UIColor.lightGray.cgColor
        
        return myCell
    }
    
    // Enseña o esconde el menu
    @objc func toggleMenu() {
        delegate?.handleMenuToggle()
    }

    func setupAddFoodButton() {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: self.view.center.x-75, y: SCREEN_HEIGHT - 80, width: 150, height: 50)

        button.setTitle("Registrar Comida", for: .normal)
        button.backgroundColor = .lightGray

        button.addTarget(self, action: #selector(showAddFood(_:)), for: .touchUpInside)

        view.addSubview(button)
    }

    @objc func showAddFood(_ sender:UIButton!) {
        let RegistraComidaVC = RegistraComidaViewController()
        present(RegistraComidaVC, animated: true, completion: nil)
    }
}
