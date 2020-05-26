//
//  MiDiaLongCollectionViewFlowLayout.swift
//  TecNutricion-iOS
//
//  Created by user168638 on 5/21/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class MiDiaLongCollectionViewFlowLayout: UICollectionViewFlowLayout {
    let spacing: CGFloat = 10
    
    override init() {
        super.init()
        setupLayout()
    }
    
    // sets squares on 2 colums
    override var itemSize: CGSize {
        set {}
        
        get {
            let numberOfColumns: CGFloat = 1
            let itemWidth = (self.collectionView!.frame.width - (numberOfColumns - 1) - spacing) / numberOfColumns
            let itemHeight = MiDiaCollectionViewCell.CELL_HEIGHT
            
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    func setupLayout() {
        minimumInteritemSpacing = spacing
        minimumLineSpacing = spacing
        scrollDirection = .vertical
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
