//
//  ContainerViewController.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 14/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, MiDiaDelegate {
    
    var miDiaController: MiDiaViewController!
    var menuController: MenuTableViewController!
    var navController: UINavigationController!
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMiDiaController()
    }
    
    func setupMiDiaController() {
        miDiaController = MiDiaViewController()
        miDiaController.miDiaDelegate = self
        navController = UINavigationController(rootViewController: miDiaController)
        
        view.addSubview(navController.view)
        addChild(navController)
        navController.didMove(toParent: self)
    }
    
    func setupMenuController() {
        if menuController == nil {
            menuController = MenuTableViewController()
            menuController.menuDelegate = miDiaController
            
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }

    func showMenuController(shouldExpand: Bool) {
        if shouldExpand {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.navController.view.frame.origin.x = self.miDiaController.view.frame.width - 150
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.navController.view.frame.origin.x = 0
            }, completion: nil)
        }
    }
    
    
    // MARK: - Mi Dia Delegate
    func handleMenuToggle() {
        if !isExpanded {
            setupMenuController()
        }
        
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded)
    }

}
