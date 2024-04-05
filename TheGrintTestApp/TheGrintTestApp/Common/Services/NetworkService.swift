//
//  NetworkService.swift
//  TheGrintTestApp
//
//  Created by Angelber Castro on 4/4/24.
//

import Alamofire

protocol IEndpoint {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameter: Parameters? { get }
    var header: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}

class NetworkService {
    static let share = NetworkService()

    private var dataRequest: DataRequest?
    private let baseUrl =  "https://oauth.reddit.com/r/"

    @discardableResult
    private func _dataRequest(
        url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
    -> DataRequest {
        return Session.default.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
    }

    func request<T: IEndpoint>(endpoint: T, completion: @escaping (Swift.Result<Data?, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let url = self.baseUrl + endpoint.path

            let header : HTTPHeaders = ["Authorization": "bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IlNIQTI1NjpzS3dsMnlsV0VtMjVmcXhwTU40cWY4MXE2OWFFdWFyMnpLMUdhVGxjdWNZIiwidHlwIjoiSldUIn0.eyJzdWIiOiJ1c2VyIiwiZXhwIjoxNzEyMzgwMjU0Ljg1NTI0MiwiaWF0IjoxNzEyMjkzODU0Ljg1NTI0MiwianRpIjoiVWUxWEFYQ1VZeG50V2JodGpNUnBFcTZuOTMzRGlBIiwiY2lkIjoibzdSMmJMVFVtN2hBTzA2SXNBbkNVUSIsImxpZCI6InQyX2k0b204bXJmayIsImFpZCI6InQyX2k0b204bXJmayIsImxjYSI6MTY5MjcxNzM0NDY2NSwic2NwIjoiZUp5S1Z0SlNpZ1VFQUFEX193TnpBU2MiLCJmbG8iOjl9.RgOxUvxPRRiP0ynDFdmi42ra5D73cqRASvaoRMF9tkZidmqM8ewsdv8Amalb7Z1dVXY1q7R67Qt1xtY1p6tRRBfpJzn-6rrGFSCh3doLNDzBopMBEzCV350t1m3Rxsp14bIxyQE7CaVLJ0Np4kaFI-24L7VUuyt6YjN9ixwNVspuZEJamkRtijoR1LJQLneX0QpBjWDOYsIFQ1hm67caVddJitfoV-naJPk3tNQmI4dqwzzpmOlkWlZK-6XYT6_-SA71fnHdf2Hty7F5sePAHwMLJVjO_7RDgiVMpzJEBlXfjB8LO8YnBjjS9_bLfAqfE-dEJX1k9AR1ZmHj13VKVw","User-Agent":"sChangeMeClient/0.1 by YourUsername"]

            self.dataRequest = self._dataRequest(url: url,
                                                 method: endpoint.method,
                                                 parameters: endpoint.parameter,
                                                 encoding: endpoint.encoding,
                                                 headers: header)

            self.dataRequest?.responseJSON(completionHandler: { (response) in

                switch response.result {
                case .success(let value):
                   print(value)

                    completion(.success(response.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        }
    }

    func cancelRequest(_ completion: (()->Void)? = nil) {
        dataRequest?.cancel()
        completion?()
    }

    func cancelAllRequest(_ completion: (()->Void)? = nil) {
        Alamofire.Session.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
}

struct BodyStringEncoding: ParameterEncoding {
    private let body: String

    init(body: String) { self.body = body }

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        guard var urlRequest = urlRequest.urlRequest else { throw Errors.emptyURLRequest }
        guard let data = body.data(using: .utf8) else { throw Errors.encodingProblem }
        urlRequest.httpBody = data
        return urlRequest
    }
}

extension BodyStringEncoding {
    enum Errors: Error {
        case emptyURLRequest
        case encodingProblem
    }
}

extension BodyStringEncoding.Errors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyURLRequest: return "Empty url request"
        case .encodingProblem: return "Encoding problem"
        }
    }
}
