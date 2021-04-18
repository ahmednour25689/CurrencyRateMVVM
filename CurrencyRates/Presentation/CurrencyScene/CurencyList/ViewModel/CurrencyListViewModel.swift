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

struct CurrencyListViewModelActions {
  let showCurrencyConverterView: (CurrencyListItemViewModel,CurrencyListItemViewModel) -> Void
}
protocol CurrencyListViewModelInput {
  func viewDidLoad()
  func getData()
  func didSelectItem(at index: Int)
  func setCurrentCurrency(currency : CurrencyListItemViewModel)
  func item(at index : Int) -> CurrencyListItemViewModel
  func pickerData()->[String]
  func getItemsCount()->Int
}
protocol CurrencyListViewModelOutput {
  var items : PublishRelay<[CurrencyListItemViewModel]> {get}
  var errorData : PublishRelay<String> {get}
  var loading : PublishRelay<Bool> {get}
  var currentCurrencyObservedObj : PublishRelay<CurrencyListItemViewModel> {get}
}
protocol CurrencyListViewModel: CurrencyListViewModelInput, CurrencyListViewModelOutput {}
class DefaultCurrencyListViewModel : CurrencyListViewModel {
  // MARK: - Actions
  private let actions: CurrencyListViewModelActions?
  // MARK: - OUTPUT
  var items : PublishRelay<[CurrencyListItemViewModel]> = PublishRelay()
  var errorData : PublishRelay<String> = PublishRelay()
  var loading : PublishRelay<Bool> = PublishRelay()
  var currentCurrencyObservedObj : PublishRelay<CurrencyListItemViewModel> = PublishRelay()
  // MARK: - private properities
  private var data: [CurrencyListItemViewModel] = []
  private var currentApiRequestStatus : ApiRequestStatus = .idle
  private var currentCurrency : CurrencyListItemViewModel?

  // MARK: - Intialize
  var currencyUseCase : CurrencyRatesUseCase
  init(currencyUseCase : CurrencyRatesUseCase,actions: CurrencyListViewModelActions) {

    self.currencyUseCase = currencyUseCase
    self.actions = actions

  }
  func initData(){
    let initialCurrency = CurrencyListItemViewModel(currencyName: "EUR", currencyRate: 1)
    self.setCurrentCurrency(currency: initialCurrency)
  }
  // MARK: - Call APi
  func getData() {
    if self.currentApiRequestStatus != .loading {
      self.loading.accept(true)
      currentApiRequestStatus = .loading
      currencyUseCase.excute(currencyRequestDTO: constructApiRequest(), completion: {
        [weak self] (response, error) in
        self?.loading.accept(false)
        if response != nil {
          self?.data = response!
          self?.items.accept(response!)
          self?.currentApiRequestStatus = .finished
        }
        if error != nil {
          self?.currentApiRequestStatus = .error
          self?.errorData.accept(error?.localizedDescription ?? "")
        }
      })
    }

  }
}
extension DefaultCurrencyListViewModel {
  func viewDidLoad() {
    initData()
  }
  func didSelectItem(at index: Int) {
    
  }
  func item(at index: Int) -> CurrencyListItemViewModel {
    return data[index]
  }
  func getItemsCount()->Int {
    return data.count
  }
  func pickerData() -> [String] {
    return data.map({$0.currencyName})
  }
  func setCurrentCurrency(currency: CurrencyListItemViewModel) {
    self.currentCurrency = currency
    self.currentCurrencyObservedObj.accept(currency)
    getData()
  }
  private func constructApiRequest() -> CurrencyRequestDTO{
        let apiPath = Constants.latestCurrencyRatesApiPath
        let parametes = ["base": currentCurrency?.currencyName ?? ""]
        let request = CurrencyRequestDTO( apiPath: apiPath, params: parametes)
        return request
    }
}
