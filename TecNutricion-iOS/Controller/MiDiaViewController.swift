//
//  MiDiaViewController.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 14/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

protocol MiDiaDataManager {
    func updateData(newData: [GpoAlimenticio]!, date: Date)
}

class MiDiaViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, MiDiaDataManager {
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var NAVBAR_HEIGHT: CGFloat!

    var delegate: MenuDelegate!
    var collectionView: UICollectionView!

    var listaGpos: [GpoAlimenticio]!
    var listaPlan: [GpoAlimenticio]!

    var buttonRegistrar: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        NAVBAR_HEIGHT = self.navigationController?.navigationBar.bounds.height

        title = "Mi Día"
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        navigationItem.leftBarButtonItem = menuButtonItem

        view.backgroundColor = UIColor.white
    }

    override func viewDidAppear(_ animated: Bool) {
        setupView()
    }

    func setupView() {
        createGroups()
        setupAddFoodButton()
        setupCollectionView()
    }

    func createGroups(){
        listaPlan = loadPlan()

        if !checkValidPlan(plan: listaPlan) {
            let alert = UIAlertController(title: "Alerta", message: "Aun no hay un plan registrado", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ir a Mi Plan", style: .cancel, handler: sendToPlan))
            present(alert, animated: true, completion: nil)
        }

        listaGpos = loadFoodForToday()

        // no hay comida registrada para el dia de hoy
        if listaGpos.count == 0 {
            listaGpos = BaseLista
        }
    }

    // MARK: - Collection View
    func setupCollectionView() {
        let layout: UICollectionViewLayout = MiDiaCollectionViewFlowLayout()

        collectionView = UICollectionView(frame: CGRect(x: 10,
                                                        y: NAVBAR_HEIGHT,
                                                        width: SCREEN_WIDTH - 20,
                                                        height: SCREEN_HEIGHT - NAVBAR_HEIGHT - (SCREEN_HEIGHT - buttonRegistrar.frame.minY) - 10),
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

        if checkValidPlan(plan: listaPlan) {
            myCell.completePortion = CGFloat(listaPlan[indexPath.row].portions)
        }
        myCell.gpoAlim = listaGpos[indexPath.row]
//        myCell.layer.borderWidth = 1
//        myCell.layer.borderColor = UIColor.lightGray.cgColor

        return myCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vistaEq = EquivalentesDetailTableViewController()

        vistaEq.grupo = listaGpos[indexPath.row]

        present(vistaEq, animated: true, completion: nil)
    }

    // MARK: - Menu delegate

    // Enseña o esconde el menu
    @objc func toggleMenu() {
        delegate?.handleMenuToggle()
    }

    // envia al usuario a la pantalla de mi plan
    func sendToPlan(_ :UIAlertAction) {
        delegate?.handleSectionTap(forSection: MenuSection.MiPlan)
    }

    // MARK: MiDiaDataManager delegate function

    func updateData(newData: [GpoAlimenticio]!, date: Date) {
        saveFood(newData: newData, date: date)
        setupView()
    }

    // MARK: - Botones para agregar porciones de comida

    func setupAddFoodButton() {
        buttonRegistrar = UIButton(type: .system)
        buttonRegistrar.frame = CGRect(x: self.view.center.x-75, y: SCREEN_HEIGHT - 70, width: 150, height: 50)

        buttonRegistrar.setTitle("Registrar Comida", for: .normal)
        buttonRegistrar.backgroundColor = .lightGray

        buttonRegistrar.addTarget(self, action: #selector(showAddFood(_:)), for: .touchUpInside)

        view.addSubview(buttonRegistrar)
    }

    @objc func showAddFood(_ sender:UIButton!) {
        let RegistraComidaVC = RegistraComidaViewController()
        RegistraComidaVC.MiDiaData = self
        present(RegistraComidaVC, animated: true, completion: nil)
    }

    func findGpoAlimIndex(grupo: GpoAlimenticio, lista: [GpoAlimenticio]) -> Int {
        for i in 0...(lista.count - 1) {
            if lista[i] == grupo {
                return i
            }
        }

        return -1
    }

    // MARK: Load Data
    func dataFileURL() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathFile = url.appendingPathComponent("registros.json")
        return pathFile
    }

    func saveFood(newData: [GpoAlimenticio]!, date: Date) {
        do {
            if FileManager.default.fileExists(atPath: dataFileURL().path) {
                let saved = try Data.init(contentsOf: dataFileURL())
                var registros = try JSONDecoder().decode([RegistroDia].self, from: saved)

                print("Decoded")

                var foundOld = false
                var updatedList = newData

                for reg in registros {
                    if datesEqual(d1: reg.dia, d2: date) {
                        for gr in newData {
                            let newIndex = findGpoAlimIndex(grupo: gr, lista: reg.grupos)
                            reg.grupos[newIndex].portions += gr.portions
                        }
                        updatedList = reg.grupos
                        foundOld = true
                    }
                }

                if !foundOld {
                    registros.append(RegistroDia(grupos: updatedList!, dia: date))
                }

                let data = try JSONEncoder().encode(registros)
                try data.write(to: dataFileURL())

                let today = Date()

                if datesEqual(d1: today, d2: date) {
                    listaGpos = updatedList
                }
            } else {
                let nuevaLista: [RegistroDia] = [RegistroDia(grupos: newData, dia: date)]

                print("Creating new")

                let data = try JSONEncoder().encode(nuevaLista)
                try data.write(to: dataFileURL())

                let today = Date()

                if datesEqual(d1: today, d2: date) {
                    listaGpos = newData
                }
            }

        }
        catch {
            print("Error registering food data")
        }
    }

    func loadFoodForToday() -> [GpoAlimenticio] {
        do {
            let data = try Data.init(contentsOf: dataFileURL())
            let registros = try JSONDecoder().decode([RegistroDia].self, from: data)

            let today = Date()

            for reg in registros {
                if datesEqual(d1: today, d2: reg.dia) {
                    return reg.grupos
                }
            }

            return []
        }
        catch {
            print("Error loading mi plan data")
            return []
        }
    }

    func datesEqual(d1: Date, d2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.component(.year, from: d1) == calendar.component(.year, from: d2) && calendar.component(.month, from: d1) == calendar.component(.month, from: d2) && calendar.component(.day, from: d1) == calendar.component(.day, from: d2)

    }

    // MARK: Plan verification

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
    }
}
