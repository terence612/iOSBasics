//
//  APIService.swift
//  LearningDemo
//
//  Created by Terlun Leung on 31/10/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case noData = "ERROR: no data"
    case noStatusCode = "Error: no status code"
    case conversionFailed = "ERROR: conversion from JSON failed"
}

enum APIAction: String {
    case GET
    case POST
    case PUT
    case DELETE
}

class APIService {
    static let shared = APIService()

    private let defaultConfig: URLSessionConfiguration = {
        let tmpConfig = URLSessionConfiguration.default
        tmpConfig.timeoutIntervalForRequest = 30
        return tmpConfig
    }()

    private let apiUrlSession: URLSession

    private typealias APINetworkManagerUrlResponseHandler = (_ dict: [String: Any]?, _ array: [Any]?, _ httpStatusCode: Int?, _ error: Error?) -> Void
    typealias DictCompletionBlock = (_ dict: [String: Any]?) -> Void
    typealias ArrayCompletionBlock = (_ array: [Any]?) -> Void

    private init() {
        self.apiUrlSession = URLSession(configuration: defaultConfig)
    }

    private func performRequest(urlStr: String,
                                action: APIAction,
                                completionBlock: @escaping APINetworkManagerUrlResponseHandler) {

        guard let urlComponent = URLComponents(string: urlStr) else {
            NSLog("Invalid urlComponent")
            return
        }

        guard let urlComponentStr = urlComponent.string,
            let url = URL.init(string: urlComponentStr) else {
                NSLog("Invalid URL")
                return
        }

        // Setup URLRequest
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData,
                                    timeoutInterval: 30)

        urlRequest.httpMethod =  action.rawValue

        //Perform request
        apiUrlSession.dataTask(with: urlRequest) { (data, response, error) in

            var responseDic: [String: Any]?
            var responseArray: [Any]?
            var egError: Error?
            var responseCode: Int = -1

            do {
                //Get status code
                if let httpResponse = response as? HTTPURLResponse {
                    responseCode = httpResponse.statusCode
                } else {
                    throw APIError.noStatusCode
                }

                guard let data = data else {
                    throw APIError.noData
                }

                let serializedObject = try JSONSerialization.jsonObject(with: data, options: [])
                if let dict = serializedObject as? [String: Any] {
                    //Set as dict
                    responseDic = dict
                } else if let array = serializedObject as? [Any] {
                    //Set as array
                    responseArray = array
                } else {
                    throw APIError.conversionFailed
                }
            } catch let error as APIError {
                egError = error
            } catch let error {
                egError = error
            }

            completionBlock(responseDic, responseArray, responseCode, egError)
            }.resume()
    }

    func getDataArray(urlStr: String, result: ArrayCompletionBlock? = nil) {
        performRequest(urlStr: urlStr,
                       action: APIAction.GET) { (respDic, respArray, statusCode, apiError) in
                        DispatchQueue.main.async {
                            result?(respArray)
                        }

        }
    }

    func getDataDict(urlStr: String, result: DictCompletionBlock? = nil) {
        performRequest(urlStr: urlStr,
                       action: APIAction.GET) { (respDic, respArray, statusCode, apiError) in
                        DispatchQueue.main.async {
                            result?(respDic)
                        }
        }
    }
}
