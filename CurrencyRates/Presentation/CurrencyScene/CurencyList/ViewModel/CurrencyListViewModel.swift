//
//  CurrencyListViewModel.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/17/21.
//

import Foundation
import NetworkLayer
import RxSwift
import RxCocoa
struct ApiUrlComponent {
    let baseurl: String
    let apiPath: String
    let params: [String: String]
}

class DefaultCurrencyListViewModel {
  
  var successData : PublishRelay<BaseResponse> = PublishRelay()
  var errorData : PublishRelay<Error> = PublishRelay()
    func getData(with urlComponts: ApiUrlComponent) {
        let manger = NetworkMangerInterface<BaseResponse>.createNetworkMangerInstance(baseUrl: urlComponts.baseurl, path: urlComponts.apiPath, params: urlComponts.params)
        manger.getData { [weak self] result in
            switch result {
            case let .success(data):
              print(data)
              self?.successData.accept(data)
            case let .failure(error):
              self?.errorData.accept(error)
            }
        }
    }
}
