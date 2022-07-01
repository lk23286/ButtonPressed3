//
//  ProjectViewController.swift
//  ButtonPressed3
//
//  Created by Laszlo Kovacs on 2022. 06. 29..
//

import UIKit

enum Activity {
    case Project, Break
}

struct Event {
    let time: Date
    let isStop: Bool
    let stoppedActivity: Activity
    
}



class ProjectViewController: UIViewController {

    @IBOutlet weak var ProjectLabel: UILabel!
  
    @IBOutlet weak var breakLabel: UILabel!
 
    var breakCounter = 0
    var projectCounter = 0
    var isStop = false
    var projectTimer = Timer()
    var breakTimer = Timer()
    var storeArray: [Event] = []
    var storeCounter = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBreak()
        startProject()
        store(.Project, isStop)
        
    }
    
//MARK: ButtonPushed
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        var stoppedActivity: Activity
        
        isStop = !isStop
        if isStop {
            stoppedActivity = .Project
            continueBreak()
            stopProject()
            
            
        }else {
            
            stoppedActivity = .Break
            stopBreak()
            continueProject()
           
        }
    store(stoppedActivity, isStop)
    
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
    
    func store(_ activity: Activity, _ isStop: Bool ) {
        
        let date = Date()
        
        storeCounter += 1
        
        storeArray.append(Event(time: date, isStop: isStop, stoppedActivity: activity))
        print(storeCounter)
        for event in storeArray {
            print(event.time, event.stoppedActivity, event.isStop )
            
        }
        
    }
    
    
}
