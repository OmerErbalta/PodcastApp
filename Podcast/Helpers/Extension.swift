//
//  Extension.swift
//  Podcast
//
//  Created by OmerErbalta on 13.07.2024.
//

import UIKit
import CoreMedia
extension UIImageView{
    func customMode(){
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension CMTime{
    func formatString() ->String{
        let totalSecond = Int(CMTimeGetSeconds(self))
        let second = totalSecond % 60
        let minute = totalSecond / 60
        let formatString = String(format: "%02d : %02d",minute ,second)
        return formatString
    }
}
extension NSNotification.Name{
    static let downloadNotificationName = NSNotification.Name(rawValue: "downloadNotificationName")
}
