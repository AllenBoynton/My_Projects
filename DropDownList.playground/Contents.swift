//: Playground - noun: a place where people can play

import UIKit
import AVFoundation

var musicPlayer: AVAudioPlayer?

class DropDownPicker: UIViewController {
    
    var cardsArray: [String] = []
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var dropDownPicker: UIPickerView!
    
    // Dropdown list methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        return cardsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        self.view.endEditing(true)
        return cardsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        self.textField.text = self.cardsArray[row]
        self.dropDownPicker.isHidden = true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
    
        if textField == self.textField {
            self.dropDownPicker.isHidden = false
        }
        textField.endEditing(true)
    }
}
