//
//  MiDiaViewController.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 14/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

protocol MiDiaDataManager {
    func updateData(newData: [GpoAlimenticio]!)
}

class MiDiaViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, MiDiaDataManager {
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
        
        view.backgroundColor = UIColor.white
        createGroups()
        setupCollectionView()
        
        setupAddFoodButton()

    }

    func createGroups(){
        let planLista = loadPlan()

        if !checkValidPlan(plan: planLista) {
            let alert = UIAlertController(title: "Alerta", message: "Aun no hay un plan registrado", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ir a Mi Plan", style: .cancel, handler: sendToPlan))
            present(alert, animated: true, completion: nil)
        }
      
        listaGpos = loadDia()
        
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

    func sendToPlan(_ :UIAlertAction) {
        delegate?.handleSectionTap(forSection: MenuSection.MiPlan)
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

    // MARK: Save/Load Data
    
    func PlanFileURL() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathFile = url.appendingPathComponent("Plan.json")
        return pathFile
    }

    func loadPlan() -> [GpoAlimenticio] {
        do {
            let data = try Data.init(contentsOf: PlanFileURL())
            let newListaGpos = try JSONDecoder().decode([GpoAlimenticio].self, from: data)
            return newListaGpos
        }
        catch {
            print("Error loading mi plan data")
            return []
        }
    }

    func checkValidPlan(plan: [GpoAlimenticio]) -> Bool {
        if plan.count == 0  {
            return false
        }

        for g in plan {
            if g.portions > 0 {
                return true
            }
        }

        return false

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
        RegistraComidaVC.MiDiaData = self
        present(RegistraComidaVC, animated: true, completion: nil)
    }

    // MARK: Load Data

    
    func dataFileURL() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathFile = url.appendingPathComponent("data.json")
        return pathFile
    }

    func loadDia() -> [GpoAlimenticio] {
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

    // MARK: MiDiaDataManager delegate function

    func updateData(newData: [GpoAlimenticio]!) {
        listaGpos = newData
        collectionView.reloadData()
    }
}
