//
//  RectangleComp.swift
//  Passwords
//
//  Created by Saglara Sandzhieva on 10/12/24.
//

import SwiftUI

struct RectangleComp: View {
    
    @State private var title = ""
    
    var body: some View {
        
       
            HStack {
                VStack{
                    Text (title)
                    
                    ZStack{//inside the blue circle with white keн
                        
                        Image (systemName: "circle.fill")
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 30, height: 30)
                        
                        Image (systemName: "key.fill")
                            .foregroundColor(.white)
                            .frame (width: 30, height: 30)
                        
                    }
                }
                .padding()
                Spacer()
                
                Text("78")
                    .padding()
            }
            .frame(width: 200, height: 85)
            
            .background(.yellow)
            .cornerRadius(15)
           
          
        }
    }
#Preview {
    RectangleComp()
}
