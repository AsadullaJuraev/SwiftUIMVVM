//
//  ContactCell.swift
//  SwiftUIMVVM
//
//  Created by Asadulla Juraev on 18/11/21.
//

import SwiftUI

struct ContactCell: View {
    var contact: Contact
    
    var body: some View {
        VStack(alignment: .leading){
            Text(contact.name!.uppercased())
                .fontWeight(.bold)
            Text(contact.number!)
                .padding(.top, 5)
        }.padding()
    }
}

struct ContactCell_Previews: PreviewProvider {
    static var previews: some View {
        ContactCell(contact: Contact())
    }
}
