//
//  HealthAttentionSet.swift
//  Qorvo
//
//  Created by Dominik Majda on 08/10/2020.
//  Copyright © 2020 Dominik Majda. All rights reserved.
//

import Foundation

public struct HealthAttentionSet: StaticVendorMessage {
    public static let opCode: UInt32 = 0x8005
    
    // The value of how long device will anounce the health status
    public var attentionTime: UInt8 = 5
    
    public var parameters: Data? {
        return Data([attentionTime & 0xFF])
    }
    
    public init() {}
    
    public init?(parameters: Data) {
        if parameters.count == 1 {
            return nil
        }
        
        attentionTime = parameters[0]
    }
}
