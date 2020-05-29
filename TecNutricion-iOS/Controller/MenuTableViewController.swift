//
//  MenuTableViewController.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 14/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    // Numero de opciones en el menu
    let NUM_SECTIONS = 8
    
    var delegate: MenuDelegate!
    
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sectionCell")
        tableView.backgroundColor = UIColor.theme
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.allowsMultipleSelection = false
        tableView.allowsSelection = true
        tableView.reloadData()
        print("loaded")
        //tableView.selectRow(at: IndexPath(row: 1, section: 0), animated: false, scrollPosition: .bottom)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NUM_SECTIONS
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath)
        let section = MenuSection(rawValue: indexPath.row-1)
        
        if indexPath.row == NUM_SECTIONS-2 {
            print(SCREEN_WIDTH)
//            let image = UIImageView(frame: CGRect(x: cell.frame.size.width - 10, y: 10, width: 20, height: 20))
//            let img = UIImage(systemName: "escape")
//            let whiteImg = img?.withRenderingMode(.alwaysTemplate)
//            image.image = whiteImg
//            image.tintColor = .white
            let image = UIImageView(image: UIImage(systemName: "escape"))
            image.tintColor = .white
            print(SCREEN_WIDTH)
            image.frame = CGRect(x: cell.frame.minX+SCREEN_WIDTH*0.5, y:SCREEN_HEIGHT*0.015, width: 20, height: 20)
            image.center.y = cell.center.y+2
            
            cell.addSubview(image)
        }

        
        if indexPath.row == 0 {
            cell.selectionStyle = .none
        } else {
            let background = UIView()
            
            background.backgroundColor = .themeHighlighted
            cell.selectedBackgroundView = background
        }
        cell.textLabel?.text = section?.description
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor.theme
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0, let selectecSection = MenuSection(rawValue: indexPath.row-1) {
            delegate?.handleSectionTap(forSection: selectecSection)
        }
    }
}

protocol MenuDelegate {
    func handleMenuToggle()
    func handleSectionTap(forSection section: MenuSection?)
}
