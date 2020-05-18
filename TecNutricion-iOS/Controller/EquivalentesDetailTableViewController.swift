//
//  EquivalentesDetailTableViewController.swift
//  TecNutricion-iOS
//
//  Created by user168639 on 5/17/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class EquivalentesDetailTableViewController: UITableViewController {
    
    var grupo: GpoAlimenticio!
    
    var info: [EquivalenciaEntry] = [
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
            DetailEntry(desc: "Zanahoria", amount: "1/2 taza"),
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
            DetailEntry(desc: "Yoghurt", amount: "250 ml."),
        ]),
        EquivalenciaEntry(grupo: "Azucares", entradas: [
            DetailEntry(desc: "Azucar", amount: "1 C"),
            DetailEntry(desc: "Miel", amount: "1 C"),
            DetailEntry(desc: "Mermelada", amount: "1 (80 ml)"),
            DetailEntry(desc: "Cajeta", amount: "1 C"),
            DetailEntry(desc: "Gelatina regular", amount: "1/2 taza"),
            DetailEntry(desc: "Chocolate en polvo", amount: "1 C"),
            DetailEntry(desc: "Refrescos", amount: "1 C"),
            DetailEntry(desc: "Catsup", amount: "1 C"),
        ]),
        EquivalenciaEntry(grupo: "Leguminosas", entradas: [
            DetailEntry(desc: "Lentejas", amount: "1/2 taza"),
            DetailEntry(desc: "Garbanzo", amount: "1/2 taza"),
            DetailEntry(desc: "Habas", amount: "1/2 taza"),
            DetailEntry(desc: "Alubias", amount: "1/2 taza"),
            DetailEntry(desc: "Frijol cocido o en bola", amount: "1/2 taza"),
            DetailEntry(desc: "Frijol refrito", amount: "1/3 taza"),
            DetailEntry(desc: "Soya texturiuzada", amount: "3 C"),
            DetailEntry(desc: "Soya cocida", amount: "1/3 taza"),
        ]),
    ]
    
    var selectedEquivalencia: [DetailEntry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EquivalenteDetailTableViewCell.self, forCellReuseIdentifier: "sectionCell")
        
        selectGrupo()
    }
    
    func selectGrupo() {
        for i in info {
            if i.grupo == grupo.name {
                selectedEquivalencia = i.entradas
            }
        }
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return selectedEquivalencia.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as! EquivalenteDetailTableViewCell

        cell.entry = selectedEquivalencia[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return EquivalenteDetailTableViewCell.CELL_HEIGHT
       }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
