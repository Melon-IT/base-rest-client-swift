//
//  MBFRestDataConverter.swift
//  MelonRestClient
//
//  Created by Tomasz Popis on 10/06/16.
//  Copyright © 2016 Melon-IT. All rights reserved.
//

import Foundation

public class MBFJSONConverter: MBFRestClientDataConverterProtocol {
  
  public init() {

  }
  
  public func convertData(data: NSData?, requestIdentifier: UInt?) -> AnyObject? {
    var jsonObject: AnyObject?
    
    if let jsonData = data {
      jsonObject = try? NSJSONSerialization.JSONObjectWithData(jsonData,
                                                               options:[NSJSONReadingOptions.AllowFragments,
                                                                NSJSONReadingOptions.MutableContainers])
    }
    
    return jsonObject
  }
}