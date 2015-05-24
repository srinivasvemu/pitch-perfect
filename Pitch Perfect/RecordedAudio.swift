//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Srinivas Vemu on 5/23/15.
//  Copyright (c) 2015 SV. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    
    init(URL: NSURL, TitleString: String) {
        filePathUrl = URL
        title = TitleString
    }
}