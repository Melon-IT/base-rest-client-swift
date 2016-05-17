//
//  MBFRequestFrame.swift
//  MelonRestClient
//
//  Created by Tomasz Popis on 18/04/16.
//  Copyright © 2016 Melon-IT. All rights reserved.
//

import Foundation

public enum MBFRequestHTTPMethod {
  case GET
  case POST
  case PUT
  case DELETE
  
  func stringValue() -> String {
    let result: String
    switch self {
    case .GET:
      result = "GET"
    case .POST:
      result = "POST"
    case .PUT:
      result = "PUT"
    case .DELETE:
      result = "DELETE"
    }
    
    return result
  }
}

public class MBFRequestFrame {
  
  public init(httpMethod: MBFRequestHTTPMethod,
              responseDataDelegate: MBFRestClientResponseDataProtocol?) {
    
    self.httpMethod = httpMethod
    self.responseDataDelegate = responseDataDelegate
    self.header = Dictionary<String,String>()
    self.uriParameters = Dictionary<String,String>()
    //NSURL
  }
  
  public weak private(set) var responseDataDelegate: MBFRestClientResponseDataProtocol?
  
  public private(set) var httpMethod: MBFRequestHTTPMethod
  
  public private(set) var uriParameters: Dictionary<String,String>?
  public private(set) var body: NSData?
  public var identifier : UInt?
  
  public var uri: String {
    return ""
  }
  
  public func setUriParameterValue(value: String, key: String) {
    self.uriParameters?[key] = value
  }
  
  public func clearUriParameters() {
    self.uriParameters?.removeAll()
  }
  
  public private(set) var header: Dictionary<String,String>
  
  public func setHeaderValue(value: String, key: String) {
    self.header[key] = value
  }
  
  public func clearHeaderParameters() {
    self.header.removeAll()
  }
}
