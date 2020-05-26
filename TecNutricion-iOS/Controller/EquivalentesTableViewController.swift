//
//  EquivalentesTableViewController.swift
//  TecNutricion-iOS
//
//  Created by user168639 on 5/17/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class EquivalentesTableViewController: UITableViewController, showable, UIGestureRecognizerDelegate {
    func setTouchable(touchable: Bool) {
        self.touchable = touchable
    }
    
    
    let grupos = GpoAlimenticio.NewBase()
    
    var menuDelegate: MenuDelegate!

    var touchable : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        touchable = true;
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideMenu))
        navigationController?.navigationBar.addGestureRecognizer(tap)

        
        tableView.register(EquivalenteTableViewCell.self, forCellReuseIdentifier: "sectionCell")
        
        title = "Equivalentes"
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        menuButtonItem.tintColor = .white
        navigationItem.leftBarButtonItem = menuButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideMenu))
        tap.delegate = self
        
        tableView.addGestureRecognizer(tap)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
    
    // MARK: - Menu delegate
    
    // Enseña o esconde el menu
    @objc func toggleMenu() {
        touchable = !touchable
        menuDelegate?.handleMenuToggle()
    }
    
    @objc func hideMenu() {
        if !touchable {
            toggleMenu()
        }
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
        guard touchable else {
            hideMenu()
            return
        }
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
