//
//  EquivalenteDetailTableViewCell.swift
//  TecNutricion-iOS
//
//  Created by user168639 on 5/17/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class EquivalenteDetailTableViewCell: UITableViewCell {
    
    class var CELL_HEIGHT: CGFloat {
        return 40.0
    }
    
    var entry : DetailEntry? {
        didSet {
            if entry != nil {
                titleLabel.text = entry!.desc
                amountLabel.text = entry!.amount
            }
        }
    }
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(amountLabel)
        addSubview(titleLabel)
        
        amountLabel.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 25, width: frame.size.width * 0.25, height: 0, enableInsets: false)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 15, paddingBottom: 5, paddingRight: 5, width: frame.size.width * 0.75, height: 0, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
