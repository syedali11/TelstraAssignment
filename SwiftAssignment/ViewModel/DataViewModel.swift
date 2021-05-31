//
//  DataViewModel.swift
//  SwiftAssignment
//
//  Created by Syed Tariq Ali on 31/05/21.
//

import Foundation
class DataViewModel{
    // MARK: - Closures
    
    // Through these closures, our view model will execute code while some events will occure
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatusClosure: (()->())?
    
    // MARK: - Properties
    
    // We defined the APIServiceProtocol in the APIService.swift file.
    // We also defined a class and make it conform to that protocol.
    let apiService: APIServiceProtocol
    
    var title: String?
    
    // The collection that will contain our fetched data
    private var rows: [Row] = [Row]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    // A property containing the number ot items, it will be used by the view controller to render items on the screen
    var numberOfItems: Int {
        return rows.count
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusClosure?()
        }
    }
    
    // MARK: - Constructor
    
    // Note: apiService has a default value in case this constructor is executed without passing parameters
    init( apiService: APIServiceProtocol = APIHandler()) {
        self.apiService = apiService
    }
    
    
    // MARK: - Fetching functions
    
    func fetchData() {
        self.isLoading = true
        apiService.getRows(complete: ) { [weak self] (success, rows, title, error) in
            if let error = error {
                print ("Error: \(error.rawValue)")
            } else {
                self?.rows = rows
                self?.title = title
            }
            self?.isLoading = false
        }
    }
    
    
    // MARK: - Retieve Data
    
    func getData( at indexPath: IndexPath ) -> Row {
        return rows[indexPath.row]
    }
}
