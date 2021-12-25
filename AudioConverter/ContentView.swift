//
//  ContentView.swift
//  AudioConverter
//
//  Created by Mike Schreiber on 2/15/21.
//

import SwiftUI

struct ContentView: View {
    @State var filename = ""
    @State var label: String? = nil
    @State var processing = false

    var body: some View {
        VStack {
            if self.processing {
                ProgressView()
            }
            else if let label = self.label {
                Text(label)
                    .font(.title)

            } else {
                Button("Convert M4A to MP3") {
                    let panel = NSOpenPanel()
                    panel.allowsMultipleSelection = false
                    panel.canChooseDirectories = false
                    panel.allowedFileTypes = [ "m4a" ]
                    if panel.runModal() == .OK {
                        self.filename = panel.url?.path ?? ""
                        if self.filename != "" {
                            processing = true
                            let x = shell("-n", "-i", "\(self.filename)", "\(self.filename.replacingOccurrences(of: "m4a", with: "mp3"))")
                            processing = false

                            if x == 0 {
                                label = "Success! 🥳"
                            } else {
                                label = "Failure 😥"
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .frame(width: 300.0, height: 200.0)
        .controlSize(.large)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
