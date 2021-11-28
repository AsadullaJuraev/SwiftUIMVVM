//
//  EditView.swift
//  SwiftUIMVVM
//
//  Created by Asadulla Juraev on 18/11/21.
//

import SwiftUI

struct EditView: View {
    @ObservedObject var viewModel = editViewModel()
    @Environment(\.presentationMode) var presentation
    @State var contact = Contact()
    @State var name = ""
    @State var number = ""
    var ContactID: String
    var body: some View {
        ZStack{
            if viewModel.isLoading {
                ProgressView()
            }else{
                GeometryReader{ geo in
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("NAME").font(.headline)
                        
                        TextField("Enter name", text: $name)
                            .padding(.horizontal , 15)
                            .frame(height: 40.0)
                            .background(Color(red: 239/255, green: 243/255, blue: 244/255))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        
                        Text("NUMBER").font(.headline)
                        
                        TextField("Enter number", text: $number)
                            .padding(.horizontal , 15)
                            .frame(height: 40.0)
                            .background(Color(red: 239/255, green: 243/255, blue: 244/255))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        
                        Button(action:{
                            if name != "" && number != ""{
                                viewModel.apiContactEdit(id: Int(ContactID)!, contact: Contact(id: ContactID, name: name, number: number)) { result in
                                    if result {
                                        presentation.wrappedValue.dismiss()
                                    }
                                }
                            }
                        }){
                            Text("EDIT").font(.headline)
                                .foregroundColor(.white)
                        }
                        .frame(height: 45)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding()
                        
                    }.padding(.horizontal , 15)
                        .padding(.top, 20)
                }
            }
        }
        .onAppear(perform: {
            viewModel.apiContactCall(id: Int(ContactID)!) { item in
                self.name = item.name ?? ""
                self.number = item.number ?? ""
            }
        })
        
    }
}
