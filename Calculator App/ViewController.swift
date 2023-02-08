//
//  ViewController.swift
//  Calculator App
//
//  Created by Dan on 2023-02-03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var CalculateInput: UILabel!
    @IBOutlet weak var CalculatorOutputResult: UILabel!
    
    var presentCalculation:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        aC()
    }
    @IBAction func acButton(_ sender: Any) {
        aC()
    }
    @IBAction func backSpaceButton(_ sender: Any) {
        if(!presentCalculation.isEmpty)
        {
            presentCalculation.removeLast()
            CalculateInput.text = presentCalculation
        }
    }
    @IBAction func divideButton(_ sender: Any) {
        addToWorkings(value: "/")
    }
    @IBAction func multiplyButton(_ sender: Any) {
        addToWorkings(value: "*")
    }
    @IBAction func addButton(_ sender: Any) {
        addToWorkings(value: "+")
    }
    @IBAction func subtractButton(_ sender: Any) {
        addToWorkings(value: "-")
    }
    @IBAction func equalButton(_ sender: Any) {
        if(validInput())
        {
            let expression = NSExpression(format: presentCalculation)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            CalculatorOutputResult.text = resultString
        }
        else
        {
            let alert = UIAlertController(
                title: "Invalid Input",
                message: "Please enter a valid input",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Back", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func dotBtn(_ sender: Any) {
        addToWorkings(value: ".")
    }
    @IBAction func numberBtn(_ sender: UIButton) {
        addToWorkings(value: "\(sender.tag)")
    }
    // FUNCTIONS //
    
    func aC(){
        presentCalculation = ""
        CalculateInput.text = ""
        CalculatorOutputResult.text = "0"
    }
    func addToWorkings(value: String)
    {
        presentCalculation = presentCalculation + value
        CalculateInput.text = presentCalculation
    }
    func validInput() ->Bool
    {
        var count = 0
        var funcCharIndexes = [Int]()
        
        for char in presentCalculation
        {
            if(specialCharacter(char: char))
            {
                funcCharIndexes.append(count)
            }
            count += 1
        }
    
        var previous: Int = -1
        for index in funcCharIndexes
        {
            if(index == 0)
            {
                return false
            }
            if(index == presentCalculation.count - 1)
            {
                return false
            }
            if (previous != -1)
            {
                if(index - previous == 1)
                {
                    return false
                }
            }
            previous = index
        }
        return true
    }
    
    func specialCharacter (char: Character) -> Bool
    {
        if(char == "*")
        {
            return true
        }
        if(char == "/")
        {
            return true
        }
        if(char == "+")
        {
            return true
        }
        return false
    }
    func formatResult(result: Double) -> String
    {
        if(result.truncatingRemainder(dividingBy: 1) == 0)
        {
            return String(format: "%.0f", result)
        }
        else
        {
            return String(format: "%.2f", result)
        }
    }
}

