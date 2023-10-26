//
//  StringExtension.swift
//  iOS App
//
//  Created by TC Lee on 2023/9/14.
//

import Foundation

extension String{
    
  
    func removeSpace()->String{
        // Replace consecutive spaces with a single space
        var processedString = self.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
        
        // Trim leading and trailing spaces
        processedString = processedString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return processedString
    }
    
    func limitStringLength(max length:Int)->String{
        var processedString = self
        if processedString.count > length {
            let endIndex = processedString.index(processedString.startIndex, offsetBy: length)
            processedString = String(processedString[..<endIndex])
        }
        
        return processedString
    }
    
    
    
}
