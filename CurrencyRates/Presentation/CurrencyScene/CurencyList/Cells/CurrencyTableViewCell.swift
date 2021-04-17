//
//  CurrencyTableViewCell.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/17/21.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
  @IBOutlet weak var currencyName : UILabel!
  @IBOutlet weak var currencyValue : UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    selectionStyle = .none
  }
  func configWith(name : String, rate : Double){
    currencyName.text = name
    currencyValue.text = "\(rate.rounded(toPlaces: 2))"
  }
}
