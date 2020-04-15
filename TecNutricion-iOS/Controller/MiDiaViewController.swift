//
//  MiDiaViewController.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 14/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class MiDiaViewController: UIViewController, MenuDelegate {
    
    // Constants
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    
    var miDiaDelegate: MiDiaDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Mi Día"
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        navigationItem.leftBarButtonItem = menuButtonItem
        
        view.backgroundColor = UIColor.red
    }
    
    // Enseña o esconde el menu
    @objc func toggleMenu() {
        miDiaDelegate?.handleMenuToggle()
    }
   
    // MARK: - Menu Delegate
    func handleSectionTap(forSection section: MenuSection) {
        print(section.description)
    }
    
}

// MARK: - Protocol
protocol MiDiaDelegate {
    func handleMenuToggle()
}
