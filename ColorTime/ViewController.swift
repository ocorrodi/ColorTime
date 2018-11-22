//
//  ViewController.swift
//  ColorTime
//
//  Created by Victoria Corrodi on 8/4/17.
//  Copyright © 2017 Olivia Corrodi. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var labelClock: UILabel!
    let dateFormatter = DateFormatter()
    @IBOutlet weak var hex: UILabel!
    var alarmSaver = [String():Date()]
    var hour : Float = 0.0
    
    var second: Float = 0.0
    
    var minute:  Float = 0.0
    
    var hexNum: String = ""
    
    var alarmOn: Bool = false
    
    var isGoingOff = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.dictionary(forKey: "alarms") != nil {
            alarmSaver = UserDefaults.standard.dictionary(forKey: "alarms") as! [String : Date]
        }
        // Do any additional setup after loading the view.
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .long
        
        dateFormatter.setLocalizedDateFormatFromTemplate("hhmmss")
        super.viewDidLoad()
        timerMethod()
        
        if !alarmOn {
            timerMethod()
        }
        ani()
        
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats:true);
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .long
        
        dateFormatter.setLocalizedDateFormatFromTemplate("hhmmss")
        super.viewDidLoad()
        timerMethod()
        
        if !alarmOn {
            timerMethod()
        }
        ani()
        
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats:true);
        

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.view.backgroundColor = UIColor.blue
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateState() -> Void {
        alarmOn = !alarmOn
    }
    
    
    func updateLabel() -> Void {
        dateFormatter.setLocalizedDateFormatFromTemplate("hhmmss")
        labelClock.text = dateFormatter.string(from: Date());
    }
    func ani() {
        UIView.animate(withDuration: 1, delay: 0, options:[UIViewAnimationOptions.allowUserInteraction,UIViewAnimationOptions.repeat,UIViewAnimationOptions.autoreverse], animations: {
            
            self.hour = Float(Calendar.current.component(.hour, from: Date()))
            self.second = Float(Calendar.current.component(.second, from: Date()))
            self.minute = Float(Calendar.current.component(.minute, from: Date()))
            
            let swiftColor = UIColor(red: CGFloat(self.hour/24.0), green: CGFloat(self.minute/60.0), blue: CGFloat(self.second/60.0), alpha: 0.75)
            var currentTime = Calendar.current.date(from: DateComponents())
            let hrInt = Int(self.hour)
            let hrStr = "\(self.hour)"
            let secondStr = "\(self.second)"
            let minuteStr = "\(self.minute)"
            
            self.view.backgroundColor = swiftColor
            self.hexNum = swiftColor.hexString as String
            
            //let converted = self.alarmSaver as! [Date]
            if UserDefaults.standard.dictionary(forKey: "alarms") != nil {
                self.alarmSaver = UserDefaults.standard.dictionary(forKey: "alarms") as! [String:Date]
            }

            for alarm in self.alarmSaver {
//                let dfHr = DateFormatter();
//                dfHr.dateFormat = "h";
//                let alarmHr = dfHr.string(from: alarm)
//                print(alarmHr)
                //var intAlarm = round(alarm.timeIntervalSince1970)
                if currentTime?.compare(alarm.value) == .orderedSame || currentTime?.compare(alarm.value) == .orderedAscending {
                    //print("alarm is going off")
                    self.isGoingOff = true
                }

            }
            
            self.hex.textAlignment = .center
            
            self.hex.text = self.hexNum
            
            
            
        } )
        
    }
    
    
    func timerMethod() {
        
        _ = Timer()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.ani), userInfo: nil, repeats:true);
        
        
        
        
        
    }
    
    
    
    
}

extension UIColor{
    
    var hexString:NSString {
        let colorRef = self.cgColor.components
        
        let r:CGFloat = colorRef![0]
        let g:CGFloat = colorRef![1]
        let b:CGFloat = colorRef![2]
        
        return NSString( format: "#%01lX%01lX%01lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
    }
}
