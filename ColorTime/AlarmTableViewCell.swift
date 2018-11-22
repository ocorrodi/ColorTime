//
//  AlarmTableViewCell.swift
//  ColorTime
//
//  Created by Victoria Corrodi on 8/4/17.
//  Copyright © 2017 Olivia Corrodi. All rights reserved.
//

//
//  AlarmTableViewCell.swift
//  ColorTime
//
//  Created by Emily Erlichson on 5/27/17.
//  Copyright © 2017 Emily Erlichson. All rights reserved.
//

import Foundation
import UIKit

protocol AlarmTableViewCellProtocol: class {
    func sendRow(row: Int, isOn: Bool)
}

class AlarmTableViewCell: UITableViewCell {
    
    weak var delegate: AlarmTableViewCellProtocol?
    @IBOutlet weak var timeDisplay: UILabel!
    var row: Int!
    @IBOutlet weak var switches: UISwitch!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var labelClock: UILabel!
    var status = UserDefaults.standard.array(forKey: "status")
    
    let dateFormatter = DateFormatter()
    
    var hour : Float = 0.0
    var second : Float = 0.0
    
    //   @IBOutlet weak var alarmSwitch: UISwitch!
    @IBAction func changedSwitch(_ sender: Any) {
        if switch1.isOn == true {
            delegate?.sendRow(row: row, isOn: true)
        }
        else {
            delegate?.sendRow(row: row, isOn: false)
        }
    }
    
    
    func doSomethingWithData(data: String) {
        timeDisplay.text = data
        //        print(dateFormatter.string(from: Date()))
    }
    
    func goOff() {
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .long
        
        dateFormatter.setLocalizedDateFormatFromTemplate("hhmmss")
        //        self.hour = Float(Calendar.current.component(.hour, from: Date()))
        //        self.minute = Float(Calendar.current.component(.minute, from: Date()))
        
        
        //        if timeDisplay.text == dateFormatter.string(from: Date()) {
        //            ViewController.updateState()
        //        }
        
        
    }
    
    
    
    
}
