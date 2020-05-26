//
//  SemaforoViewController.swift
//  TecNutricion-iOS
//
//  Created by user168638 on 5/4/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class SemaforoViewController: UIViewController, showable {

    

    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var NAVBAR_HEIGHT: CGFloat!
    
    var menuDelegate: MenuDelegate!
    
    var touchable: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NAVBAR_HEIGHT = self.navigationController?.navigationBar.bounds.height
        
        touchable = true;
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideMenu))
        navigationController?.navigationBar.addGestureRecognizer(tap)
        view.addGestureRecognizer(tap)
        title = "Semáforo Nutricional"
        
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        menuButtonItem.tintColor = .white
        navigationItem.leftBarButtonItem = menuButtonItem
        view.backgroundColor = .white
        setupImageView()
        
        // Do any additional setup after loading the view.
    }
    
    func setupImageView() {
        let imgView = UIImageView(frame: CGRect(x: 0, y: NAVBAR_HEIGHT + 5, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-NAVBAR_HEIGHT))
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "semaforov22")
        view.addSubview(imgView)
    }
    
    func setTouchable(touchable: Bool) {
        self.touchable = touchable
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
