//
//  MiDiaLongCollectionViewCell.swift
//  TecNutricion-iOS
//
//  Created by user168638 on 5/21/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class MiDiaLongCollectionViewCell: UICollectionViewCell {
    var completePortion: CGFloat = 0
    
    class var CELL_HEIGHT: CGFloat {
        return 110
    }
    
    var gpoAlim: GpoAlimenticio? {
        didSet {
            if gpoAlim != nil {
                cellTitleLabel.text = gpoAlim!.name
                cellPortionsLabel.text = String(gpoAlim!.portions)
                cellIcon.image = UIImage(named: gpoAlim!.icon)
                
                // evita dividir entre 0 para porciones del plan registradas con 0
                if completePortion > 0 {
                    let progress: CGFloat = CGFloat(gpoAlim!.portions) / completePortion
                    progressBar.updateProgress(progress: progress)
                // cuando no hay porciones registradas en el plan para el grupo, pero si consumio porciones
                } else if completePortion == 0 && gpoAlim!.portions > 1 {
                    progressBar.updateProgress(progress: 1.1) // arriba de 1.0 marca con rojo
                }
            }
        }
    }
    
    let progressBar: ProgressBar = {
        let bar = ProgressBar()
        return bar
    }()

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
        super.init(frame: frame)
        addSubview(cellIcon)
        addSubview(cellTitleLabel)
        addSubview(progressBar)
        addSubview(cellPortionsLabel)
        
        cellIcon.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 60, height: 60, enableInsets: false)
        
        cellTitleLabel.anchor(top: topAnchor, left: cellIcon.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 5, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        progressBar.anchor(top: topAnchor, left: cellTitleLabel.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 0, paddingRight: 30, width: 0, height: 60, enableInsets: false)
        
        cellPortionsLabel.anchor(top: topAnchor, left: cellTitleLabel.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 0, paddingRight: 30, width: 60, height: 60, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
