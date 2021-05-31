//
//  APIHandler.swift
//  SwiftAssignment
//
//  Created by Syed Tariq Ali on 31/05/21.
//

import Foundation
// Define a protocol containing the signature of a function to fetch data
protocol APIServiceProtocol: AnyObject {
    func getRows( complete: @escaping ( _ success: Bool, _ rows: [Row], _ title: String, _ error: APIError? )->() )
}

/// Result enum is a generic for any type of value
/// with success and failure case
public enum Result<T> {
    case success(T)
    case failure(Error)
}

// Doing this we can easily assign this protocol in the rowsList
class APIHandler: APIServiceProtocol {
    func getRows(complete: @escaping (Bool, [Row], String, APIError?) -> ()) {
        // Use a dispatch queue that schedules tasks for concurrent execution.
        DispatchQueue.global().async {
            
            if let unwrappedUrl = URL(string: EndPoint.strUrl){
                
                URLSession.shared.dataTask(with: unwrappedUrl) { (data, response, error) in
                    guard let data = data else { return }
                    guard let string = String(data: data, encoding: String.Encoding.isoLatin1) else { return }
                    guard let properData = string.data(using: .utf8, allowLossyConversion: true) else { return }
                    do{
                        let facts = try JSONDecoder().decode(DataModel.self, from: properData)
                        complete( true, facts.rows, facts.title, nil )
                        
                    } catch let error {
                        complete( false, [], "", error as? APIError )
                        print(error)
                    }
                }.resume()
            }
        }
    }
    
    //    // MARK: - Private functions
    public static func getData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // MARK: - Public function
    
    /// downloadImage function will download the thumbnail images
    /// returns Result<Data> as completion handler
    public static func downloadImage(url: URL, completion: @escaping (Result<Data>) -> Void) {
        getData(url: url) { data, response, error in
            
            if let error = error {
                
                DispatchQueue.main.async() {
                    completion(.failure(error))
                }
                return
            }
            guard let data = data, error == nil else {
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("statusCode != 200; \(httpResponse.statusCode)")
                return
            }
            DispatchQueue.main.async() {
                completion(.success(data))
            }
        }
    }
}
