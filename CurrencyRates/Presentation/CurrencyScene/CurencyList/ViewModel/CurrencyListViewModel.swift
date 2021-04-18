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
enum ApiRequestStatus {
  case loading
  case finished
  case error
  case idle
}
struct CurrencyListViewModelActions {
  let showCurrencyConverterView: (CurrencyListItemViewModel,CurrencyListItemViewModel) -> Void
}
protocol CurrencyListViewModelInput {
  func getData(with currencyRequestDTO: CurrencyRequestDTO)
  var currencyUseCase : CurrencyRatesUseCase {get}
  func viewDidLoad()
  func didSelectItem(at index: Int)
}
protocol CurrencyListViewModelOutput {
  func viewDidLoad()
  func getData(with currencyRequestDTO: CurrencyRequestDTO)
  func item(at index : Int) -> CurrencyListItemViewModel
  func getItemsCount()->Int
  var items : PublishRelay<[CurrencyListItemViewModel]> {get}
  var errorData : PublishRelay<String> {get}
  var loading : PublishRelay<Bool> {get}
}

protocol CurrencyListViewModel: CurrencyListViewModelInput, CurrencyListViewModelOutput {}
class DefaultCurrencyListViewModel : CurrencyListViewModel {
  // MARK: - Actions
  private let actions: CurrencyListViewModelActions?
  // MARK: - OUTPUT
  var items : PublishRelay<[CurrencyListItemViewModel]> = PublishRelay()
  var errorData : PublishRelay<String> = PublishRelay()
  var loading : PublishRelay<Bool> = PublishRelay()
  // MARK: - private properities
  private var data: [CurrencyListItemViewModel] = []
  // MARK: - Intialize
  var currencyUseCase : CurrencyRatesUseCase
  init(currencyUseCase : CurrencyRatesUseCase,actions: CurrencyListViewModelActions) {
    self.currencyUseCase = currencyUseCase
    self.actions = actions
  }
  // MARK: - Call APi
  func getData(with currencyRequestDTO: CurrencyRequestDTO) {
    self.loading.accept(true)
    currencyUseCase.excute(currencyRequestDTO: currencyRequestDTO, completion: {
      [weak self] (response, error) in
      self?.loading.accept(false)
      if response != nil {
        self?.data = response!
        self?.items.accept(response!)
      }
      if error != nil {
        self?.errorData.accept(error?.localizedDescription ?? "")
      }
    })
  }
}
extension DefaultCurrencyListViewModel {
  func viewDidLoad() {

  }
  func didSelectItem(at index: Int) {
    
  }
  func item(at index: Int) -> CurrencyListItemViewModel {
    return data[index]
  }
  func getItemsCount()->Int {
    return data.count
  }
}
