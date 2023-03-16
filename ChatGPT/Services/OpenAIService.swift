//
//  OpenAIService.swift
//  ChatGPT
//
//  Created by Yurii on 16.03.2023.
//

import Alamofire
import Combine
import Foundation

class OpenAIService {
    let url = "https://api.openai.com/v1/completions"

    func send(msg: String) -> AnyPublisher<Response, Error> {
        let body = Completions(model: "text-davinci-003", prompt: msg, temperature: 0.7, max_tokens: 256)
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(K.key)"
        ]

        return Future { [weak self] promise in
            guard let self else { return }

            AF.request(
                self.url,
                method: .post,
                parameters: body,
                encoder: .json,
                headers: headers
            ).responseDecodable(of: Response.self) { response in
                switch response.result {
                    case .success(let result):
                        promise(.success(result))
                    case .failure(let error):
                        promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}


