//
//   ConversionViewController .swift
//  Test Project
//
//  Created by Wyatt Paquin on 2/11/18.
//  Copyright © 2018 Wyatt Paquin. All rights reserved.
//

import UIKit





class ConversionViewController: UIViewController {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view.")
        updateCelsiusLabel()
    }

    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil }
    }
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
//        celsiusLabel.text = textField.text
//        if let text = textField.text, !text.isEmpty {
//            celsiusLabel.text = text
//        } else {
//            celsiusLabel.text = "???"
//        }
//        if let text = textField.text, let value = Double(text) {
//            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
                fahrenheitValue = nil
            }
        }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
//            celsiusLabel.text = "\(celsiusValue.value)"
            celsiusLabel.text =
                numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
//        print("Current text: \(String(describing: textField.text))")
//        print("Replacement text: \(string)")
//        return true
        
//        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
//        let replacementTextHasDecimalSeparator = string.range(of: ".")

        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        let existingTextHasDecimalSeparator
            = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
            
        }
        
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf }()
    
    

}
