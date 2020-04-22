//
//  GrupoAlimenticio.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 20/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

struct GpoAlimenticio: Equatable {
    var name: String
    var icon: UIImage
    var portions: Int
    
    static func == (left: GpoAlimenticio, right: GpoAlimenticio) -> Bool {
        return left.name == right.name
    }
}
