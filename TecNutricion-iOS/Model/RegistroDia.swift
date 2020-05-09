//
//  RegistroDia.swift
//  TecNutricion-iOS
//
//  Created by user168639 on 5/5/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class RegistroDia: NSObject, Codable {
    var grupos: [GpoAlimenticio]
    var dia: Date
        
    init(grupos: [GpoAlimenticio], dia: Date) {
        self.grupos = grupos
        self.dia = dia
    }
}
