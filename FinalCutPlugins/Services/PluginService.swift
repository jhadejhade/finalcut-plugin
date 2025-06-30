//
//  PluginService.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import Foundation

protocol ContentLoadable {
    func fetchData<T: Decodable>(page: Int) async throws -> T
    func sync<T: Decodable>() async throws -> T
}

class PluginService: ContentLoadable {
    
    struct Constants {
        /// 0 seconds delay
        static let delayInNanoseconds = UInt64(2 * 1_000_000_000)
    }
    
    static let shared = PluginService()
    
    func sync<T: Decodable>() async throws -> T {
        try await Task.sleep(nanoseconds: Constants.delayInNanoseconds)
        
        let fileName = String(format: "plugins-sync")
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            throw LoadableDataError.fileNotFound(fileName: fileName)
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            
            return decodedData
        } catch {
            throw LoadableDataError.decodingFailed(error: error)
        }
    }
    
    func fetchData<T: Decodable>(page: Int) async throws -> T {
        
        try await Task.sleep(nanoseconds: Constants.delayInNanoseconds)
        
        let fileName = String(format: "plugins-page-%d", page)
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            throw LoadableDataError.fileNotFound(fileName: fileName)
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            
            return decodedData
        } catch {
            throw LoadableDataError.decodingFailed(error: error)
        }
    }
}
