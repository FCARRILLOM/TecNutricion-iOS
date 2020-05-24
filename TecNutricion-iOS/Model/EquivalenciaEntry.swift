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

var equivalencias = [
    EquivalenciaEntry(grupo: "Vegetales", entradas: [
        DetailEntry(desc: "Ensalada promedio", amount: "1/2 taza"),
        DetailEntry(desc: "Esparragos", amount: "1/2 taza"),
        DetailEntry(desc: "Espinacas", amount: "1/2 taza"),
        DetailEntry(desc: "Flor de calabaza", amount: "1/2 taza"),
        DetailEntry(desc: "Germen", amount: "1/2 taza"),
        DetailEntry(desc: "Jicama", amount: "1/2 taza"),
        DetailEntry(desc: "Jitomate", amount: "1/2 taza"),
        DetailEntry(desc: "Lechuga", amount: "1/2 taza"),
        DetailEntry(desc: "Nopales", amount: "1/2 taza"),
        DetailEntry(desc: "Pepino", amount: "1/2 taza"),
        DetailEntry(desc: "Perejil", amount: "1/2 taza"),
        DetailEntry(desc: "Rabano", amount: "1/2 taza"),
        DetailEntry(desc: "Repollo", amount: "1/2 taza"),
        DetailEntry(desc: "Tomate", amount: "1/2 taza"),
        DetailEntry(desc: "Betabel", amount: "1/2 taza"),
        DetailEntry(desc: "Calabacita", amount: "1/2 taza"),
        DetailEntry(desc: "Cebolla", amount: "1/2 taza"),
        DetailEntry(desc: "Jugo de tomate", amount: "1/2 taza"),
        DetailEntry(desc: "Jugo de verduras", amount: "1/2 taza"),
        DetailEntry(desc: "Pimiento", amount: "1/2 taza"),
        DetailEntry(desc: "Zanahoria", amount: "1/2 taza")
    ]),
    EquivalenciaEntry(grupo: "Carnes", entradas: [
        DetailEntry(desc: "Aves", amount: "30 grs."),
        DetailEntry(desc: "Res", amount: "30 grs."),
        DetailEntry(desc: "Pescados y mariscos", amount: "30 grs."),
        DetailEntry(desc: "Pollo deshebrado", amount: "1/4 taza"),
        DetailEntry(desc: "Queso cottage o requeson", amount: "3 C"),
        DetailEntry(desc: "Queso fresco (panela)", amount: "40 g."),
        DetailEntry(desc: "Atun en agua", amount: "1/3 lata"),
        DetailEntry(desc: "Carnes frias (pavo)", amount: "2 reb. chicas"),
        DetailEntry(desc: "Salchicha (pavo)", amount: "1 pza."),
        DetailEntry(desc: "Huevo", amount: "1 pza."),
        DetailEntry(desc: "Clara de huevo", amount: "2 pza."),
    ]),
    EquivalenciaEntry(grupo: "Leche", entradas: [
        DetailEntry(desc: "Leche de vaca o soya", amount: "250 ml."),
        DetailEntry(desc: "Yoghurt", amount: "250 ml.")
    ]),
    EquivalenciaEntry(grupo: "Azucares", entradas: [
        DetailEntry(desc: "Azucar", amount: "1 C"),
        DetailEntry(desc: "Miel", amount: "1 C"),
        DetailEntry(desc: "Mermelada", amount: "1 (80 ml)"),
        DetailEntry(desc: "Cajeta", amount: "1 C"),
        DetailEntry(desc: "Gelatina regular", amount: "1/2 taza"),
        DetailEntry(desc: "Chocolate en polvo", amount: "1 C"),
        DetailEntry(desc: "Refrescos", amount: "1 C"),
        DetailEntry(desc: "Catsup", amount: "1 C")
    ]),
    EquivalenciaEntry(grupo: "Leguminosas", entradas: [
        DetailEntry(desc: "Lentejas", amount: "1/2 taza"),
        DetailEntry(desc: "Garbanzo", amount: "1/2 taza"),
        DetailEntry(desc: "Habas", amount: "1/2 taza"),
        DetailEntry(desc: "Alubias", amount: "1/2 taza"),
        DetailEntry(desc: "Frijol cocido o en bola", amount: "1/2 taza"),
        DetailEntry(desc: "Frijol refrito", amount: "1/3 taza"),
        DetailEntry(desc: "Soya texturiuzada", amount: "3 C"),
        DetailEntry(desc: "Soya cocida", amount: "1/3 taza")
    ]),
    EquivalenciaEntry(grupo: "Frutas", entradas: [
        DetailEntry(desc: "Arándanos", amount: "2 C"),
        DetailEntry(desc: "Ciruela", amount: "3 piezas"),
        DetailEntry(desc: "Chabacano", amount: "4 piezas"),
        DetailEntry(desc: "Durazno", amount: "2 piezas"),
        DetailEntry(desc: "Fresa", amount: "1 taza"),
        DetailEntry(desc: "Guayaba", amount: "2 med."),
        DetailEntry(desc: "Jugo de frutas", amount: "1/2 taza"),
        DetailEntry(desc: "Jugo de uva", amount: "1/4 taza"),
        DetailEntry(desc: "Limón", amount: "libre"),
        DetailEntry(desc: "Mandarina", amount: "2 piezas"),
        DetailEntry(desc: "Mango", amount: "1/2 med."),
        DetailEntry(desc: "Kiwi", amount: "1.5 piezas"),
        DetailEntry(desc: "Manzana", amount: "1 pieza"),
        DetailEntry(desc: "Melón", amount: "1 taza"),
        DetailEntry(desc: "Naranja", amount: "1 pieza"),
        DetailEntry(desc: "Papaya", amount: "2/3 taza"),
        DetailEntry(desc: "Pera", amount: "1/2 pieza"),
        DetailEntry(desc: "Piña", amount: "2/3 taza"),
        DetailEntry(desc: "Plátano", amount: "1/2 pieza"),
        DetailEntry(desc: "Sandía", amount: "1 taza"),
        DetailEntry(desc: "Toronja", amount: "1 pieza"),
        DetailEntry(desc: "Tuna", amount: "2 piezas"),
        DetailEntry(desc: "Uva", amount: "9 piezas"),
        DetailEntry(desc: "Pasitas", amount: "10 piezas")
    ]),
    EquivalenciaEntry(grupo: "Cereales", entradas: [
        DetailEntry(desc: "Cereal sin endulzar", amount: "1/2 taza"),
        DetailEntry(desc: "Arroz cocido", amount: "1/2 taza"),
        DetailEntry(desc: "Amaranto tostado", amount: "1/3 taza"),
        DetailEntry(desc: "Avena cocida", amount: "1/2 taza"),
        DetailEntry(desc: "Salvado y germen de trigo", amount: "1/2 taza"),
        DetailEntry(desc: "Pasta cocida", amount: "1/2 taza"),
        DetailEntry(desc: "Harina/Maizena", amount: "2 C"),
        DetailEntry(desc: "Pan de barra integral", amount: "1 reb"),
        DetailEntry(desc: "Pan p/hot dog", amount: "1/2 pieza"),
        DetailEntry(desc: "Galletas saladas", amount: "6 cuadros"),
        DetailEntry(desc: "Kraker Bran", amount: "3 cuadros"),
        DetailEntry(desc: "Galletas Habaneras", amount: "3 piezas"),
        DetailEntry(desc: "Galletas Marias", amount: "4 piezas"),
        DetailEntry(desc: "Elote desgranado", amount: "1/2 taza"),
        DetailEntry(desc: "Elote mazorca", amount: "3/4 pieza"),
        DetailEntry(desc: "Papa c/cáscara", amount: "1/2 pieza"),
        DetailEntry(desc: "Granola (simple)", amount: "3 C"),
        DetailEntry(desc: "Tortilla maíz", amount: "1 pieza"),
        DetailEntry(desc: "Tostada Horneada", amount: "2 piezas"),
        DetailEntry(desc: "Pan p/hamburguesa ch.", amount: "1/2 pieza"),
        DetailEntry(desc: "Pan p/hamburguesa dge.", amount: "1/3 pieza"),
        DetailEntry(desc: "Pan francés s/migajón", amount: "1/2 pieza"),
        DetailEntry(desc: "Pan francés c/migajón", amount: "1/4 pieza"),
        DetailEntry(desc: "Crotones", amount: "1/2 taza"),
        DetailEntry(desc: "Palomitas naturales", amount: "2 tazas")
    ]),
    EquivalenciaEntry(grupo: "Grasas", entradas: [
        DetailEntry(desc: "Cacahuate", amount: "18 piezas"),
        DetailEntry(desc: "Semillas de girasol o calabaza", amount: "1.5 C"),
        DetailEntry(desc: "Piñones", amount: "2 C"),
        DetailEntry(desc: "Mantequilla", amount: "1 C"),
        DetailEntry(desc: "Mayonesa", amount: "1 C"),
        DetailEntry(desc: "Nuez", amount: "3 piezas"),
        DetailEntry(desc: "Pistaches", amount: "6 piezas"),
        DetailEntry(desc: "Almendras", amount: "10 piezas"),
        DetailEntry(desc: "Aguacate", amount: "1/4 pieza"),
        DetailEntry(desc: "Aceitunas", amount: "6 piezas"),
        DetailEntry(desc: "Cocoa", amount: "1 C"),
        DetailEntry(desc: "Aderezo", amount: "1 C"),
        DetailEntry(desc: "Leche de almendras", amount: "250 ml.")
    ])
]
