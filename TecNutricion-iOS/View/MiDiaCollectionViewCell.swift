//
//  MiPlanTableViewCell.swift
//  TecNutricion-iOS
//
//  Created by Memo Saldaña on 20/04/20.
//  Copyright © 2020 Memo Saldaña. All rights reserved.
//
import UIKit

class MiDiaCollectionViewCell: UICollectionViewCell {
    class var CELL_HEIGHT: CGFloat {
        return 80.0
    }

    var gpoAlim : GpoAlimenticio? {
        didSet {
            if gpoAlim != nil {
                print(gpoAlim!.name)
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
        imgView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return imgView
    }()
    
    let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.backgroundColor = UIColor.white
        label.frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        return label
    }()
    
    let cellPortionsLabel: UILabel = {
        let SCREEN_WIDTH = UIScreen.main.bounds.width
        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.frame = CGRect(x: 200, y: 0, width: 60, height: 60)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
//        addSubview(cellIcon)
        addSubview(cellTitleLabel)
//        addSubview(cellPortionsLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
