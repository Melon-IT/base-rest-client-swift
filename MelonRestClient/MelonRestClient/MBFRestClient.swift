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

public protocol MBFNetworkAvailabilityProtocol: class {
  var currentStatus: MBFRestClientNetworkType { get }
}

public protocol MBFRestClientActivityProtocol: class {
  func requestActive(active: Bool)
  func expiredAuthorizationToken()
  func serverErrorWithStatusCode(statusCode: Int)
}

public protocol MBFSilentAuthorizationProtocol: class {
  func silentAuthorization()
}

public protocol MBFRestClientResponseDataProtocol: class {
  func processData(data: AnyObject)
}

public class MBFRestClient {
  public weak var activityDelegate: MBFRestClientActivityProtocol?
  public weak var networkDelegate: MBFNetworkAvailabilityProtocol?
  public weak var authorizationDelegate: MBFSilentAuthorizationProtocol?
  
  public var lastFrame: MBFRequestFrame?
  public private(set) var webServiceURI: NSURL?
  
  public init(webServiceURI: NSURL) {
    self.webServiceURI = webServiceURI
  }
  
  public init(webServiceURIString: String) {
    self.webServiceURI = NSURL.init(string: webServiceURIString)
  }
  
  public func sendRequestWithFrame(frame: MBFRequestFrame) {
    fatalError("unimplemented")
  }
}
