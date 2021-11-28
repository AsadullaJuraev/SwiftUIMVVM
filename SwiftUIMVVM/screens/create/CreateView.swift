//
//  CreateView.swift
//  SwiftUIMVVM
//
//  Created by Asadulla Juraev on 18/11/21.
//

import SwiftUI

struct CreateView: View {
    @ObservedObject var viewModel = createViewModel()
    @Environment(\.presentationMode) var presentation
    @State var contact = Contact()
    @State private var name = ""
    @State private var number = ""
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
                    }.padding(.horizontal , 15)
                        .padding(.top, 20)
                }
            }
        }
        .navigationBarItems(trailing:
                                Button(action:{
            if name != "" && number != ""{
                viewModel.apiContactCreate(contact: Contact(name: name, number: number)) { result in
                    if result {
                        presentation.wrappedValue.dismiss()
                    }
                }
            }
        }){
            Image("ic_add")
                .foregroundColor(.white)
        }
        )
    }
}
