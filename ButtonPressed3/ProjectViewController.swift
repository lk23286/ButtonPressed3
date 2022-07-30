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
    
//MARK: Initiate stage
    
    @IBOutlet weak var ProjectLabel: UILabel!
    @IBOutlet weak var breakLabel: UILabel!
 
    var breakCounter = 0
    var breakTimer = Timer()
    var breakStartTime = Date.now
    
    var projectCounter = 0
    var projectTimer = Timer()
    var projectStartTime = Date.now
    var projectIsStop = false

    var storeArray: [Event] = []
    var storeCounter = 0
    
    var defaults = UserDefaults.standard
    let projectKey = "projectKey"
    let breakKey = "breakKey"
    let projectIsKey = "projectIsKey"
 
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
        
        let projectTimeStored = defaults.integer(forKey: projectKey)
        
        projectCounter = projectTimeStored
        let recoveredProjectTimeString = convertToTimeFrom(number: projectTimeStored)
        ProjectLabel.text = recoveredProjectTimeString
        print("Project: \(projectTimeStored), \(recoveredProjectTimeString) " )
        
        let projectIsStopStored = defaults.bool(forKey: projectIsKey)
        projectIsStop = projectIsStopStored
        print("ProjectIsStopped? : \(projectIsStopStored)")
        
        let breakTimerStored = defaults.integer(forKey: breakKey)
        breakCounter = breakTimerStored
        
        let recoveredBreakTimerString = convertToTimeFrom(number: breakTimerStored)
        breakLabel.text = recoveredBreakTimerString
        
        print("Break: \(breakTimerStored), \(recoveredBreakTimerString)")
        
        if projectIsStop {
            stopProjectCounter()
            continueBreakCounter()
        } else {
            stopBreakCounter()
            continueProjectCounter()
        }
        
        store(.Project, projectIsStop)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("ViewWillDisappear")
        
        let zero: Int = 0
        
        defaults.set(zero, forKey: projectKey)
        print(defaults.integer(forKey: projectKey))
        
        defaults.set(zero, forKey: breakKey)
        print(defaults.integer(forKey: breakKey))
        
        defaults.set(false, forKey: projectIsKey)
                      print(defaults.bool(forKey: projectIsKey))
        
        
    }
    
//MARK: ButtonPressed
    @IBAction func buttonPressed(_ sender: UIButton) {
      //  var stoppedActivity: Activity
        
        projectIsStop = !projectIsStop
        defaults.set(projectIsStop, forKey: projectIsKey)
print(projectIsStop)
       
        if projectIsStop {
         //   stoppedActivity = .Project
            stopProjectCounter()
            continueBreakCounter()
        }
        else {
          //  stoppedActivity = .Break
            stopBreakCounter()
            continueProjectCounter()
        }
   // store(stoppedActivity, projectIsStop)
     
    }
 
//MARK: Counters

    func startProjectCounter(){
        runProjectTimer()
    }

    func resetBreakCounter(){
        breakLabel.text = convertToTimeFrom(number: 0)
        breakLabel.alpha = 0.5
    }
    
    func continueBreakCounter() {
//        if breakStartTime == nil {
//            breakStartTime = Date.now
//        }
        runBreakTimer()
    }
    
    func stopProjectCounter() {
        
        projectTimer.invalidate()
        projectCounter += elapsedMinCalculatorFrom(projectStartTime)
        breakStartTime = Date.now
    }
    
    func stopBreakCounter() {
        breakTimer.invalidate()
        breakCounter += elapsedMinCalculatorFrom(breakStartTime)
        projectStartTime = Date.now
    }
    
    func continueProjectCounter() {
        runProjectTimer()
    }
    
    func elapsedMinCalculatorFrom(_ startTime: Date) -> Int {
        let elapsedMin = Int(startTime.timeIntervalSinceNow) * -1
        return elapsedMin
    }
    
//MARK: Time
    func runProjectTimer() {
        projectTimer.invalidate()
        projectTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProjectTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateProjectTimer() {
        
        ProjectLabel.alpha = 1
        let projectSumTime = projectCounter + elapsedMinCalculatorFrom(projectStartTime)
        ProjectLabel.text = convertToTimeFrom(number: projectSumTime)
        defaults.set(projectSumTime, forKey: projectKey)
        breakLabel.alpha = 0.5
    }
    
    func runBreakTimer() {
        breakTimer.invalidate()
        breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateBreakTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateBreakTimer() {
        
        breakLabel.alpha = 1
        let breakSumTime = breakCounter + elapsedMinCalculatorFrom(breakStartTime)
        breakLabel.text = convertToTimeFrom(number: breakSumTime)
        defaults.set(breakSumTime, forKey: breakKey)
        ProjectLabel.alpha = 0.5
      
    }
    
    func convertToTimeFrom(number: Int) -> String {
        var resultString = ""
        let hour = number / 3600
        let minute = ( number % 3600 ) / 60
        let second = ( number % 3600) % 60
        resultString = "\(hour):"
        resultString += addZero(number: minute) + ":"
        resultString += addZero(number: second)
        return resultString
    }
    
    func addZero(number num: Int) -> String {
        var resultString = ""
        if num < 10 {
            resultString = "0\(num)"
        }else {
            resultString = String(num)
        }
      return resultString
    }
    
    //MARK: store
    func store(_ activity: Activity, _ isStop: Bool ) {
        let date = Date()
        storeCounter += 1
        storeArray.append(Event(time: date, isStop: isStop, stoppedActivity: activity))
        for event in storeArray {
//print(event.time, event.stoppedActivity, event.isStop )
        }
    }
    
}
