//
//  JSONDecoderExtesion.swift
//
//  Created by xfl on 2018/2/2.
//

import Foundation

extension KeyedDecodingContainer {
    
    public func decodeIfPresent(_ type: String.Type, forKey key: K) throws -> String? {
        
        if let value = try? decode(type, forKey: key) {
            return value
        }
        if let value = try? decode(Int.self, forKey: key) {
            return String(value)
        }
        if let value = try? decode(Float.self, forKey: key) {
            return String(value)
        }
        if let value = try? decode(Bool.self, forKey: key) {
            return String(value)
        }
        if let value = try? decode(Double.self, forKey: key) {
            return String(value)
        }
        
        return nil
    }
    
    public func decodeIfPresent(_ type: Int.Type, forKey key: K) throws -> Int? {
        
        if let value = try? decode(type, forKey: key) {
            return value
        }
        if let value = try? decode(String.self, forKey: key) {
            return Int(value)
        }
        if let value = try? decode(Float.self, forKey: key) {
            return Int(value)
        }
        if let value = try? decode(Bool.self, forKey: key) {
            return (value ? 1:0)
        }
        if let value = try? decode(Double.self, forKey: key) {
            return Int(value)
        }
        return nil
    }
    
    public func decodeIfPresent(_ type: Float.Type, forKey key: K) throws -> Float? {
        
        if let value = try? decode(type, forKey: key) {
            return value
        }
        if let value = try? decode(String.self, forKey: key) {
            return Float(value)
        }
        if let value = try? decode(Double.self, forKey: key) {
            return Float(value)
        }
        if let value = try? decode(Int.self, forKey: key) {
            return Float(value)
        }
        return nil
    }
    
    public func decodeIfPresent(_ type: Bool.Type, forKey key: K) throws -> Bool? {
        
        if let value = try? decode(type, forKey: key) {
            return value
        }
        if let value = try? decode(String.self, forKey: key) {
            if let valueInt = Int(value) {
                return Bool(valueInt != 0)
            }
            return nil
        }
        if let value = try? decode(Int.self, forKey: key) {
            return Bool(value != 0)
        }
        return nil
    }
    
    public func decodeIfPresent(_ type: Double.Type, forKey key: K) throws -> Double? {
        
        if let value = try? decode(type, forKey: key) {
            return value
        }
        if let value = try? decode(String.self, forKey: key) {
            return Double(value)
        }
        if let value = try? decode(Int.self, forKey: key) {
            return Double(value)
        }
        if let value = try? decode(Float.self, forKey: key) {
            return Double(value)
        }
        return nil
    }
    
    public func decodeIfPresent<T>(_ type: T.Type, forKey key: K) throws -> T? where T : Decodable {
        return try? decode(type, forKey: key)
    }
    
    //--------------------------------------------------------------------//
    
    
}
