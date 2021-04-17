//
//  ProgressView.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/17/21.
//

import Foundation
import SVProgressHUD
class  ProgressViewHelper {
    class func showProgressBarWithDimView() {
        SVProgressHUD().defaultMaskType = .black
        SVProgressHUD().defaultAnimationType = .flat
        SVProgressHUD.show()
    }
    class func dissmissProgressBar() {
        SVProgressHUD.dismiss()
    }
}
