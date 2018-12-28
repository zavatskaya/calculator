//
//  ViewController.swift
//  Calculator
//
//  Created by Liliya Zavatskaya on 12/24/18.
//  Copyright © 2018 Liliya Zavatskaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   

    
    
    @IBOutlet weak var displayResultLabel: UILabel!
    private var stillTyping = false
    private var dotIsPlaced = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        set {
            var valueArray = "\(newValue)".components(separatedBy: ".")
            
            displayResultLabel.text = valueArray[1] == "0" ? valueArray[0] : "\(newValue)"
            
            stillTyping = false
        }
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.red
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        print("viewDidDisappear")
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        self.view.backgroundColor = UIColor.white
//        print("hello")
//        let alert = UIAlertController(title: "Hello", message: "test", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "close", style: .default, handler: { (action) in
//
//        }))
//        self.present(alert, animated: true)
//    }
    
    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        let number = sender.currentTitle!
        
        if stillTyping {
            if (displayResultLabel.text?.characters.count)! < 10 {
                displayResultLabel.text = displayResultLabel.text! + number
            }
        } else {
            displayResultLabel.text = number
            stillTyping = true
        }
        
    }
    
    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    func operateWithTwoOperand (operation: (Double, Double) -> Double)  {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        enum operations: String {
            case plus = "+"
            case minus = "-"
            case multiply = "×"
            case divide = "÷"
        }
        
        switch operationSign {
            case operations.plus.rawValue: operateWithTwoOperand {$0 + $1}
            case operations.minus.rawValue: operateWithTwoOperand {$0 - $1}
            case operations.multiply.rawValue: operateWithTwoOperand {$0 * $1}
            case operations.divide.rawValue: operateWithTwoOperand {$0 / $1}
            default: break
        }
        //TODO: Make enum
//        switch operationSign {
//        case "+":
//            operateWithTwoOperand {$0 + $1}
//        case "-":
//            operateWithTwoOperand {$0 - $1}
//        case "×":
//            operateWithTwoOperand {$0 * $1}
//        case "÷":
//            operateWithTwoOperand {$0 / $1}
//        default: break
//        }
    
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        operationSign = ""
        dotIsPlaced = false
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
    }
    
    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced {
            displayResultLabel.text = "0."
        }
    }
}



