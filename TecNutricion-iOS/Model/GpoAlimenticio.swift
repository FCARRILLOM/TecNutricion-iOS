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

var BaseLista: [GpoAlimenticio] = [
    GpoAlimenticio(name: "Vegetales", icon: "vegetable-icon-color", portions: 0),
    GpoAlimenticio(name: "Carnes", icon: "meat-icon-color", portions: 0),
    GpoAlimenticio(name: "Azucares", icon: "sugar-icon-color", portions: 0),
    GpoAlimenticio(name: "Cereales", icon: "cereal-icon-color", portions: 0),
    GpoAlimenticio(name: "Leguminosas", icon: "pea-icon-color", portions: 0),
    GpoAlimenticio(name: "Frutas", icon: "apple-icon-color", portions: 0),
    GpoAlimenticio(name: "Grasas", icon: "fat-icon-color", portions: 0),
    GpoAlimenticio(name: "Leche", icon: "milk-icon-color", portions: 0),
    GpoAlimenticio(name: "Agua", icon: "water-icon-color", portions: 0),
]
