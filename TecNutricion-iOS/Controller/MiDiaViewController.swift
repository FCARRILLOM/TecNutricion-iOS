//
//  MiDiaViewController.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 14/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class MiDiaViewController: UIViewController {
    // Constants
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    
    // UI elements
    var mainView: UIView!
    var menuView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Mi Día"
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(showMenu))
        navigationItem.leftBarButtonItem = menuButtonItem
        
        setupMainView()
        setupMenuView()
    }
    
    // View con informacion del dia
    func setupMainView() {
        mainView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        mainView.pinEdges(to: view)
        mainView.backgroundColor = UIColor.red
        
        view.addSubview(mainView)
    }
    
    // View con el menu
    func setupMenuView() {
        
    }
    
    @objc func showMenu() {
        
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

// Hace que el tamaño del view sea igual que el de su padre
extension UIView {
    func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
}
