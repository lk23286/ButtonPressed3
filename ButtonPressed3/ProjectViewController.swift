//
//  ProjectViewController.swift
//  ButtonPressed3
//
//  Created by Laszlo Kovacs on 2022. 06. 29..
//

import UIKit



class ProjectViewController: UIViewController {
    
//MARK: Initiate stage
    
    @IBOutlet weak var ProjectLabel: UILabel!
    @IBOutlet weak var breakLabel: UILabel!
 
    var counter = Counter(breakValue: 0, projectValue: 0, projectIsStop: false)
    
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
    
    let key = "CounterData"
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    func loadCounter() -> Counter {
        
        var tempCounter: Counter = Counter(breakValue: 0, projectValue: 0, projectIsStop: false)
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                tempCounter = try decoder.decode(Counter.self, from: data)
            } catch {
                print("error decoding counter:\(error) ")
            }
        }
        
        return tempCounter
    }
    
    func saveCounter( counterToBeStored count: Counter) {
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(count)
            try data.write(to: dataFilePath!)
            
        } catch {
            print("error encoding counter: \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadedCounter = loadCounter()
        print("loadedCounter: \(loadedCounter)")

        counter = loadedCounter

        let recoveredProjectTimeString = convertToTimeFrom(number: counter.projectValue)
        ProjectLabel.text = recoveredProjectTimeString
        
        let recoveredBreakTimerString = convertToTimeFrom(number: counter.breakValue)
        breakLabel.text = recoveredBreakTimerString

        if counter.projectIsStop {
            stopProjectCounter()
            continueBreakCounter()
        } else {
            stopBreakCounter()
            continueProjectCounter()
        }
      //  store(.Project, projectIsStop)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("viewDidDisappear")
        
        projectTimer.invalidate()
        breakTimer.invalidate()
        
        saveCounter(counterToBeStored: Counter(breakValue: 0, projectValue: 0, projectIsStop: false))
    }
    
//MARK: ButtonPressed
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        counter.projectIsStop = !counter.projectIsStop
        defaults.set(counter.projectIsStop, forKey: projectIsKey)
       
        if counter.projectIsStop {
            stopProjectCounter()
            continueBreakCounter()
        }
        else {
            stopBreakCounter()
            continueProjectCounter()
        }
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
        runBreakTimer()
    }
    
    func stopProjectCounter() {
        projectTimer.invalidate()
        counter.projectValue += elapsedMinCalculatorFrom(projectStartTime)
        breakStartTime = Date.now
    }
    
    func stopBreakCounter() {
        breakTimer.invalidate()
        counter.breakValue += elapsedMinCalculatorFrom(breakStartTime)
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
        let projectSumTime = counter.projectValue + elapsedMinCalculatorFrom(projectStartTime)
        ProjectLabel.text = convertToTimeFrom(number: projectSumTime)
        
        counter.projectValue = projectSumTime
        saveCounter(counterToBeStored: counter)
        
       // defaults.set(projectSumTime, forKey: projectKey)
        breakLabel.alpha = 0.5
    }
    
    func runBreakTimer() {
        breakTimer.invalidate()
        breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateBreakTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateBreakTimer() {
        breakLabel.alpha = 1
        let breakSumTime = counter.breakValue + elapsedMinCalculatorFrom(breakStartTime)
        breakLabel.text = convertToTimeFrom(number: breakSumTime)
       
        counter.breakValue = breakSumTime
        saveCounter(counterToBeStored: counter)
        
       // defaults.set(breakSumTime, forKey: breakKey)
        
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
    }
    
}
