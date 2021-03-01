//
//  APIService.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import Foundation

typealias Payload = [String: Any]
typealias List = [Payload]

// MARK: - API Error

enum APIServiceError: Error {
  case noData
  case invalidData(description: String)
    
  var localizedDescription: String {
    switch self {
    case .noData: return "No data"
    case .invalidData(let description): return "Invalid data: \(description)"
    }
  }
}

// MARK: - API Request

protocol APIRequestProtocol {
  func cancel()
}

class APIRequest: APIRequestProtocol {
  let dataTask: URLSessionDataTask

  init(dataTask: URLSessionDataTask) {
    self.dataTask = dataTask
  }

  func cancel() {
    dataTask.cancel()
  }
}

// MARK: - API Response

protocol APIResponseBase {
  init(urlRequest: URLRequest, dataResponse: Data) throws
}

// MARK: - API Endpoint

enum APIHTTPMethod: String {
  case GET = "GET"
  case POST = "POST"
  case DELETE = "DELETE"
  case PUT = "PUT"
  case PATCH = "PATCH"
}

protocol APIEndpoint {
  associatedtype ResultType: APIResponseBase

  func createURLRequest(baseURL: URL) -> URLRequest

  var path: String {get}
  var method: APIHTTPMethod {get}
  var queryParameters: [String: Any]? {get}
  var bodyData: Data? {get}
}

extension APIEndpoint {
  var method: APIHTTPMethod { return .GET }
  var queryParameters: [String: Any]? { return nil }
  var bodyData: Data? { return nil }
    
  func createURLRequest(baseURL: URL) -> URLRequest {
    var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!

    if !path.isEmpty {
      urlComponents.path.append(path)
    }

    urlComponents.queryItems = queryParameters.map { queryParameters in
      return queryParameters.map { (key, value) in
        return URLQueryItem(name: key, value: "\(value)")
      }
    }

    var request: URLRequest = urlComponents.url.map { URLRequest(url: $0) }!
    request.httpMethod = method.rawValue
    request.httpBody = bodyData

    return request
  }

}

// MARK: - API Service

protocol APIServiceProtocol {
  @discardableResult func load<E: APIEndpoint>(
    endpoint: E,
    completion: @escaping (Result<E.ResultType, Error>)->()
  ) -> APIRequestProtocol
}

class APIService: APIServiceProtocol {
  let baseURL: URL

  init(baseURL: URL) {
    self.baseURL = baseURL
  }
    
  @discardableResult
  func load<E: APIEndpoint>(
    endpoint: E,
    completion: @escaping (Result<E.ResultType, Error>)->()
  ) -> APIRequestProtocol {
        
    let urlRequest = endpoint.createURLRequest(baseURL: baseURL)

    let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, URLResponse, requestError in
      let result: Result<E.ResultType, Error>
            
      if let requestError = requestError {
        result = .failure(requestError)
      } else {
        if let data = data {
          do {
            let response = try E.ResultType.init(
              urlRequest: urlRequest,
              dataResponse: data
            )
            result = .success(response)
          } catch {
            result = .failure(error)
          }
        } else {
          result = .failure(APIServiceError.noData)
        }
      }

      DispatchQueue.main.async {
        completion(result)
      }
    }

    dataTask.resume()

    return APIRequest(dataTask: dataTask)
  }
    
}
