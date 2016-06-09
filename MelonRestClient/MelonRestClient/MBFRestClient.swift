//
//  MBFRestClient.swift
//  MelonRestClient
//
//  Created by Tomasz Popis on 18/04/16.
//  Copyright © 2016 Melon-IT. All rights reserved.
//

import Foundation

public struct MBFRestClientNetworkType: OptionSetType {
  public let rawValue: Int
  
  public init(rawValue: Int) {self.rawValue = rawValue}
  
  static let WiFi = MBFRestClientNetworkType(rawValue: 1)
  static let WWAN = MBFRestClientNetworkType(rawValue: 2)
}

public protocol MBFNetworkAvailabilityProtocol: class {
  var currentStatus: MBFRestClientNetworkType { get }
}

public protocol MBFRestClientActivityProtocol: class {
  func requestActive(active: Bool)
  func expiredAuthorizationToken()
}

public protocol MBFSilentAuthorizationProtocol: class {
  func silentAuthorization()
}

public protocol MBFRestClientResponseDataProtocol: class {
  func processData(data: AnyObject?)
  func serverRespondWithStatusCode(statusCode: Int)
}

public protocol MBFRestClientStatusCodeProtocol: class {
  func isSuccessForCode(code: Int) -> Bool
}

public protocol MBFRestClientDataConverterProtocol: class {
  func convertData(data: NSData?, requestIdentifier: UInt?) -> AnyObject
}

typealias MBFRestResponse = (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void

public class MBFRestClient {
  
  public weak var activityDelegate: MBFRestClientActivityProtocol?
  public weak var networkDelegate: MBFNetworkAvailabilityProtocol?
  public weak var authorizationDelegate: MBFSilentAuthorizationProtocol?
  public weak var statusCodeDelegate: MBFRestClientStatusCodeProtocol?
  public weak var dataConverterDelegate: MBFRestClientDataConverterProtocol?
  
  public private(set) var webServiceURI: NSURL
  
  public init(webServiceURI: NSURL) {
    self.webServiceURI = webServiceURI
  }
  
  public init(webServiceURIString: String) {
    if let url = NSURL.init(string: webServiceURIString) {
      self.webServiceURI = url
    } else {
      self.webServiceURI = NSURL()
    }
  }
  
  public func sendRequestWithFrame(frame: MBFRequestFrame) {
    if self.networkDelegate?.currentStatus == MBFRestClientNetworkType.WiFi ||
      self.networkDelegate?.currentStatus == MBFRestClientNetworkType.WWAN {
      
      let response: MBFRestResponse = {
        (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        
        dispatch_async(dispatch_get_main_queue(), {
          self.activityDelegate?.requestActive(false)
        })
        
        if let purlResponse = response as? NSHTTPURLResponse {
          let responseData =
            self.dataConverterDelegate?.convertData(data,
                                                    requestIdentifier: frame.identifier)
          
          frame.responseDataDelegate?.serverRespondWithStatusCode(purlResponse.statusCode)
          frame.responseDataDelegate?.processData(responseData)
        }
      }
      
      let dataTask =
        NSURLSession.sharedSession().dataTaskWithRequest(frame.request,
                                                         completionHandler: response)
      
      self.activityDelegate?.requestActive(true)
      dataTask.resume()
    }
  }
}
