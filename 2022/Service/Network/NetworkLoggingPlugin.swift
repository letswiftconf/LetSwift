//
//  NetworkLoggingPlugin.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/12.
//

import Moya

// 네트워크 호출 결과 로그 표시
typealias APILoggerConfiguration = NetworkLoggerPlugin.Configuration

final class RequestLoggingPlugin: PluginType {
    public var configuration: APILoggerConfiguration

    public init(configuration: APILoggerConfiguration = APILoggerConfiguration()) {
        self.configuration = configuration
    }
    
    public func willSend(_ request: RequestType, target: TargetType) {
        logNetworkRequest(request, target: target) { [weak self] output in
            self?.configuration.output(target, output)
        }
    }

    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            configuration.output(target, logNetworkResponse(response, target: target, isFromError: false))
        case let .failure(error):
            configuration.output(target, logNetworkError(error, target: target))
        }
    }
}

extension RequestLoggingPlugin {
    private func logNetworkRequest(_ request: RequestType, target: TargetType, completion: @escaping ([String]) -> Void) {
        //cURL formatting
        if configuration.logOptions.contains(.formatRequestAscURL) {
            _ = request.cURLDescription { [weak self] output in
                guard let self = self else { return }

                completion([self.configuration.formatter.entry("Request", output, target)])
            }
            return
        }

        //Request presence check
        guard let httpRequest = request.request else {
            completion([configuration.formatter.entry("Request", "(invalid request)", target)])
            return
        }

        // Adding log entries for each given log option
        var output = [String]()

        output.append(configuration.formatter.entry("Request", httpRequest.description, target))

        if configuration.logOptions.contains(.requestHeaders) {
            var allHeaders = request.sessionHeaders
            if let httpRequestHeaders = httpRequest.allHTTPHeaderFields {
                allHeaders.merge(httpRequestHeaders) { $1 }
            }
            output.append(configuration.formatter.entry("Request Headers", allHeaders.description, target))
        }

        if configuration.logOptions.contains(.requestBody) {
            if let bodyStream = httpRequest.httpBodyStream {
                output.append(configuration.formatter.entry("Request Body Stream", bodyStream.description, target))
            }

            if let body = httpRequest.httpBody {
                let stringOutput = configuration.formatter.requestData(body)
                output.append(configuration.formatter.entry("Request Body", stringOutput, target))
            }
        }

        if configuration.logOptions.contains(.requestMethod),
            let httpMethod = httpRequest.httpMethod {
            output.append(configuration.formatter.entry("HTTP Request Method", httpMethod, target))
        }

        completion(output)
    }

    private func logNetworkResponse(_ response: Response, target: TargetType, isFromError: Bool) -> [String] {
        // Adding log entries for each given log option
        var output = [String]()

        //Response presence check
        if let httpResponse = response.response {
            output.append(configuration.formatter.entry("Response", httpResponse.description, target))
        } else {
            output.append(configuration.formatter.entry("Response", "Received empty network response for \(target).", target))
        }

        if (isFromError && configuration.logOptions.contains(.errorResponseBody))
            || configuration.logOptions.contains(.successResponseBody) {

            let stringOutput = configuration.formatter.responseData(response.data)
            output.append(configuration.formatter.entry("Response Body", stringOutput, target))
        }

        return output
    }

    private func logNetworkError(_ error: MoyaError, target: TargetType) -> [String] {
        
        if let moyaResponse = error.response {
            return logNetworkResponse(moyaResponse, target: target, isFromError: true)
        }
        
        //Errors without an HTTPURLResponse are those due to connectivity, time-out and such.
        return [configuration.formatter.entry("Error", "Error calling \(target) : \(error)", target)]
    }
}


