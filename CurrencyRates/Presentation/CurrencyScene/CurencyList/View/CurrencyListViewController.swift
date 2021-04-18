//
//  CurrencyListViewController.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/17/21.
//

import UIKit
import RxSwift
import McPicker

class CurrencyListViewController: UIViewController {
  // MARK: - Properities
  let disposeBag = DisposeBag()
  var viewModel : CurrencyListViewModel!
  // MARK: - Outlets
  @IBOutlet weak var tblCurrency : UITableView!
  @IBOutlet weak var currentCurrencyDescription : UILabel!
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    initUI()
    registerNib()
    observeOnData()
    viewModel.viewDidLoad()
   }
  override func viewWillAppear(_ animated: Bool) {
    configNavigationBar()
  }
  // MARK: - config
  func initUI(){
    tblCurrency.tableFooterView = UIView(frame: .zero)
    tblCurrency.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
  }
  private func configNavigationBar() {
    navigationController?.navigationBar.isHidden = true
  }
  func setCurrentCurrencyText(currencyName : String){
    currentCurrencyDescription.text = currencyName
  }
  func registerNib(){
    tblCurrency.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyTableViewCell")
  }
  // MARK: - Observe
  func observeOnData(){
    viewModel.loading.asObservable().subscribe(onNext: {
      loading in
      if loading {
        ProgressViewHelper.showProgressBarWithDimView()
      }
      else {
        ProgressViewHelper.dissmissProgressBar()
      }
    }).disposed(by: disposeBag)
    viewModel.items.asObservable().subscribe(onNext: {
      [weak self] response in
      DispatchQueue.main.async {
        self?.tblCurrency.reloadData()
      }
    }).disposed(by: disposeBag)
    viewModel.errorData.asObservable().subscribe(onNext: {
       [weak self ] error in
      //to do show error view
      DispatchQueue.main.async {
        self?.showAlert(message: error)
      }
    }).disposed(by: disposeBag)
    viewModel.currentCurrencyObservedObj.asObservable().subscribe(onNext: {
       currency in
      self.setCurrentCurrencyText(currencyName: currency.currencyName)
    }).disposed(by: disposeBag)
  }

  // MARK: - Init
  init() {
    super.init(nibName: "CurrencyListViewController", bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  static func create(with viewModel: DefaultCurrencyListViewModel
                     ) -> CurrencyListViewController {
      let view = CurrencyListViewController()
      view.viewModel = viewModel
      return view
  }
  // MARK: Actions
  @IBAction private func didPressChangeBaseCurrency(_ sender : UIButton){
    let pickerData = [viewModel.pickerData()]
    McPicker.show(data: pickerData ) {  [weak self] (selections: [Int : String]) -> Void in
      print(selections)
      if  let selectedCurrrencyName = selections[0] {
        let index = pickerData[0].firstIndex(of: selectedCurrrencyName)!
       let currency =  CurrencyListItemViewModel(currancyRate: CurrencyRate(currencyName : selectedCurrrencyName , currencyRate : self?.viewModel.item(at: index).currencyRate ?? 0))
        self?.viewModel.setCurrentCurrency(currency: currency)
      }
    }
  }
}
// MARK: - Table view data source and delegate
extension CurrencyListViewController : UITableViewDataSource,UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getItemsCount()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell : CurrencyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell") as! CurrencyTableViewCell
    cell.configWith(currency: viewModel.item(at: indexPath.row))
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // go the next view
    viewModel.didSelectItem(at: indexPath.row)

  }
}
