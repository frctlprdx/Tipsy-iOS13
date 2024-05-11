//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip: Double = 0.0
    var total:Double = 0.0
    var split: Double = 0.0
    var payPerPerson = ""
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        let title = sender.currentTitle!
        let cleanPercentageString = title.replacingOccurrences(of: "%", with: "")
        let number = Double(cleanPercentageString)!
        tip = number / 100
        
        billTextField.endEditing(true)
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let text = String(format: "%.0f", sender.value)
        split = Double(text)!
        splitNumberLabel.text = text
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
        total = Double(bill)!
        let result = (total + (total*tip))/split
        payPerPerson = String(format: "%.2f", result)
        print(payPerPerson)
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.people = String(format: "%.0f", split)
            destinationVC.tipPercentage = String(format: "%.0f", tip*100)
            destinationVC.result = payPerPerson
        }
        
    }
    
}
