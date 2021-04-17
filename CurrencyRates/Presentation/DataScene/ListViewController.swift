//
//  ListViewController.swift
//  TemplateMVVM
//
//  Created by Ahmed Nour on 4/16/21.
//

import UIKit

class ListViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "list view"
    // Do any additional setup after loading the view.
  }

  init() {
    super.init(nibName: "ListViewController", bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
