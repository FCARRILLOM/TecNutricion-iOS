//
//  ContainerViewController.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 14/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, MenuDelegate {
    
    var miDiaController: MiDiaViewController!
    var menuController: MenuTableViewController!
    var navController: UINavigationController!
    
    var isExpanded = false
    var currentSection: MenuSection = .MiDia
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.theme
        
        setupMiDiaController()
    }
    
    // Inicializa MiDiaController
    func setupMiDiaController() {
        miDiaController = MiDiaViewController()
        miDiaController.delegate = self
        navController = UINavigationController(rootViewController: miDiaController)
        
        view.addSubview(navController.view)
        addChild(navController)
        navController.didMove(toParent: self)
    }
    
    // Inicializa menu
    func setupMenuController() {
        if menuController == nil {
            menuController = MenuTableViewController()
            menuController.delegate = self
            
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }

    func showMenuController(shouldExpand: Bool) {
        if shouldExpand {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.navController.view.frame.origin.x = self.navController.view.frame.width - 150
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.navController.view.frame.origin.x = 0
            }, completion: nil)
        }
    }
    
    // MARK: - Menu Delegate
    func handleMenuToggle() {
        if !isExpanded {
            setupMenuController()
        }
        
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded)
    }
    
    func handleSectionTap(forSection section: MenuSection?) {
        // esconde menu
        isExpanded = false
        showMenuController(shouldExpand: isExpanded)
        
        // crea y desmuestra nueva vista
        if let section = section {
            if currentSection != section {
                currentSection = section
                
                switch section {
                case .MiDia:
                    miDiaController = MiDiaViewController()
                    miDiaController.delegate = self
                    navController.setViewControllers([miDiaController], animated: true)
                    break;
                    
                case .MiPlan:
                    let miPlanController = MiPlanViewController()
                    miPlanController.menuDelegate = self
                    navController.setViewControllers([miPlanController], animated: true)
                    break;
                    
                case .Equivalentes:
                    let equivalentesViewController = EquivalentesTableViewController()
                    equivalentesViewController.menuDelegate = self
                    
                    navController.setViewControllers([equivalentesViewController], animated: true)
                    break;
                    
                case .Semaforo:
                    let SemaforoController = SemaforoViewController()
                    SemaforoController.menuDelegate = self
                    
                    navController.setViewControllers([SemaforoController], animated: true)
                    break;
                    
                case .Historial:
                    let historialController = HistorialViewController()
                    historialController.menuDelegate = self
                    
                    navController.setViewControllers([historialController], animated: true)
                    break;
                    
                case .Recetarios:
                    let url = URL(string: "https://drive.google.com/drive/folders/1lx2FhOuDAqLWwJ06bRdIfmuoV2QLsWZM?usp=sharing")
                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                    let vc = navController.topViewController as! showable
                    vc.setTouchable(touchable: true)
                    break;
                }
                
                print(section.description)
            } else {
                let vc = navController?.topViewController as! showable
                vc.setTouchable(touchable: true)
            }
        }
    }
}

protocol showable {
    func setTouchable(touchable: Bool)
}
