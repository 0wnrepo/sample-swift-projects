//
//  ViewController.swift
//  primes
//
//  Created by Good on 07/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var isPrimeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func isPrimeButtonAction(_ sender: Any) {
        let numberString = textView.text

        checkIfPrimeFromWithString(input: numberString!) {
            (result: String) in
            print("got back: \(result)",
            statusLabel.text = result)
        }
        
    }
    
    func checkIfPrimeFromWithString(input: String, completion: (_ result: String) -> Void) {
        let n = Double(input)
        
        if Int(n!) % 2 == 0 {
            completion("Not prime! divisor: 2")
            return
        }
        
        let first = 3
        let last = Int(floor(sqrt(n!)))
        let interval = 2
        
        for i in stride(from: first, through: last, by: interval) {
            if (Int(n!) % i == 0) {
                completion("Not prime! divisor: \(i)")
                return
            }
        }
        
        completion("prime!")
    }
    
    

}

