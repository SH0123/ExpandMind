//
//  WriteView.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/04/28.
//

import SwiftUI

struct WriteView: View {
    @Environment(\.dismiss) private var dismiss
    //@EnvironmentObject var store: Store
    @AppStorage("count") var count = UserDefaults.standard.integer(forKey: "count")
    @State var opinion: String = ""
    @Binding var writeStart: Bool
    var body: some View {
        ZStack{
            Color.bgColor
                .ignoresSafeArea()
            VStack{
                Text(self.dateFormatter())
                Text("분야")
                ScrollView{
                TextEditor(text:self.$opinion)
                        .disableAutocorrection(true)
                        .foregroundColor(.customBlack)
                        .lineSpacing(5)
                        .frame(height: 500)
                        .border(Color.white)
                        .cornerRadius(10)
                }
                .padding(.top, 30)
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
                }.disabled(opinion == "")
                
            }
        }
                .tint(.customBlack)

    }
    
    private func dateFormatter() -> String{
        let curDate = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: curDate)
    }
}

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView(writeStart: .constant(false))
    }
}
