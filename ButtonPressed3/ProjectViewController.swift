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
    var projectStartTimer = Date.now
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
            continueBreakCounter()
            stopProjectCounter()
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
        runProjectTimer()
    }

    func resetBreakCounter(){
        breakCounter = 0
        breakLabel.text = convertToTimeFrom(number: breakCounter)
        breakTimer.invalidate()
    }
    
    func continueBreakCounter() {
        
        if breakStartTime == nil {
            breakStartTime = Date.now
        }
        runBreakTimer()
        
    }
    
    func stopProjectCounter() {
        projectTimer.invalidate()
        projectCounter += elapsedMinCalculatorFrom(startTime: projectStartTimer)
        projectStartTimer = Date.now
    }
    
    func stopBreakCounter() {
        breakTimer.invalidate()
        breakCounter += elapsedMinCalculatorFrom(startTime: breakStartTime!)
        breakStartTime = Date.now
    }
    
    func continueProjectCounter() {
        runProjectTimer()
    }
    
    func elapsedMinCalculatorFrom(startTime: Date) -> Int {
        
        print(startTime)
        
        var date = Date()
        date = startTime
        let elapsedMin = Int(date.timeIntervalSinceNow) * -1
    
        return elapsedMin
    }
    
//MARK: Time
    func runProjectTimer() {
        projectTimer.invalidate()
        projectTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProjectTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateProjectTimer() {
        
        projectCounter = elapsedMinCalculatorFrom(startTime: projectStartTimer)
        ProjectLabel.text = convertToTimeFrom(number: projectCounter)
    }
    
    func runBreakTimer() {
        breakTimer.invalidate()
        breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateBreakTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateBreakTimer() {
        breakCounter = elapsedMinCalculatorFrom(startTime: breakStartTime!)
        breakLabel.text = convertToTimeFrom(number: breakCounter)
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
            print(event.time, event.stoppedActivity, event.isStop )
        }
    }
    
}
