//
//  EquivalenciaEntry.swift
//  TecNutricion-iOS
//
//  Created by user168639 on 5/17/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class DetailEntry: NSObject {
    var desc: String
    var amount: String
    
    init(desc: String, amount: String) {
        self.desc = desc
        self.amount = amount
    }
}

class EquivalenciaEntry: NSObject {
    var grupo: String
    var entradas: [DetailEntry]
    
    init(grupo: String, entradas: [DetailEntry]) {
        self.grupo = grupo
        self.entradas = entradas
    }
}
