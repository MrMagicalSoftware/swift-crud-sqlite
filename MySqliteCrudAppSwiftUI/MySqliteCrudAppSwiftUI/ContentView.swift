//
//  ContentView.swift
//  MySqliteCrudAppSwiftUI
//
//  Created by user on 27/06/22.
//

import SwiftUI



struct ContentView: View {
    
    
    

    // check if user is selected for edit
    @State var userSelected: Bool = false
     
    // id of selected user to edit or delete
    @State var selectedUserId: Int64 = 0
    
    
    // array of user models
    @State var userModels: [UserModel] = []
    
    var body: some View {
    
        Rectangle()
                  .fill(Color.blue)
                  .frame(width:.infinity, height: 100)
                  .overlay(
                    Text("DATA Manager").foregroundColor(Color.white)
                  )
    
        ZStack {
            
            LinearGradient(gradient: Gradient(colors :[Color.red , Color.white , Color.blue]), startPoint: .leading, endPoint: .trailing)
            
        }
        
        // create list view to show all users
        List (self.userModels) { (model) in
         
            
            
            ZStack {
                Color(.red).edgesIgnoringSafeArea(.all)
            }
            
            
            // show name, email and age horizontally
            HStack {
                
                
                Text(model.name)
                Spacer()
                Text(model.email)
                Spacer()
                Text("\(model.age)")
                Spacer()
         
                // edit and delete button goes here
                
                // button to edit user
                Button(action: {
                    self.selectedUserId = model.id
                    self.userSelected = true
                    
                    print("EDITING BOX")
                    
                    
                    
                }, label: {
                    Text("Edit")
                        .foregroundColor(Color.blue)
                    })
                    // by default, buttons are full width.
                    // to prevent this, use the following
                    .buttonStyle(PlainButtonStyle())
                
                // button to delete user
                Button(action: {
                    
                    // create db manager instance
                    let dbManager: DB_Manager = DB_Manager()
                    
                    // call delete function
                    dbManager.deleteUser(idValue: model.id)
                    
                    // refresh the user models array
                    self.userModels = dbManager.getUsers()
                }, label: {
                    Text("Delete")
                        .foregroundColor(Color.red)
                })// by default, buttons are full width.
                // to prevent this, use the following
                .buttonStyle(PlainButtonStyle())
                
                
            }
            
        }
      
      
       
        
        // create navigation view
        NavigationView {
         
            VStack {
         
                // create link to add user
                HStack {
                    Spacer()
                    NavigationLink (destination: AddUserView(), label: {
                        Text("Add user")
                    })
                    
                    // navigation link to go to edit user view
                    NavigationLink (destination: EditUserView(id: self.$selectedUserId), isActive: self.$userSelected) {
                        EmptyView()
                    }
                    
                }
         
                // list view goes here
         
            }.padding()
            .navigationBarTitle("SQLite")
            // load data in user models array
            .onAppear(perform: {
                self.userModels = DB_Manager().getUsers()
            })
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
