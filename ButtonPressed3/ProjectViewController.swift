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
    var projectIsStop = false
    var projectTimer = Timer()
    var breakTimer = Timer()
    var storeArray: [Event] = []
    var storeCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBreakCounter()
        startProjectCounter()
        store(.Project, projectIsStop)
    }
    
//MARK: ButtonPushed
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
    
//MARK: Time
    func runProjectTimer() {
        projectTimer.invalidate()
        projectTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProjectTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateProjectTimer() {
        projectCounter += 1
        ProjectLabel.text = convertToTimeFrom(number: projectCounter)
    }
    
    func runBreakTimer() {
        breakTimer.invalidate()
        breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateBreakTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateBreakTimer() {
        breakCounter += 1
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
    
//MARK: Counters

    func resetBreakCounter(){
        breakCounter = 0
        breakLabel.text = convertToTimeFrom(number: breakCounter)
        breakTimer.invalidate()
    }
    
    func startProjectCounter(){
        runProjectTimer()
    }
    
    func continueBreakCounter() {
        runBreakTimer()
    }
    
    func stopProjectCounter() {
        projectTimer.invalidate()
    }
    
    func stopBreakCounter() {
        breakTimer.invalidate()
    }
    
    func continueProjectCounter() {
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
