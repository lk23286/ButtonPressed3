//
//  ProjectViewController.swift
//  ButtonPressed3
//
//  Created by Laszlo Kovacs on 2022. 06. 29..
//

import UIKit

class ProjectViewController: UIViewController {

    @IBOutlet weak var ProjectLabel: UILabel!
  
    @IBOutlet weak var breakLabel: UILabel!
 
    var breakCounter = 0
    var projectCounter = 0
    var isStop = false
    var projectTimer = Timer()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      resetBreak()
        startProject()
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        isStop = !isStop
        if isStop {
          
            continueBreak()
            stopProject()
            
        }else {
            stopBreak()
            continueProject()
        }
      
        store()
    }
    
    func stopProjectTimer() {
        projectTimer.invalidate()
    }
    
    
    func runProjectTimer() {
        projectTimer.invalidate()
        projectTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProjectTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateProjectTimer() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        ProjectLabel.text = dateString
        
    }
    
    
    
    func runBreakTimer() {
        projectTimer.invalidate()
        projectTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProjectTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateProjectTimer() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        ProjectLabel.text = dateString
        
    }
    
    func resetBreak(){
        breakLabel.text = "0:00:00"
    }
    
    func startProject(){
       // ProjectLabel.text = "0:00:01"
        projectCounter += 1
        runProjectTimer()
        
    }
    
    func continueBreak() {
        breakLabel.text = "0:01:01"
        breakCounter += 1
    }
    func stopProject() {
        ProjectLabel.text = "0:01:00"
        stopProjectTimer()
    }
    func stopBreak() {
        breakLabel.text = "0:01:00"
    }
    func continueProject() {
        ProjectLabel.text = "0:01:01"
        projectCounter += 1
    }
    
    func store() {
        print("Store: time, isStop, activity")
        print("projectCounter: \(projectCounter)")
        print("breakCounter: \(breakCounter)")
    }
}
