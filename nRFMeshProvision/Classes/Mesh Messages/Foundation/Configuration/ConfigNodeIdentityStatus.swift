//
//  ConfigNodeIdentityStatus.swift
//  Qorvo
//
//  Created by Dominik Majda on 10/05/2021.
//  Copyright © 2021 Dominik Majda. All rights reserved.
//

import Foundation

public struct ConfigNodeIdentityStatus: ConfigNetKeyMessage {
    public static let opCode: UInt32 = 0x8048
    
    public var parameters: Data? {
        return encodeNetKeyIndex() + state
    }
    
    public let networkKeyIndex: KeyIndex
    public let state: UInt8
    
    public var isSuccessful: Bool {
        return state == 0x00
    }
    
    public init(networkKey: NetworkKey, state: UInt8) {
        self.networkKeyIndex = networkKey.index
        self.state = state
    }
    
    public init?(parameters: Data) {
        guard parameters.count == 4 else {
            return nil
        }
        self.networkKeyIndex = ConfigNetKeyStatus.decodeNetKeyIndex(from: parameters, at: 1)
        self.state = parameters[0]
    }
}
