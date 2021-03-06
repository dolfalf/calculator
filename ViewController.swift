//
//  ViewController.swift
//  calculator
//
//  Created by kimjunseong on 2020/02/05.
//  Copyright © 2020 kimjunseong. All rights reserved.
//

import UIKit

enum Operation: String {
    case Add = "+"
    case Subtract = "-"
    case Divide = "/"
    case Multiply = "*"
    case NULL = "Null"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    private var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation: Operation = .NULL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLbl.text = "0"
        
    }

    @IBAction func numberPressed(_ sender: RoundButton) {
        if runningNumber.count <= 8 {
            runningNumber += "\(sender.tag)"
            outputLbl.text = runningNumber
        }
    }
    @IBAction func allClearPressed(_ sender: RoundButton) {
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .NULL
        outputLbl.text = "0"
    }
    
    @IBAction func dotPressed(_ sender: RoundButton) {
        if runningNumber.contains(".") {
            return
        }
        
        else if runningNumber.count <= 7 {
            runningNumber += "."
            outputLbl.text = runningNumber
        }
    }
    @IBAction func equalPressed(_ sender: RoundButton) {
        operation(operation: currentOperation)
    }
    
    @IBAction func addPressed(_ sender: RoundButton) {
        operation(operation: .Add)
    }
    
    @IBAction func subtractPressed(_ sender: RoundButton) {
        operation(operation: .Subtract)
    }
    
    @IBAction func multiplyPressed(_ sender: RoundButton) {
        operation(operation: .Multiply)
    }
    
    @IBAction func dividePressed(_ sender: RoundButton) {
        operation(operation: .Divide)
    }
    
    @IBAction func percentPressed(_ sender: RoundButton) {
        if runningNumber != "" {
          runningNumber = "\(Double(runningNumber)! / 100.00)"
          outputLbl.text = runningNumber
          leftValue = runningNumber

        }
        
        if result != "" {
            result = "\(Double(result)! / 100.00)"
            outputLbl.text = result
            leftValue = result
            currentOperation = .NULL
        }

    }
    
    @IBAction func convertPressed(_ sender: RoundButton) {

        if runningNumber != ""{
            runningNumber = "\(Double(runningNumber)! * (-1))"
            if (Double(runningNumber)!.truncatingRemainder(dividingBy: 1) == 0){
                     runningNumber = "\(Int(Double(runningNumber)!))"
                 }
            outputLbl.text = "\(runningNumber)"
        }
        
        if result != "" {
            result = "\(Double(result)! * (-1))"
            leftValue = result
            if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0){
                     result = "\(Int(Double(result)!))"
                 }
            outputLbl.text = "\(result)"
        }
    }
    
    
    func operation(operation: Operation){
        if currentOperation != .NULL {
            if runningNumber != ""{
                rightValue = runningNumber
                if runningNumber == "." {
                    return
                }
                runningNumber = ""
                
                if leftValue == "" {
                    leftValue = "0"
                }
                
                if currentOperation == .Add {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                } else if currentOperation == .Subtract {
                     result = "\(Double(leftValue)! - Double(rightValue)!)"
                } else if currentOperation == .Multiply {
                     result = "\(Double(leftValue)! * Double(rightValue)!)"
                } else if currentOperation == .Divide {
                     result = "\(Double(leftValue)! / Double(rightValue)!)"
                }
                leftValue = result
                if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0){
                    result = "\(Int(Double(result)!))"
                }
                outputLbl.text = result
            }
            
            currentOperation = operation
            
        } else {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation

        }
    }
}


