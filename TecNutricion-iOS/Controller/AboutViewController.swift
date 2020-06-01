//
//  AboutViewController.swift
//  TecNutricion-iOS
//
//  Created by user168639 on 5/26/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, showable {
    func setTouchable(touchable: Bool) {
        self.touchable = touchable
    }
    
    let developers: [String] = ["José Guillermo Saldaña", "Fernando Carrillo", "Carlos Estrada"]
    
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var touchable: Bool!
    
    var menuDelegate: MenuDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

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
        setupLicense()
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
        let versionView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT * 0.15, width: SCREEN_WIDTH, height: 140))
        let versionText = UILabel()
        
        versionText.numberOfLines = 0
        
        versionText.text = "TecNutricion ha sido desarrollada por estudiantes del Tecnológico de Monterrey durante el semestre Febrero Junio de 2020, como parte del curso Desarrollo de Aplicaciones Móviles y asesorados por la maestra Yolanda Martínez Treviño"
        versionText.font = UIFont(name: "Helvetica Neue", size: 15)
        
        versionView.addSubview(versionText)
        
        versionText.anchor(top: versionView.topAnchor, left: versionView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: SCREEN_WIDTH-45, height: 140, enableInsets: false)
        
        versionView.backgroundColor = UIColor.white
        
        view.addSubview(versionView)
    }
    
    func setupDevelopers() {
        let developersView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT * 0.15 + 150, width: SCREEN_WIDTH, height: 200))
        let developersList = UIView()
        let developersTitle = UILabel()
        
        developersTitle.text = "Desarrolladores"
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
    
    func setupLicense() {
        let versionView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT * 0.15 + 390, width: SCREEN_WIDTH, height: 80))
        let versionText = UILabel()
        
        versionText.numberOfLines = 0
        
        versionText.text = "TecNutricion se distribuye como esta de manera gratuita y se prohibe su distribución con fines de lucro."
        versionText.font = UIFont(name: "Helvetica Neue", size: 15)
        
        versionView.addSubview(versionText)
        
        versionText.anchor(top: versionView.topAnchor, left: versionView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: SCREEN_WIDTH-45, height: 80, enableInsets: false)
        
        versionView.backgroundColor = UIColor.white
        
        view.addSubview(versionView)
    }
}
