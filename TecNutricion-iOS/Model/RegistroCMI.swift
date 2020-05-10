//
//  RegistroCMI.swift
//  TecNutricion-iOS
//
//  Created by user168639 on 5/10/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class RegistroCMI: NSObject, Codable {
    var cmi: Double
    var dia: Date
    
    init(cmi: Double, dia: Date) {
        self.cmi = cmi
        self.dia = dia
    }
}
