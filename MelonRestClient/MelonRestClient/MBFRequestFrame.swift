//
//  MBFRequestFrame.swift
//  MelonRestClient
//
//  Created by Tomasz Popis on 18/04/16.
//  Copyright © 2016 Melon-IT. All rights reserved.
//

import Foundation

public enum MBFRequestHTTPMethod: Int {
  case NONE
  case GET
  case POST
  case PUT
  case DELETE
  
  
  public func stringValue() -> String {
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
      
    case .NONE:
      result = ""
    }
    
    return result
  }
  
  public init(value: String) {
    self =  MBFRequestHTTPMethod.valueFromString(value)
  }
  
  public static func valueFromString(string: String) -> MBFRequestHTTPMethod {
    let result: MBFRequestHTTPMethod
    
    switch string {
    case MBFRequestHTTPMethod.GET.stringValue():
      result = .GET
      
    case MBFRequestHTTPMethod.POST.stringValue():
      result = .POST
      
    case MBFRequestHTTPMethod.PUT.stringValue():
      result = .PUT
      
    case MBFRequestHTTPMethod.DELETE.stringValue():
      result = .DELETE
      
    default:
      result = MBFRequestHTTPMethod.NONE
      
    }
    
    return result
  }
}

public class MBFRequestFrame {
  
  public weak private(set) var responseDataDelegate: MBFRestClientResponseDataProtocol?
  
  public var httpMethod: MBFRequestHTTPMethod? {
    
    return MBFRequestHTTPMethod(value: self.request.HTTPMethod)
  }
  
  public var body: NSData? {
    didSet {
      self.request.HTTPBody = self.body
    }
  }
  
  public var identifier : UInt?
  
  private var urlComponents: NSURLComponents
  public let request: NSMutableURLRequest
  
  public init(serviceURL: String,
              path: String,
              httpMethod: MBFRequestHTTPMethod,
              responseDataDelegate: MBFRestClientResponseDataProtocol?) {
    
    self.urlComponents = NSURLComponents()
    
    if var url = NSURL(string: serviceURL) {
      url = url.URLByAppendingPathComponent(path)
      self.urlComponents.scheme = url.scheme
      self.urlComponents.host = url.host
      self.urlComponents.port = url.port
      self.urlComponents.user = url.user
      self.urlComponents.password = url.password
      self.urlComponents.path = url.path
    }
    
    self.request = NSMutableURLRequest()
    self.request.HTTPMethod = httpMethod.stringValue()
    self.request.URL = self.urlComponents.URL
    
    self.responseDataDelegate = responseDataDelegate
  }
  
  public func setQueryItem(name: String, value: String) {
    if var queryItems = self.urlComponents.queryItems {
      queryItems.append(NSURLQueryItem(name: name, value: value))
    } else {
      self.urlComponents.queryItems = [NSURLQueryItem(name: name, value: value)]
    }
  }
  
  public func clearAllQueryItems() {
    self.urlComponents.queryItems?.removeAll()
  }
  
  public func setHeaderValue(value: String, key: String) {
    self.request.setValue(value, forHTTPHeaderField: key)
  }
}
