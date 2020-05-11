//
//  RegistroCMI.swift
//  TecNutricion-iOS
//
//  Created by user168639 on 5/10/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class RegistroCMI: NSObject, Codable {
    var peso: Double
    var masa: Double
    var grasa: Double
    var dia: Date
    
    init(peso: Double, masa: Double, grasa: Double, dia: Date) {
        self.cmi = cmi
        self.masa = masa
        self.grasa = grasa
        self.dia = dia
    }
}
