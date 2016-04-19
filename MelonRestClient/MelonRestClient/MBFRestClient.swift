//
//  MBFRestClient.swift
//  MelonRestClient
//
//  Created by Tomasz Popis on 18/04/16.
//  Copyright © 2016 Melon-IT. All rights reserved.
//

import Foundation

public enum MBFRestClientNetworkType {
  case None
  case WiFi
  case WWAN
}

public protocol MBFNetworkAvailabilityProtocol {
  var currentStatus: MBFRestClientNetworkType { get }
}

public protocol MBFRestClientActivityProtocol {
  func requestActive(active: Bool)
  func expiredAuthorizationToken()
  func serverErrorWithStatusCode(statusCode: Int)
}

public protocol MBFSilentAuthorizationProtocol {
  func silentAuthorization()
}

public protocol MBFRestClientResponseDataProtocol: class {
  func processData(data: AnyObject)
}

public class MBFRestClient {
  
}
