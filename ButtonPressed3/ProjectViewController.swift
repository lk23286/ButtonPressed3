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
    var breakTimer = Timer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        resetBreak()
        startProject()
        
    }
    
//MARK: ButtonPushed
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
    
//MARK: Time
    func runProjectTimer() {
        projectTimer.invalidate()
        projectTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProjectTimer), userInfo: nil, repeats: true)
    }


    @objc func updateProjectTimer() {
        projectCounter += 1
        ProjectLabel.text = String(projectCounter)
    }
   
    func runBreakTimer() {
        breakTimer.invalidate()
        breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateBreakTimer), userInfo: nil, repeats: true)
    }
    @objc func updateBreakTimer() {
        breakCounter += 1
        breakLabel.text = String(breakCounter)
    }
    
    
//MARK: main functions
    
    func stopProjectTimer() {
        projectTimer.invalidate()
    }
    
    func resetBreak(){
        breakCounter = 0
        breakLabel.text = String(breakCounter)
        breakTimer.invalidate()
    }
    
    func startProject(){
        runProjectTimer()
    }
    
    func continueBreak() {
        runBreakTimer()
    }
    func stopProject() {
        stopProjectTimer()
    }
    func stopBreak() {
        breakTimer.invalidate()
    }
    func continueProject() {
        runProjectTimer()
       
    }
    
    //MARK: store
    
    func store() {
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        let nowString = df.string(from: date)
        print("date: \(date)")
        print("nowString: \(nowString)")
        
        print("Store: time, isStop, activity")
        print("projectCounter: \(projectCounter)")
        print("breakCounter: \(breakCounter)")
    }
    
    
}
