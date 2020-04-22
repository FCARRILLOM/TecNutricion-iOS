//
//  MiPlanTableViewCell.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 20/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class MiPlanTableViewCell: UITableViewCell {
    class var CELL_HEIGHT: CGFloat {
        return 60.0
    }
    
    var gpoAlim : GpoAlimenticio? {
        didSet {
            if gpoAlim != nil {
                titleLabel.text = gpoAlim!.name
                portionsLabel.text = String(gpoAlim!.portions)
                icon.image = gpoAlim!.icon
            }
        }
    }

    let icon: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    let portionsLabel: UILabel = {
        let SCREEN_WIDTH = UIScreen.main.bounds.width
        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    let increaseButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "plusBtn"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let decreaseButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "minusBtn"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(icon)
        addSubview(titleLabel)
        addSubview(portionsLabel)
        addSubview(increaseButton)
        addSubview(decreaseButton)
        
        icon.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 50, height: 0, enableInsets: false)
        titleLabel.anchor(top: topAnchor, left: icon.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
        let stackView = UIStackView(arrangedSubviews: [decreaseButton, portionsLabel, increaseButton])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 10
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 15, paddingRight: 10, width: 0, height: 30, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
