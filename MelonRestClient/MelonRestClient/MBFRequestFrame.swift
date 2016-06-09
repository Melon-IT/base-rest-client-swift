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
    get {
      return self.request.HTTPBody
    }
    set {
      self.request.HTTPBody = self.body
    }
  }
  
  public func prepareBody() {
    
  }
  
  public var identifier : UInt?
  
  private var urlComponents: NSURLComponents
  public let request: NSMutableURLRequest
  
  public init(serviceURL: NSURL,
              httpMethod: MBFRequestHTTPMethod,
              responseDataDelegate: MBFRestClientResponseDataProtocol?) {
    self.request = NSMutableURLRequest()
    self.urlComponents = NSURLComponents()
    
    self.urlComponents.scheme = serviceURL.scheme
    self.urlComponents.host = serviceURL.host
    self.urlComponents.port = serviceURL.port
    self.urlComponents.user = serviceURL.user
    self.urlComponents.password = serviceURL.password
    self.urlComponents.path = serviceURL.path
    
    if let queryPath = self.urlComponents.path,
      let url =  NSURL(string: queryPath)?.URLByAppendingPathComponent(self.path) {
      self.urlComponents.path = queryPath + url.absoluteString
      
    } else {
      self.urlComponents.path = NSURL(string: self.path)?.absoluteString
    }
    
    self.request.HTTPMethod = httpMethod.stringValue()
    self.request.URL = self.urlComponents.URL
    
    self.responseDataDelegate = responseDataDelegate
  }
  
  public var path: String {
    return ""
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
