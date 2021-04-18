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
  // MARK: - OUTPUT
  var items : PublishRelay<[CurrencyListItemViewModel]> = PublishRelay()
  var errorData : PublishRelay<String> = PublishRelay()
  var loading : PublishRelay<Bool> = PublishRelay()
  // MARK: - Data From Api
    func getData(with urlComponts: ApiUrlComponent) {
      self.loading.accept(true)
        let manger = NetworkMangerInterface<CurrencyRatesDTO>.createNetworkMangerInstance(baseUrl: urlComponts.baseurl, path: urlComponts.apiPath, params: urlComponts.params)
        manger.getData { [weak self] result in
          self?.loading.accept(false)
            switch result {
            case let .success(data):
              if data.error != nil {
                self?.errorData.accept(data.error?.type ?? "")
              }
              else {
                if let domainData = data.toDomain() {
                  self?.items.accept(domainData.map(CurrencyListItemViewModel.init))
                }

              }
            case .failure(_):           
              self?.errorData.accept("Network error")
            }
        }
    }
}
