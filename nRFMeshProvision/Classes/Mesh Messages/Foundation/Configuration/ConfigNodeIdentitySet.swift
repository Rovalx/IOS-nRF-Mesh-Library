//
//  ConfigNodeIdentitySet.swift
//  Qorvo
//
//  Created by Dominik Majda on 10/05/2021.
//  Copyright © 2021 Dominik Majda. All rights reserved.
//

import Foundation

public struct ConfigNodeIdentitySet: ConfigNetKeyMessage, AcknowledgedConfigMessage {
    public static let opCode: UInt32 = 0x8047
    public static let responseType: StaticMeshMessage.Type = ConfigNodeIdentityStatus.self
    public var networkKeyIndex: KeyIndex
    public let state: UInt8
    
    public var parameters: Data? {
        let data = encodeNetKeyIndex() + state
        return data
    }
    
    public init(networkKey: NetworkKey, state: UInt8) {
        self.networkKeyIndex = networkKey.index
        self.state = state
    }
    
    public init?(parameters: Data) {
        guard parameters.count == 18 else {
            return nil
        }
        networkKeyIndex = ConfigNetKeyUpdate.decodeNetKeyIndex(from: parameters, at: 0)
        state = parameters[3] & 0xFF
    }
}
