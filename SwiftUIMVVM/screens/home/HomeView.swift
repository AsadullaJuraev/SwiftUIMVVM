//
//  HomeView.swift
//  SwiftUIMVVM
//
//  Created by Asadulla Juraev on 18/11/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = homeViewModel()
    @State private var showEdit = false
    
    func delete(indexSet: IndexSet) {
        let contact = viewModel.contacts[indexSet.first!]
        viewModel.apiContactDelete(contact: contact, handler: { status in
            if status{
                viewModel.apiContactList()
            }else{
                //error message
            }
        })
    }
    
    
    var body: some View {
        NavigationView {
            ZStack{
                List{
                    ForEach(0..<viewModel.contacts.count, id:\.self) { index in
                        Button {
                            showEdit.toggle()
                        } label: {
                            ContactCell(contact: viewModel.contacts[index])
                            
                        }
                        .sheet(isPresented: $showEdit){
                            EditView(ContactID: viewModel.contacts[index].id!)
                                .onDisappear{
                                    viewModel.apiContactList()
                                }
                        }
                        
                        
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(PlainListStyle())
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationBarItems(leading:
                                    Button(action: {
                viewModel.apiContactList()
            }){
                Image("ic_refresh")
                    .foregroundColor(.white)
            }
                                , trailing:
                                    NavigationLink(destination: {
                CreateView()
                    .onDisappear{
                        viewModel.apiContactList()
                    }
            }, label: {
                Image("ic_add")
                    .foregroundColor(.white)
            })
            )
            .navigationBarTitle("SwiftUI MVVM", displayMode: .inline)
            .background(UINavigationConfiguration { nc in
                
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = .gray
                appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                
                // Customizing our navigation bar
                nc.navigationBar.tintColor = .white
                nc.navigationBar.standardAppearance = appearance
                nc.navigationBar.scrollEdgeAppearance = appearance
                nc.navigationBar.shadowImage = UIImage()
            })
        }
        .onAppear{
            viewModel.apiContactList()
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
