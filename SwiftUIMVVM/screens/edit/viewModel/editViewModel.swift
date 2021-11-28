//
//  editViewModel.swift
//  SwiftUIMVVM
//
//  Created by Asadulla Juraev on 27/11/21.
//

import Foundation

class editViewModel: ObservableObject{
    @Published var isLoading = false
    
    
    func apiContactCall(id: Int, completion: @escaping (Contact) -> Void) {
        AFHttp.get(url: AFHttp.API_CONTACT_SINGLE + String(id), params: AFHttp.paramsContactWith(id: id), handler: { response in
            switch response.result {
            case .success:
                let decode = try! JSONDecoder().decode(Contact.self, from: response.data!)
                completion(decode)
            case let .failure(error):
                print(error)
                completion(Contact())
            }
        })
    }
    
    func apiContactEdit(id: Int, contact: Contact, completion: @escaping (Bool) -> Void) {
        AFHttp.put(url: AFHttp.API_CONTACT_UPDATE + String(id), params: AFHttp.paramsContactUpdate(contact: contact)) { response in
            switch response.result {
            case .success:
                print("SUCCESS")
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        }
    }
}
