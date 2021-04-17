//
//  CurrencyListViewController.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/17/21.
//

import UIKit
import RxSwift
class CurrencyListViewController: UIViewController {
  // MARK: - Properities
  let disposeBag = DisposeBag()
  var viewModel : DefaultCurrencyListViewModel?
  var data : [String : Double] = [:]
  var keysArray : [String] = []
  // MARK: - Outlets
  @IBOutlet weak var tblCurrency : UITableView!
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.isHidden = true
    // Do any additional setup after loading the view.
    initUI()
    registerNib()
    viewModel = DefaultCurrencyListViewModel()
    observeOnData()
    callApi()
  }
  func callApi(){
    let baseUrl = Constants.apiUrl
    let apiPath = Constants.path
    let parametes = ["access_key": Constants.apiKey]
    let apiComponent = ApiUrlComponent(baseurl: baseUrl, apiPath: apiPath, params: parametes)
    self.viewModel?.getData(with: apiComponent)
  }
  func initUI(){
    tblCurrency.tableFooterView = UIView(frame: .zero)
    tblCurrency.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
  }
  func observeOnData(){
    viewModel?.successData.asObservable().subscribe(onNext: {
      [weak self] response in
      print("response")
      self?.data = response.rates
      self?.keysArray = Array(response.rates.keys)
      DispatchQueue.main.async {
        self?.tblCurrency.reloadData()
      }

    }
    , onError:{
      error in
      print("error")
    }
    ).disposed(by: disposeBag)
  }
  func registerNib(){
    tblCurrency.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyTableViewCell")
  }
  init() {
    super.init(nibName: "CurrencyListViewController", bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
extension CurrencyListViewController : UITableViewDataSource,UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return keysArray.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell : CurrencyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell") as! CurrencyTableViewCell
    let currencyName = keysArray[indexPath.row]
    let currencyRate = data[currencyName]
    cell.configWith(name: currencyName, rate: currencyRate ?? 0)
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }

}
