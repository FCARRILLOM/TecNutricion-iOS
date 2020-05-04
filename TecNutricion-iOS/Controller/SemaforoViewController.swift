//
//  SemaforoViewController.swift
//  TecNutricion-iOS
//
//  Created by user168638 on 5/4/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class SemaforoViewController: UIViewController {

    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var NAVBAR_HEIGHT: CGFloat!
    
    var menuDelegate: MenuDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NAVBAR_HEIGHT = self.navigationController?.navigationBar.bounds.height
        
        title = "Semáforo Nutricional"
        
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        navigationItem.leftBarButtonItem = menuButtonItem
        
        setupImageView()
        
        // Do any additional setup after loading the view.
    }
    
    func setupImageView() {
        let imgView = UIImageView(frame: CGRect(x: 0, y: NAVBAR_HEIGHT + 20, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-NAVBAR_HEIGHT))
        imgView.image = UIImage(named: "semaforo")
        view.addSubview(imgView)
    }
    
    
    // MARK: - Menu delegate
    
    // Enseña o esconde el menu
    @objc func toggleMenu() {
        menuDelegate?.handleMenuToggle()
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
