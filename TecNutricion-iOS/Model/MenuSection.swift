//
//  MenuSection.swift
//  TecNutricion-iOS
//
//  Created by Fernando Carrillo on 14/04/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import Foundation


enum MenuSection: Int, CustomStringConvertible {
    
    case MiDia
    case MiPlan
    case Equivalentes
    case Semaforo
    case Historial
    case Recetarios
    case Acerca
    
    var description: String {
        switch self {
        case .MiDia: return "Mi Día"
        case .MiPlan: return "Mi Plan"
        case .Equivalentes: return "Equivalentes"
        case .Semaforo: return "Semáforo Nutricional"
        case .Historial: return "Historial de C.C."
        case .Recetarios: return "Recetarios"
        case .Acerca: return "Acerca"
        }
    }
}
