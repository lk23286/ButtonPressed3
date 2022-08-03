//
//  Counter.swift
//  ButtonPressed3
//
//  Created by Laszlo Kovacs on 2022. 08. 01..
//

import Foundation

struct Counter: Codable {
    var breakValue: Int
    var projectValue: Int
    var projectIsStop: Bool
}


enum Activity {
    case Project, Break
}

struct Event {
    let time: Date
    let isStop: Bool
    let stoppedActivity: Activity
}
