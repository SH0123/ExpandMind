//
//  WriteView.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/04/28.
//

import SwiftUI

struct WriteView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("count") var count = UserDefaults.standard.integer(forKey: "count")
    @State var thoughts: String = ""
    @Binding var writeStart: Bool
    var summary: String
    var id: String
    var title: String
    var categoryId: String
    var body: some View {
        ZStack{
            Color.bgColor
                .ignoresSafeArea()
            VStack(alignment: .leading){
                HStack{
                    Text("내 생각 정리")
                        .font(.system(size:17, weight:.semibold))
                    
                    Spacer()
                }.padding(.bottom, 20)
                TextEditor(text:self.$thoughts)
                    .disableAutocorrection(true)
                    .foregroundColor(.customBlack)
                    .lineSpacing(5)
                    .frame(height: 500)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.customBlack.opacity(0.3), lineWidth: 1))
                Spacer()
            }
            .foregroundColor(.customBlack)
            .padding(.horizontal, 20)
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement:.navigationBarLeading){
                Button("이전"){
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action:{
                    self.writeStart = false
                    count = count + 1
                }){
                    Text("완료")
                }.disabled(thoughts == "")
                
            }
        }
        .tint(.customBlack)
        
        
    }
    
    func dateFormatter() -> String{
        let curDate = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: curDate)
    }
}

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView(writeStart: .constant(false), summary: "hey", id:"11111", title:"hewllo", categoryId: "27")
    }
}
