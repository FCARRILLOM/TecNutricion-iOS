//
//  GrupoAlimenticio.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 20/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class GpoAlimenticio: Equatable, Codable, CustomStringConvertible {
    var name: String
    var icon: String
    var portions: Int
    
    var description: String {
        return "name: \(name), icon: \(icon), portions: \(portions)"
    }
    
    init(name: String, icon: String, portions: Int) {
        self.name = name
        self.icon = icon
        self.portions = portions
    }
    
    static func == (left: GpoAlimenticio, right: GpoAlimenticio) -> Bool {
        return left.name == right.name
    }
}
