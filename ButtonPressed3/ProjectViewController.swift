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
    var breakTimer = Timer()
    var breakStartTime: Date?
    
    var projectCounter = 0
    var projectTimer = Timer()
    var projectStartTime = Date.now
    var projectIsStop = false

    var storeArray: [Event] = []
    var storeCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBreakCounter()
        startProjectCounter()
        store(.Project, projectIsStop)
    }
    
//MARK: ButtonPressed
    @IBAction func buttonPressed(_ sender: UIButton) {
        var stoppedActivity: Activity
        projectIsStop = !projectIsStop
        if projectIsStop {
            stoppedActivity = .Project
            stopProjectCounter()
            continueBreakCounter()
        }
        else {
            stoppedActivity = .Break
            stopBreakCounter()
            continueProjectCounter()
        }
    store(stoppedActivity, projectIsStop)
    }
 
//MARK: Counters

    func startProjectCounter(){
        
print("BEGIN startProjectCounter")
print("projectStartTimer1: \(projectStartTime)")
print("END startProjectCounter")
        
        runProjectTimer()
        
    }

    func resetBreakCounter(){
        // breakCounter = 0
        breakLabel.text = convertToTimeFrom(number: breakCounter)
        //breakTimer.invalidate()
    }
    
    func continueBreakCounter() {
        
        if breakStartTime == nil {
            breakStartTime = Date.now
print("breakStartTime nil: \(breakStartTime!)")
        }
print("breakStartTime NOT nil: \(breakStartTime!)")
        runBreakTimer()
        
    }
    
    func stopProjectCounter() {
        
        projectTimer.invalidate()
        projectCounter += elapsedMinCalculatorFrom(projectStartTime)
        breakStartTime = Date.now
        
print("BEGIN stopProjectCounter")
        
print("projectCounter: \(projectCounter)")
print("projectStartTimer: \(projectStartTime)")
print("elapsedMinCalculatorFrom: \(elapsedMinCalculatorFrom(projectStartTime))")

print("END stopProjectCounter")
    }
    
    func stopBreakCounter() {
        breakTimer.invalidate()
        breakCounter += elapsedMinCalculatorFrom(breakStartTime!)
        projectStartTime = Date.now
        
        print("BEGIN stopBreakCounter")
                
        print("breakCounter: \(breakCounter)")
        print("breakStartTime: \(breakStartTime!)")
        print("elapsedMinCalculatorFrom: \(elapsedMinCalculatorFrom(breakStartTime!))")

        print("END stopBreakCounter")
        
    }
    
    func continueProjectCounter() {
        runProjectTimer()
    }
    
    func elapsedMinCalculatorFrom(_ startTime: Date) -> Int {
        
print("BEGIN elapsedMinCalculatorFrom")
        
print("date: \(startTime)")
        let elapsedMin = Int(startTime.timeIntervalSinceNow) * -1
print("elapsedMin: \(elapsedMin)")
        
print("END elapsedMinCalculatorFrom")
        return elapsedMin
    }
    
//MARK: Time
    func runProjectTimer() {
        projectTimer.invalidate()
        projectTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProjectTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateProjectTimer() {
        
        ProjectLabel.text = convertToTimeFrom(number: (projectCounter + elapsedMinCalculatorFrom(projectStartTime)) )
    }
    
    func runBreakTimer() {
        breakTimer.invalidate()
        breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateBreakTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateBreakTimer() {
        
        breakLabel.text = convertToTimeFrom(number: (breakCounter + elapsedMinCalculatorFrom(breakStartTime!)) )
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
//        for event in storeArray {
//print(event.time, event.stoppedActivity, event.isStop )
//        }
    }
    
}
