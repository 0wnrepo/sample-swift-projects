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
        let stringNumber = textView.text
    
        if isValidPositiveNumber(number: stringNumber!) {
            checkIfPrimeFromWithString(input: stringNumber!) {
                (result: String) in
                print("got back: \(result)",
                    statusLabel.text = result)
            }
        } else {
            statusLabel.text = "Input not valid, please edit and check again!"
        }
    }
    
    func isValidPositiveNumber(number : String) -> Bool {
        let n = NumberFormatter().number(from: number)
        let a = n != nil ? true : false //valid number?
        let b = (n?.intValue)! < Int.max ? true : false //smaller than max int?
        let c = (n?.intValue)! > 0 ? true : false //positive?
        return a && b && c;
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

