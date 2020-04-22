//
//  CollectionViewCell.swift
//  TecNutricion-iOS
//
//  Created by user168638 on 4/21/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class MiDiaCollectionViewCell: UICollectionViewCell {
    class var CELL_HEIGHT: CGFloat {
        return 60.0
    }
    
    var gpoAlim : GpoAlimenticio? {
        didSet {
            if gpoAlim != nil {
                cellTitleLabel.text = gpoAlim!.name
                cellPortionsLabel.text = String(gpoAlim!.portions)
                cellIcon.image = gpoAlim!.icon
            }
        }
    }

    let cellIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        return imgView
    }()
    
    let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.frame = CGRect(x: 65, y: 0, width: 100, height: 60)
        return label
    }()
    
    let cellPortionsLabel: UILabel = {
        let SCREEN_WIDTH = UIScreen.main.bounds.width
        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.frame = CGRect(x: SCREEN_WIDTH - 65, y: 0, width: 60, height: 60)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(cellIcon)
        addSubview(cellTitleLabel)
        addSubview(cellPortionsLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
