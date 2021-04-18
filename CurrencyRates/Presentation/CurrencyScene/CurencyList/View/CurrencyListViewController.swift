//
//  CurrencyListViewController.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/17/21.
//

import UIKit
import RxSwift
import McPicker
enum ApiRequestStatus {
  case loading
  case finished
  case error
}
class CurrencyListViewController: UIViewController {
  // MARK: - Properities
  let disposeBag = DisposeBag()
  var viewModel : DefaultCurrencyListViewModel?
  var items : [CurrencyListItemViewModel] = []
  var currentApiRequestStatus : ApiRequestStatus = .finished
  var currentCurrency : CurrencyListItemViewModel? {
    didSet {
      setCurrentCurrencyText()
      callApi()
    }
  }
  // MARK: - Outlets
  @IBOutlet weak var tblCurrency : UITableView!
  @IBOutlet weak var currentCurrencyDescription : UILabel!

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    initUI()
    initData()
    registerNib()
    viewModel = DefaultCurrencyListViewModel()
    observeOnData()
    callApi()
    setCurrentCurrencyText()
  }
  override func viewWillAppear(_ animated: Bool) {
    configNavigationBar()
  }
  private func configNavigationBar() {
    navigationController?.navigationBar.isHidden = true
  }
  func setCurrentCurrencyText(){
    currentCurrencyDescription.text = currentCurrency?.currencyName
  }
  // MARK: Actions
  @IBAction private func didPressChangeBaseCurrency(_ sender : UIButton){
    let pickerData = [items.map({$0.currencyName})]
    McPicker.show(data: pickerData ) {  [weak self] (selections: [Int : String]) -> Void in
      print(selections)
      if  let selectedCurrrencyName = selections[0] {
        let index = pickerData[0].firstIndex(of: selectedCurrrencyName)!
        self?.currentCurrency = CurrencyListItemViewModel(currancyRate: CurrencyRate(currencyName : selectedCurrrencyName , currencyRate : self?.items[index].currencyRate ?? 0))
      }
    }
  }
  func callApi(){
    if self.currentApiRequestStatus != .loading {

      let baseUrl = Constants.apiUrl
      let apiPath = Constants.path
      let parametes = ["access_key": Constants.apiKey,"base": currentCurrency?.currencyName ?? ""]
      let apiComponent = ApiUrlComponent(baseurl: baseUrl, apiPath: apiPath, params: parametes)
      self.viewModel?.getData(with: apiComponent)
    }

  }
  func initData(){
    self.currentCurrency = CurrencyListItemViewModel(currencyName: "EUR", currencyRate: 1)
  }
  func initUI(){
    tblCurrency.tableFooterView = UIView(frame: .zero)
    tblCurrency.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
  }
  func observeOnData(){
    viewModel?.loading.asObservable().subscribe(onNext: {
      [weak self] loading in
      if loading {
        ProgressViewHelper.showProgressBarWithDimView()
        self?.currentApiRequestStatus = .loading
      }
      else {
        ProgressViewHelper.dissmissProgressBar()
      }
    }).disposed(by: disposeBag)
    viewModel?.items.asObservable().subscribe(onNext: {
      [weak self] response in
      self?.currentApiRequestStatus = .finished
      self?.items = response
      DispatchQueue.main.async {
        self?.tblCurrency.reloadData()
      }
    }).disposed(by: disposeBag)
    viewModel?.errorData.asObservable().subscribe(onNext: {
      [weak self] error in
      self?.currentApiRequestStatus = .error
      //to do show error view
      print(error)
      
    }).disposed(by: disposeBag)
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
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell : CurrencyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell") as! CurrencyTableViewCell
    cell.configWith(currency: items[indexPath.row])
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let currency = items[indexPath.row]
    // go the next view
    let vc = CurrencyConverterViewController(fromCurrency: currentCurrency!, toCurrency: currency)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
