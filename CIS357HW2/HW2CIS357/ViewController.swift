//
//  ViewController.swift
//  HW2CIS357
//
//  Created by Caroline Carlson on 9/20/23.
//

import UIKit

class ViewController: UIViewController, SettingsViewControllerDelegate {

    @IBOutlet weak var p1LatInputField: UITextField!
    @IBOutlet weak var p2LatInputField: UITextField!
    @IBOutlet weak var p1LongInputField: UITextField!
    @IBOutlet weak var p2LongInputField: UITextField!
    
    @IBOutlet weak var DistanceValue: UILabel!
    @IBOutlet weak var BearingValue: UILabel!
    
    var p1Lat: String = ""
    var p2Lat: String = ""
    var p1Long: String = ""
    var p2Long: String = ""
    var distMeasurement: String = ""
    var distanceUnits = "Miles"
    var bearingMeasurement: String = ""
    var bearingUnits = "Degrees"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    
    func indicateSelection(distanceUnits: String) {
        self.distanceUnits = distanceUnits
        self.distMeasurement = "Units: \(distanceUnits)"
        print("Units: \(distanceUnits)")
    }
    
    func indicateBearingSelection(bearingUnits: String) {
        self.bearingUnits = bearingUnits
        self.bearingMeasurement = "Units: \(bearingUnits)"
        print("Units: \(bearingUnits)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSettings" {
            if let dest = segue.destination as? SettingsViewController {
                dest.delegate = self
                dest.selection = self.distanceUnits
            }
        }
    }


    @IBAction func calculate(_ sender: UIButton) {
        p1Lat = p1LatInputField.text!
        p2Lat = p2LatInputField.text!
        p1Long = p1LongInputField.text!
        p2Long = p2LongInputField.text!
        
        //Calulate distance:
        var distance: Float = 0.0
        var earthRadius: Float = 6371
        
        var dLat = degreesToRadians(deg:(Float(p1Lat)! - Float(p2Lat)!))
        var dLong = degreesToRadians(deg:(Float(p1Long)! - Float(p2Long)!))
        var a = sin(dLat/2) * sin(dLat/2) + cos(degreesToRadians(deg:(Float(p1Lat))!)) * cos(degreesToRadians(deg: Float(p2Lat)!)) * sin(dLong/2) * sin(dLong/2)
        var c = 2 * atan2(sqrt(a), sqrt(1-a))
        distance = earthRadius * c
        
        distance = round(100 * distance) / 100
        
        //based on units
        indicateSelection(distanceUnits: distanceUnits)
        print("TestUnits: \(distanceUnits)")
        if (distanceUnits == "Kilometers") {
            distance = milesToKm(distanceUnit: distance)
            DistanceValue.text = String(distance) + (" kilometers")
        } else {
            DistanceValue.text = String(distance) + (" miles")
        }
        
        //Calculate bearing:
        var bearing: Float = 0.0
        var x = cos(degreesToRadians(deg: Float(p2Lat)!)) * sin(degreesToRadians(deg:dLong))
        var y = cos(degreesToRadians(deg: Float(p1Lat)!)) * sin(degreesToRadians(deg: Float(p2Lat)!)) - sin(degreesToRadians(deg: Float(p1Lat)!)) * cos(degreesToRadians(deg: Float(p2Lat)!)) * cos(degreesToRadians(deg: dLong))
        bearing = atan2(x,y)
        bearing = radiansToDegrees(rad: bearing)
        bearing = round(100 * bearing) / 100
        
        //based on units
        indicateBearingSelection(bearingUnits: bearingUnits)
        print("TestUnits: \(bearingUnits)")
        if (bearingUnits == "Mils") {
            bearing = kmToMiles(distanceUnit: bearing)
            BearingValue.text = String(bearing) + (" mils")
        } else {
            BearingValue.text = String(bearing) + (" degrees")
        }
        
    }
    
    func degreesToRadians(deg: Float) -> Float{
        return deg * Float.pi / 180
    }
    
    func radiansToDegrees(rad: Float) -> Float{
        return rad * 180 / Float.pi
    }
    
    func milesToKm(distanceUnit: Float) -> Float{
        return distanceUnit * 1.609
    }
    
    func kmToMiles(distanceUnit: Float) -> Float{
        return distanceUnit / 1.609
    }
    
    func degToMils(bearingUnit: Float) -> Float{
        return bearingUnit * 17.7777777778
    }
    
    func milsToDeg(bearingUnit: Float) -> Float{
        return bearingUnit / 17.777777777778
    }
    
    @IBAction func goToSettings(_ sender: UIButton) {
        
    }
    
    
}

