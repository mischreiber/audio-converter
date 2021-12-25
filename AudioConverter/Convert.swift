//
//  Convert.swift
//  AudioConverter
//
//  Created by Mike Schreiber on 2/15/21.
//

import Foundation

@discardableResult
func shell(_ args: String...) -> Int32 {
    let task = Process()
    let bundle = Bundle.main
    task.executableURL = bundle.url(forResource: "ffmpeg", withExtension: nil)
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}
