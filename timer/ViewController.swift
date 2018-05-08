//
//  ViewController.swift
//  timer
//
//  Created by Oka Yuya on 2017/10/09.
//  Copyright © 2017年 Oka Yuya. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!

    fileprivate var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = "00:00"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerTarget(_:)), userInfo: nil, repeats: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer.fire()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    fileprivate func fire() {
        let soundIdRring: SystemSoundID = 1013
        AudioServicesPlaySystemSound(soundIdRring)
    }

    func timerTarget(_ timer: Timer) {
        guard let timerText = timerLabel.text else {
            return
        }
        let numbers = timerText.components(separatedBy: ":")
        var minute = Int(numbers.first!) //分
        var second = Int(numbers.last!) // 秒

        second! += 1
        if second == 60 {
            minute! += 1
            second = 0
        }
        if minute == 60 {
            timer.invalidate()
        }
        let minuteString = minute! < 10 ? "0\(minute!)" : "\(minute!)"
        let secondString = second! < 10 ? "0\(second!)" : "\(second!)"
        timerLabel.text = String(format: "\(minuteString):\(secondString)")

        if timerLabel.text == "03:00" {
            fire()
        }
        if timerLabel.text! == "05:00" {
            fire()
            timer.invalidate()
        }
    }
}
