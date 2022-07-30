//
//  ViewController.swift
//  storeDataInPlistStudyBetweenSegueWays
//
//  Created by Laszlo Kovacs on 2022. 07. 29..
//

import UIKit

class ViewController1: UIViewController {

    @IBOutlet weak var firstNumberLabel: UILabel!
    
    var firstNumber = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNumberLabel.text =  String(firstNumber)
        
        print("ViewDidLoad2")
        
        
        // Do any additional setup after loading the view.
    }


    @IBAction func increaseButtonPresssed(_ sender: UIButton) {
        
       firstNumber += 2
        
        firstNumberLabel.text = String(firstNumber)
    }
    

}

