//
//  CurrencyConverterViewController.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/18/21.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
  // MARK: - Properities
  var fromCurrency : CurrencyListItemViewModel
  var toCurrency : CurrencyListItemViewModel
  // MARK: - Outlets
  @IBOutlet weak var toCurrencyText : UILabel!
  @IBOutlet weak var fromCurrencyText : UILabel!
  @IBOutlet weak var fromCurrencyInput : UITextField!
  // MARK: - Life cycle


  override func viewDidLoad() {
    super.viewDidLoad()
    congfigNavigationBar()
    initUI()
    configTextFieldEditAction()
  }
  @objc func textFieldDidChange(_ textField: UITextField) {
    if let doubleValue = Double(textField.text!) {
      calculateRateForNewValue(value: doubleValue)
    }
  }
  fileprivate func configTextFieldEditAction() {
    fromCurrencyInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
  }
  func initUI() {
    toCurrencyText.text = "\(toCurrency.currencyRate)" + " " + toCurrency.currencyName
    fromCurrencyInput.text = "\(fromCurrency.currencyRate)"
    fromCurrencyText.text = " " + fromCurrency.currencyName
  }
  func calculateRateForNewValue(value : Double){
    let newRate = (value * toCurrency.currencyRate).rounded(toPlaces: 2)
    toCurrencyText.text = "\(newRate)" + " " + toCurrency.currencyName
  }
  fileprivate func congfigNavigationBar() {
    self.navigationController?.navigationBar.isHidden = false
  }
  // MARK : - Initializer
  init(fromCurrency : CurrencyListItemViewModel , toCurrency : CurrencyListItemViewModel) {
    self.fromCurrency = fromCurrency
    self.toCurrency = toCurrency
    super.init(nibName: "CurrencyConverterViewController", bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
