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
}

public class MBFRequestFrame {
  
  public init(httpMethod: MBFRequestHTTPMethod,
              responseDataDelegate: MBFRestClientResponseDataProtocol?) {
    
    self.httpMethod = httpMethod
    self.responseDataDelegate = responseDataDelegate
    self.header = Dictionary<String,String>()
  }
  
  public weak private(set) var responseDataDelegate: MBFRestClientResponseDataProtocol?
  
  public private(set) var httpMethod: MBFRequestHTTPMethod
  
  public var uri: String {
    return ""
  }
  
  public func setUriParameterValue(value: String, key: String) {
    fatalError("unimplemented")
  }
  
  public func clearUriParameters() {
    fatalError("unimplemented")
  }
  
  public private(set) var header: Dictionary<String,String>?
  
  public func setHeaderValue(value: String, key: String) {
    fatalError("unimplemented")
  }
  
  public func clearHeaderParameters() {
    fatalError("unimplemented")
  }
  
  public private(set) var body: NSData?
  
  public var identifier : UInt?

}
