//
//  DefaultCurrencyRepository.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/18/21.
//

import Foundation
import NetworkLayer
import RxCocoa

final class DefaultCurrencyRepository: CurrencyRepository {

  func getCurrencyRates(with currencyRequestDTO: CurrencyRequestDTO, completion: @escaping ([CurrencyListItemViewModel]?, Error?) -> Void) {
    let manger = NetworkMangerInterface<CurrencyRatesDTO>.createNetworkMangerInstance(baseUrl: currencyRequestDTO.baseurl, path: currencyRequestDTO.apiPath, params: currencyRequestDTO.params)
    manger.getData {  result in
      switch result {
      case let .success(data):
        if data.error != nil {
          let error = NSError(domain:"", code:data.error?.code ?? 0 , userInfo:[ NSLocalizedDescriptionKey: data.error?.type ?? ""])
          completion(nil,error as Error)
        }
        else {
          if let domainData = data.toDomain() {
            completion(domainData.map(CurrencyListItemViewModel.init),nil)
          }
        }
      case .failure(let error):
        completion(nil , error)
      }
    }
  }




}
