//
//  ViewController2.swift
//  storeDataInPlistStudyBetweenSegueWays
//
//  Created by Laszlo Kovacs on 2022. 07. 30..
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var secondNumberLabel: UILabel!
    
    var secondNumber = 0
    
    let secondKey = "secondKey"
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondNumber = defaults.integer(forKey: secondKey)
        
        secondNumberLabel.text = String(secondNumber)
        
        print("ViewDidLoad1")

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func increaseButtonPressed(_ sender: UIButton) {
        
        secondNumber += 2
        secondNumberLabel.text = String(secondNumber)
        
        defaults.set(secondNumber, forKey: secondKey)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        defaults.set(0, forKey: secondKey)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
