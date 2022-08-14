//
//  ViewController.swift
//  CWC
//
//  Created by mustafa yildiz on 11.08.2022.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource ,UIPickerViewDelegate,CityManagerDelegate{
   
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityPicker: UIPickerView!
    
    var cityManager = CityManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityManager.delegate = self
        cityPicker.dataSource = self
        cityPicker.delegate = self
        cityManager.getCityTemp(for: cityManager.citiesArray[0])
    }
    
    func updateInterface(temperature: String, image: String) {
   
        DispatchQueue.main.async{
            self.tempLabel.text = "\(temperature) °C"
            self.image.image = UIImage(systemName: image)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityManager.citiesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityManager.citiesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCity = cityManager.citiesArray[row]
        cityManager.getCityTemp(for: selectedCity)
    }
    


}

