//
//  RNShell.swift
//  RNShell
//
//  Created by Rayhan Janam on 6/28/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import Foundation

public class RNShell {
    
    public let defaultCommandPath = "/usr/bin/env"
    
    public var commandPath: String?
    public var arguments: [String]?
    
    public init() {
        
        self.commandPath = nil
        self.arguments = nil
        
    }
    
    
    public convenience init(withCommandPath command: String) {
        
        self.init()
        self.commandPath = command
        
    }
    
    public convenience init(withCommandPath command: String, andArguments args: String...) {
        
        self.init()
        self.commandPath = command
        self.arguments = args
        
    }
    
    public convenience init(withArgumentsForDefaultShell args: String...) {
        
        self.init()
        self.commandPath = self.defaultCommandPath
        self.arguments = args
        
    }
    
    public func runCommand() -> RNShellResult? {
        
        if self.commandPath != nil {
            let shellProcess = Process()
            
            shellProcess.launchPath = self.commandPath
            shellProcess.arguments = self.arguments
            
            let outputPipe = Pipe()
            shellProcess.standardOutput = outputPipe
            
            let errorPipe = Pipe()
            shellProcess.standardError = errorPipe
            
            shellProcess.launch()
            
            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
            
            shellProcess.waitUntilExit()
            
            let outputString = String(data: outputData, encoding: .utf8)
            let errorString = String(data: errorData, encoding: .utf8)
            
            let output = outputString!.count > 0 ? outputString! : nil
            let error = errorString!.count > 0 ? errorString! : nil
            let exitCode = shellProcess.terminationStatus
            
            return RNShellResult(exitCode: exitCode, output: output, error: error)
            
        }
        
        return nil
    }
    
}









