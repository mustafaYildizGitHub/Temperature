//
//  CityData.swift
//  CWC
//
//  Created by mustafa yildiz on 11.08.2022.
//

import Foundation

struct CityData: Codable{
    let main:Main
    let weather:[Weather]
}

struct Main: Codable{
    let temp:Double
}

struct Weather:Codable{
    let id:Int
}
