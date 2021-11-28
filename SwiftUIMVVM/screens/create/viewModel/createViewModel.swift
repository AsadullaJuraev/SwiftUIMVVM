//
//  createViewModel.swift
//  SwiftUIMVVM
//
//  Created by Asadulla Juraev on 27/11/21.
//

import Foundation

class createViewModel: ObservableObject{
    @Published var isLoading = false
    
    func apiContactCreate(contact: Contact, handler: @escaping (Bool) -> Void){
        self.isLoading = true
        AFHttp.post(url: AFHttp.API_CONTACT_CREATE, params: AFHttp.paramsContactCreate(contact: contact)) { response in
            self.isLoading = false
            switch response.result {
            case .success:
                print(response.result)
                handler(true)
            case let .failure(error):
                print(error)
                handler(false)
            }
        }
    }
}
