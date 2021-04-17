//
//  CurrencyListViewController.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/17/21.
//

import UIKit

class CurrencyListViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "list view"
    // Do any additional setup after loading the view.
  }

  init() {
    super.init(nibName: "CurrencyListViewController", bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }



}
