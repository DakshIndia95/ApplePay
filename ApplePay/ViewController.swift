//
//  ViewController.swift
//  ApplePay
//
//  Created by Neosoft on 19/07/23.
//

import UIKit
import PassKit

class ViewController: UIViewController {

    private var paymentRequest : PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "com.daksh.applePay"
        request.supportedNetworks = [.masterCard,.quicPay,.visa]
        request.supportedCountries = ["IN","US"]
        request.merchantCapabilities = .capability3DS //Protocol which provide secure protocol
        request.countryCode = "IN"
        request.currencyCode = "INR"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "iPhone 11", amount: 73000)]
        return request
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnPayClicked(_ sender: UIButton) {
        let controller = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        print("Pay Clicked: \(controller)")
        controller.delegate = self
        controller.present()
    }
}

extension ViewController : PKPaymentAuthorizationControllerDelegate {
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss()
    }
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        print("completed")
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
}

