//
//  CurrencyListViewController.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/17/21.
//

import UIKit

class CurrencyListViewController: UIViewController {
  var viewModel : DefaultCurrencyListViewModel?
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "list view"
    // Do any additional setup after loading the view.
    viewModel = DefaultCurrencyListViewModel()
    callApi()
  }
  func callApi(){
    let baseUrl = Constants.apiUrl
    let apiPath = Constants.path
    let parametes = ["access_key": Constants.apiKey]
    let apiComponent = ApiUrlComponent(baseurl: baseUrl, apiPath: apiPath, params: parametes)
    self.viewModel?.getData(with: apiComponent)
  }

  init() {
    super.init(nibName: "CurrencyListViewController", bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }



}
