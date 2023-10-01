//
//  SettingsViewController.swift
//  HW2CIS357
//
//  Created by Alexandra MacKay on 9/26/23.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func indicateSelection(distanceUnits: String)
    func indicateBearingSelection(bearingUnits: String)
}

class SettingsViewController: UIViewController {
    var pickerData: [String] = [String]()
    var bearingPickerData: [String] = [String]()
    
    var selection : String = "Miles"
    var bearingSelection: String = "Degrees"
    var delegate : SettingsViewControllerDelegate?

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var bearingPicker: UIPickerView!
    
    @IBOutlet weak var distanceUnitsButton: UIButton!
    @IBOutlet weak var bearingUnitsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.pickerData = ["Kilometers", "Miles"]
        self.bearingPickerData = ["Degrees", "Mils"]
        picker.delegate = self
        picker.dataSource = self
        bearingPicker.delegate = self
        bearingPicker.dataSource = self
        
        picker.isHidden = true
        bearingPicker.isHidden = true
        
        if let index = pickerData.firstIndex(of: self.selection) {
            self.picker.selectRow(index, inComponent:0, animated:true) } else {
                self.picker.selectRow(0, inComponent: 0, animated: true)
            }
        
        if let secondIndex = bearingPickerData.firstIndex(of: self.bearingSelection) {
            self.bearingPicker.selectRow(secondIndex, inComponent:0, animated:true) } else {
                self.bearingPicker.selectRow(0, inComponent: 0, animated: true)
            }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let d = self.delegate {
            d.indicateSelection(distanceUnits: selection)
        }
        if let f = self.delegate {
            f.indicateBearingSelection(bearingUnits: bearingSelection)
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDistanceUnitButton(_ sender: Any) {
        bearingPicker.isHidden = true
        picker.isHidden = false
    }
    
    @IBAction func onBearingUnitButton(_ sender: Any) {
        picker.isHidden = true
        bearingPicker.isHidden = false
    }
    
    @IBAction func onSaveButtonPress(_ sender: Any) {
        print("Saved!")
        distanceUnitsButton.setTitle("\(selection)", for: .normal)
        bearingUnitsButton.setTitle("\(bearingSelection)", for: .normal)
    }
    
    func indicateSelection(distanceUnits: String) {
        self.selection = distanceUnits
        self.selection = "Units: \(distanceUnits)"
        distanceUnitsButton.setTitle("\(distanceUnits)", for: .normal)
    }
    
    func indicateBearingSelection(bearingUnits: String) {
        self.bearingSelection = bearingUnits
        self.bearingSelection = "Units: \(bearingUnits)"
        bearingUnitsButton.setTitle("\(bearingUnits)", for: .normal)
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

extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
                return pickerData.count
            } else {
                return bearingPickerData.count
            }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
                return "\(pickerData[row])"
        } else {
                return "\(bearingPickerData[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            self.selection = self.pickerData[row]
        } else {
            self.bearingSelection = self.bearingPickerData[row]
        }
    }
}
