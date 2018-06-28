//
//  RNShellResult.swift
//  RNShell
//
//  Created by Rayhan Janam on 6/28/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

import Foundation

public struct RNShellResult {
    
    private(set) public var exitCode: Int32
    private(set) public var output: String?
    private(set) public var error: String?
    
    public var firstLineOfOutput: String? {
        return self.output?.components(separatedBy: "\n").first
    }
    
    public var firstLineOfError: String? {
        return self.error?.components(separatedBy: "\n").first
    }
    
    public var resultType: RNShellResultType {
        switch exitCode {
        case 0:
            return .success
        default:
            return .failure
        }
    }
    
}
