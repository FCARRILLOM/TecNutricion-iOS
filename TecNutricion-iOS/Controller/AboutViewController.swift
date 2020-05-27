//
//  AboutViewController.swift
//  TecNutricion-iOS
//
//  Created by user168639 on 5/26/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    func setTouchable(touchable: Bool) {
        self.touchable = touchable
    }
    
    let developers: [String] = ["Jose Guillermo Salda;a", "Fernando Carrillo", "Carlos Estrada"]
    
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var NAVBAR_HEIGHT: CGFloat!
    var touchable: Bool!
    
    var menuDelegate: MenuDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        NAVBAR_HEIGHT = self.navigationController?.navigationBar.bounds.height
        touchable = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideMenu))

        navigationController?.navigationBar.addGestureRecognizer(tap)
        title = "Acerca de"
        let menuButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        menuButtonItem.tintColor = .white
        navigationItem.leftBarButtonItem = menuButtonItem

        view.backgroundColor = UIColor.background
        
        setupVersion()
        setupDevelopers()
    }
    
    @objc func hideMenu() {
        if !touchable {
            toggleMenu()
        }
    }
    
    // MARK: - Menu delegate
    
    // Enseña o esconde el menu
    @objc func toggleMenu() {
        touchable = !touchable
        menuDelegate?.handleMenuToggle()
    }
    
    func setupVersion() {
        let versionView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT * 0.15, width: SCREEN_WIDTH, height: 50))
        let versionText = UILabel()
        let versionNum = UILabel()
        
        versionText.text = "Version"
        versionNum.text = "1.0.0"
        
        versionView.addSubview(versionText)
        versionView.addSubview(versionNum)
        
        versionText.anchor(top: versionView.topAnchor, left: versionView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 100, height: 30, enableInsets: false)
        versionNum.anchor(top: versionView.topAnchor, left: nil, bottom: nil, right: versionView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 100, height: 30, enableInsets: false)
        
        versionView.backgroundColor = UIColor.white
        
        view.addSubview(versionView)
    }
    
    func setupDevelopers() {
        let developersView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT * 0.23, width: SCREEN_WIDTH, height: 210))
        let developersList = UIView()
        let developersTitle = UILabel()
        
        developersTitle.text = "Desarrolladores (Alumnos del Tec de Monterrey)"
        developersTitle.font = UIFont(name: "Helvetica Neue", size: 15)
        developersTitle.textColor = UIColor.darkFont
        
        developersView.addSubview(developersTitle)
        
        developersTitle.anchor(top: developersView.topAnchor, left: developersView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: SCREEN_WIDTH, height: 50, enableInsets: false)
                
        for (i, developer) in developers.enumerated() {
            let label = UILabel()
            label.text = developer
            developersList.addSubview(label)
            label.anchor(top: developersList.topAnchor, left: developersList.leftAnchor, bottom: nil, right: developersList.rightAnchor, paddingTop: CGFloat(i*50), paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: SCREEN_WIDTH, height: 60, enableInsets: false)
        }
        
        developersList.backgroundColor = UIColor.white
        developersView.backgroundColor = UIColor.background
        
        developersView.addSubview(developersList)
        
        developersList.anchor(top: nil, left: developersView.leftAnchor, bottom: developersView.bottomAnchor, right: developersView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: SCREEN_WIDTH, height: 160, enableInsets: false)
        
        view.addSubview(developersView)
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
