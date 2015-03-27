//
//  RecordedAudio.swift
//  Pitch-Perfect
//
//  Created by Asa Spikes Jamison on 3/24/15.
//  Copyright (c) 2015 Asa Spikes Jamison. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(title:String, url:NSURL) {
        self.title = title
        self.filePathUrl = url
    }
    
}