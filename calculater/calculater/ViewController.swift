//
//  ViewController.swift
//  calculater
//
//  Created by ahmad alkhateeb on 06/10/2021.
//

import UIKit

class ViewController: UIViewController {
    private var stringFirst = ""
    private var stringSecond = ""
    private var sign = calculationsSing.none
    private var result = 0.0
    private var firstInt = 0.0
    private var secondInt = 0.0
    var containString2:String = ""
    enum calculationsSing{
        case plus
        case minus
        case multipile
        case divid
        case none
        }
    func getSign(tag:Int) ->calculationsSing{
        var signFunc = calculationsSing.none
        switch tag
        {
        case 1: signFunc = .plus
        case 2: signFunc = .minus
        case 3: signFunc = .multipile
        case 4: signFunc = .divid
        default: signFunc = .none
        }
        return signFunc
        }
    
    func finalResult(signs: calculationsSing) -> Double{
        firstInt = Double(stringFirst) ?? 0.0
        secondInt = Double(stringSecond) ?? 0.0
        var resultFunc = 0.0
        switch signs {
        case .plus: resultFunc = firstInt + secondInt
        case .minus: resultFunc = firstInt - secondInt
        case .multipile: resultFunc = firstInt * secondInt
        case .divid: if(secondInt != 0){resultFunc = firstInt / secondInt}else{labelOfResult.text = "Error"}
        default: resultFunc = 0.0
        }
        return resultFunc
       }
    
    func finalResult(signs: calculationsSing,string2: Double) -> Double{
        firstInt = Double(stringFirst) ?? 0.0
        var resultFunc = 0.0
        switch signs {
        case .plus: resultFunc = firstInt + string2
        case .minus: resultFunc = firstInt - string2
        case .multipile: resultFunc = firstInt * string2
        case .divid:  if(string2 != 0 ){resultFunc = firstInt / string2}else{labelOfResult.text = "Error"}
        default: resultFunc = 0.0
        }
        return resultFunc
       }
    
    func resultHandel(resultString:String) -> Bool{
        if (Int(resultString.split(separator: ".").last ?? "0" ) ?? 0 > 0)
        {return true}
        else{return false}
        
    }
    
    @IBAction func numberInsert(_ sender: UIButton) {
        guard let number = sender.titleLabel?.text else {
            return
        }
        if sign != .none {
            stringSecond += number
            labelOfResult.text = stringSecond
        }
        else {
            stringFirst += number
            labelOfResult.text = stringFirst
        }
    }
    
    @IBAction func calculationSim(_ sender: UIButton)
    {
         
        if(stringSecond == "")
        {
        sign = getSign(tag: sender.tag)
        labelOfResult.text = ""
        }
        else if(stringSecond != ""){
            result = finalResult(signs: sign)
            if(resultHandel(resultString: String(result))){
            labelOfResult.text = String(result)
            }
            else{
            labelOfResult.text = String(Int(result))
                }
            stringFirst = String(result)
            stringSecond = ""
            sign = getSign(tag: sender.tag) //the most important for the seq++ to be correct
        }
    }
    @IBOutlet weak var labelOfResult: UILabel!
    
    @IBAction func resultButton(_ sender: UIButton)
    {
      if(stringSecond == ""){
            result = finalResult(signs: sign ,string2: Double(containString2) ?? 0.0)
             if(resultHandel(resultString: String(result))){
                labelOfResult.text = String(result)
               }
             else{
                  labelOfResult.text = String(Int(result))
                 }
                 stringFirst = String(result)
            }
        else{
            containString2 = stringSecond
            result = finalResult(signs: sign)
            if(resultHandel(resultString: String(result))){
               labelOfResult.text = String(result)
              }
             else{
                 labelOfResult.text = String(Int(result))
                 }
            stringFirst = String(result)
            
          }
        stringSecond = ""
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        labelOfResult.text = "0"
        stringFirst = ""
        stringSecond = ""
        result = 0.0
        sign = .none
    }
    @IBAction func minusPlus(_ sender: UIButton) {
        var valueOfminus = 0.0
        if(stringSecond == "") {
            guard let valueOfminus = Double(stringFirst) else{return}
            if(resultHandel(resultString: String(result))){
                stringFirst = String(valueOfminus * -1)
            }
            else{
                stringFirst = String(Int(valueOfminus ) * -1)
            }
            labelOfResult.text = stringFirst
        }
        else {
            guard let valueOfminus = Double(stringSecond) else{return}
            if(resultHandel(resultString: String(result))){
                stringSecond = String(valueOfminus * -1)
            }
            else{
                stringSecond = String(Int(valueOfminus ) * -1)
            }
            labelOfResult.text = stringSecond
        }
        }
    
    @IBAction func handredButton(_ sender: UIButton) {
        
        
        var valuehandred = 0.0
        if(stringSecond == "") {
            guard let valuehandred = Double(stringFirst) else{return}
            stringFirst = String(valuehandred * (1/100))
            labelOfResult.text = stringFirst
        }
        else {
            guard let valuehandred = Double(stringSecond) else{return}
            stringSecond = String(valuehandred * (1/100))
            labelOfResult.text = stringSecond
        }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
     
}

