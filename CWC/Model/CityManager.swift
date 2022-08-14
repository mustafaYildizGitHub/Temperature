//
//  CityManager.swift
//  CWC
//
//  Created by mustafa yildiz on 11.08.2022.
//

import Foundation
import UIKit

protocol CityManagerDelegate{
    func updateInterface(temperature:String,image:String)
    func didFailWithError(error:Error)
}

struct CityManager{
    
    var delegate: CityManagerDelegate?
    
    let citiesArray = ["London","Paris","Amsterdam","Berlin","Madrid","Roma"]
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=21b674a6e65debae4a26bb63a9d0f9cb"
    
    func getCityTemp (for city : String){
        let urlString = "\(weatherURL)&q=\(city)"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let temperature = self.parseJSON(safeData){
                        self.delegate?.updateInterface(temperature: temperature[0], image: temperature[1])
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ cityData:Data)->Array<String>?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CityData.self, from: cityData)
           
            let temp = decodedData.main.temp
            let tempString = String(format: "%.0f", temp)
            
            let id = decodedData.weather[0].id
            var conditionName: String{
                switch id {
                        case 200...232:
                            return "cloud.bolt"
                        case 300...321:
                            return "cloud.drizzle"
                        case 500...531:
                            return "cloud.rain"
                        case 600...622:
                            return "cloud.snow"
                        case 701...781:
                            return "cloud.fog"
                        case 800:
                            return "sun.max"
                        case 801...804:
                            return "cloud.bolt"
                        default:
                            return "cloud"
                        }
            }
            
            var array = [tempString,conditionName]
            
            return array
            
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
        
        
        
    
    
    
    
    
}
