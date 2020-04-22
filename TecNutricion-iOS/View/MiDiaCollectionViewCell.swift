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
        return 110
    }
    
    var gpoAlim : GpoAlimenticio? {
        didSet {
            if gpoAlim != nil {
                cellTitleLabel.text = gpoAlim!.name
                cellPortionsLabel.text = String(gpoAlim!.portions)
                cellIcon.image = UIImage(named: gpoAlim!.icon)
            }
        }
    }

    let cellIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    let cellPortionsLabel: UILabel = {        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(cellIcon)
        addSubview(cellTitleLabel)
        addSubview(cellPortionsLabel)
        
        cellIcon.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 60, height: 60, enableInsets: false)
        
        cellTitleLabel.anchor(top: cellIcon.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 20, paddingBottom: 5, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        cellPortionsLabel.anchor(top: topAnchor, left: cellIcon.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 60, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
