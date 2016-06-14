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
    var result = Dictionary<String, AnyObject>()
    result["requestIdentifier"] = requestIdentifier
    
    if let jsonData = data {
      let jsonObject = try? NSJSONSerialization.JSONObjectWithData(jsonData,
                                                               options:[NSJSONReadingOptions.AllowFragments,
                                                                NSJSONReadingOptions.MutableContainers])
      result["response"] = jsonObject
    }
    
    return result
  }
}