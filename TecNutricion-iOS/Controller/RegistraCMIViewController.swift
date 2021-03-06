//
//  RegistraCMIViewController.swift
//  TecNutricion-iOS
//
//  Created by user168638 on 5/10/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import UIKit

class RegistraCMIViewController: UIViewController, UIGestureRecognizerDelegate {

    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    var NAVBAR_HEIGHT: CGFloat!
    
    let SIDE_PADDING: CGFloat = 18
    let TOP_PADDING: CGFloat = 20

    var delegate: historialManager!
    var fechaDatePicker: UIDatePicker!
    var pesoTf: UITextField!
    var masaTf: UITextField!
    var grasaTf: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        initNumberInputs()
        initDatePicker()
        setupLabelsAndFrames()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
    func initDatePicker() {
        fechaDatePicker = UIDatePicker()
        fechaDatePicker.datePickerMode = .date
    }
    
    func initNumberInputs() {
        pesoTf = UITextField()
        pesoTf.keyboardType = UIKeyboardType.decimalPad
        pesoTf.font = UIFont(name: "Aria", size: 18)
        pesoTf.borderStyle = UITextField.BorderStyle.roundedRect
        
        masaTf = UITextField()
        masaTf.keyboardType = UIKeyboardType.decimalPad
        masaTf.font = UIFont(name: "Aria", size: 18)
        masaTf.borderStyle = UITextField.BorderStyle.roundedRect
        
        grasaTf = UITextField()
        grasaTf.keyboardType = UIKeyboardType.decimalPad
        grasaTf.font = UIFont(name: "Aria", size: 18)
        grasaTf.borderStyle = UITextField.BorderStyle.roundedRect
    }

    func setupLabelsAndFrames() {
        let LABEL_WIDTH: CGFloat = 230
        let LABEL_HEIGHT: CGFloat = 40
        let TEXTFIELD_WIDTH: CGFloat = 90
        let TEXTFIELD_HEIGHT: CGFloat = 40
        let PICKER_HEIGHT: CGFloat = 80
        let TOP_MARGIN: CGFloat = SCREEN_HEIGHT * 0.4
        
        // Labels

        let pesoLb = UILabel()
        pesoLb.text = "Peso (kg.)"
        pesoLb.font = UIFont(name: "Arial", size: 18)
        pesoLb.textAlignment = .left
        pesoLb.textColor = UIColor.black
        
        let masaLb = UILabel()
        masaLb.text = "Masa Muscular (kg.)"
        masaLb.font = UIFont(name: "Arial", size: 18)
        masaLb.textAlignment = .left
        masaLb.textColor = UIColor.black
        
        let grasaLb = UILabel()
        grasaLb.text = "Grasa (%)"
        grasaLb.font = UIFont(name: "Arial", size: 18)
        grasaLb.textAlignment = .left
        grasaLb.textColor = UIColor.black
        
        let fechaLb = UILabel()
        fechaLb.text = "Fecha"
        fechaLb.font = UIFont(name: "Arial", size: 18)
        fechaLb.textAlignment = .left
        fechaLb.textColor = UIColor.black

        // Frames

        let bg = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: TOP_MARGIN))
        bg.backgroundColor = .clear
        let ex = UITapGestureRecognizer(target: self, action: #selector(backToHistory))
        ex.delegate = self
        bg.addGestureRecognizer(ex)
        
        pesoLb.frame = CGRect(  x: SIDE_PADDING,
                                y: TOP_PADDING,
                                width: LABEL_WIDTH,
                                height: LABEL_HEIGHT)
        pesoTf.frame = CGRect(  x: SIDE_PADDING + LABEL_WIDTH,
                                y: TOP_PADDING,
                                width: TEXTFIELD_WIDTH,
                                height: TEXTFIELD_HEIGHT)

        masaLb.frame = CGRect(  x: SIDE_PADDING,
                                y: pesoLb.frame.origin.y + pesoLb.frame.height + TOP_PADDING/2,
                                width: LABEL_WIDTH,
                                height: LABEL_HEIGHT)
        masaTf.frame = CGRect(  x: SIDE_PADDING + LABEL_WIDTH,
                                y: pesoLb.frame.origin.y + pesoLb.frame.height + TOP_PADDING/2,
                                width: TEXTFIELD_WIDTH,
                                height: TEXTFIELD_HEIGHT)

        grasaLb.frame = CGRect( x: SIDE_PADDING,
                                y: masaLb.frame.origin.y + masaLb.frame.height + TOP_PADDING/2,
                                width: LABEL_WIDTH,
                                height: LABEL_HEIGHT)
        grasaTf.frame = CGRect(  x: SIDE_PADDING + LABEL_WIDTH,
                                y: masaLb.frame.origin.y + masaLb.frame.height + TOP_PADDING/2,
                                width: TEXTFIELD_WIDTH,
                                height: TEXTFIELD_HEIGHT)
        
        fechaLb.frame = CGRect( x: SIDE_PADDING,
                                y: grasaLb.frame.origin.y + grasaLb.frame.height + TOP_PADDING/2,
                                width: LABEL_WIDTH,
                                height: LABEL_HEIGHT)
        fechaDatePicker.frame = CGRect(  x: 0,
                                y: fechaLb.frame.origin.y + fechaLb.frame.height,
                                width: SCREEN_WIDTH,
                                height: PICKER_HEIGHT)

        let button = UIButton(type: .system)
        button.frame = CGRect(x: self.view.center.x-65, y: fechaDatePicker.frame.maxY+20, width: 120, height: 50)
        
        button.setTitle("Guardar", for: .normal)
        button.backgroundColor = .theme
        button.layer.cornerRadius = 15
        button.tintColor = .white
        
        button.addTarget(self, action: #selector(addCMI), for: .touchUpInside)
        let ySize = button.frame.maxY+TOP_PADDING*5
        let vw = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - ySize, width: SCREEN_WIDTH, height: ySize))
        vw.backgroundColor = .white

        vw.addSubview(pesoLb)
        vw.addSubview(pesoTf)
        vw.addSubview(masaLb)
        vw.addSubview(masaTf)
        vw.addSubview(grasaLb)
        vw.addSubview(grasaTf)
        vw.addSubview(fechaLb)
        vw.addSubview(fechaDatePicker)
        vw.addSubview(button)

        view.addSubview(bg)
        view.addSubview(vw)
    }

    @objc func addCMI() {
        saveData()
    }

    func saveData() {
        guard pesoTf.text != "", let peso = Double(pesoTf.text!) else {
            let alerta = UIAlertController(title: "Cuidado", message: "Debes ingresar un peso", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alerta, animated: true, completion: nil)
            return
        }
        
        guard masaTf.text != "", let masa = Double(masaTf.text!) else {
            let alerta = UIAlertController(title: "Cuidado", message: "Debes ingresar una masa muscular", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alerta, animated: true, completion: nil)
            return
        }
        
        guard grasaTf.text != "", let grasa = Double(grasaTf.text!) else {
            let alerta = UIAlertController(title: "Cuidado", message: "Debes ingresar un porcentaje de grasa", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alerta, animated: true, completion: nil)
            return
        }
        
        delegate.addRegistro(registro: RegistroCMI(peso: peso, masa: masa, grasa: grasa, dia: fechaDatePicker.date))

        dismiss(animated: true, completion: nil)

    }
    @objc func backToHistory() {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
