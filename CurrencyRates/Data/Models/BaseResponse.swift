//
//  BaseResponse.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/17/21.
//

import Foundation

struct BaseResponse: Codable, Serializable {
  var success: Bool
  var rates : [String : Double]?
  var error : CurrencyError?
}
struct CurrencyError : Codable {
  var code : Int
  var type : String
}
