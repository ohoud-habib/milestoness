////
////  SignUpScreen.swift
////  milestones
////
////  Created by Maryam Bahwal on 15/05/1447 AH.
////
import SwiftUI
//
//struct SignUpScreen: View {
//    @EnvironmentObject var vm: ProfileViewModel
//    @State private var goToMain = false
//    
//    let roles = ["UX/UI Design", "Marketing", "Back-End", "Business"]
//    
//    var body: some View {
//        ZStack {
//            Image("SignUpBG")
//                .resizable()
//                .ignoresSafeArea()
//            
//            VStack(alignment: .leading, spacing: 15) {
//                Spacer().frame(height: 60)
//                
//                Group {
//                    Text("First Name")
//                        .foregroundColor(.white)
//                        .font(.headline)
//                    
//                    TextField("Ghada", text: $vm.firstName)
//                        .textFieldStyle(PlainTextFieldStyle())
//                        .padding()
//                        .background(Color.white.opacity(0.1))
//                        .cornerRadius(15)
//                        .foregroundColor(.white)
//                    
//                    Text("Last Name")
//                        .foregroundColor(.white)
//                        .font(.headline)
//                    
//                    TextField("Alsubaie", text: $vm.lastName)
//                        .textFieldStyle(PlainTextFieldStyle())
//                        .padding()
//                        .background(Color.white.opacity(0.1))
//                        .cornerRadius(15)
//                        .foregroundColor(.white)
//                }
//                
//                Text("Role")
//                    .foregroundColor(.white)
//                    .font(.headline)
//                
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 12) {
//                        ForEach(roles, id: \.self) { role in
//                            Button {
//                                if vm.selectedRoles.contains(role) {
//                                    vm.selectedRoles.removeAll { $0 == role }
//                                } else {
//                                    vm.selectedRoles.append(role)
//                                }
//                            } label: {
//                                Text(role)
//                                    .font(.subheadline)
//                                    .fontWeight(.semibold)
//                                    .padding(.horizontal, 16)
//                                    .padding(.vertical, 10)
//                                    .background(roleColor(role))
//                                    .cornerRadius(20)
//                                    .foregroundColor(.white)
//                                    .opacity(vm.selectedRoles.contains(role) ? 1.0 : 0.4)
//                                    .animation(.easeInOut(duration: 0.2), value: vm.selectedRoles)
//                            }
//                        }
//                    }
//                    .padding(.vertical, 5)
//                }
//                
//                Spacer()
//                
//                ReusableCapsuleButton(
//                    buttonText: "Sign Up",
//                    action: {
//                        vm.completeSignUp() 
//                        goToMain = true
//                    },
//                    textColor: .black,
//                    buttonColor: .white
//                )
//                .padding(.bottom, 40)
//            }
//            .padding(.horizontal, 25)
//        }
//        .fullScreenCover(isPresented: $goToMain) {
//            MainTabView()
//        }
//    }
//    
//    // 🎨 Custom colors
//    func roleColor(_ role: String) -> Color {
//        switch role {
//        case "UX/UI Design": return .purple
//        case "Marketing": return .teal
//        case "Back-End": return .indigo
//        case "Business": return .black
//        default: return .gray
//        }
//    }
//}
//
struct SignUpScreen: View {
    @EnvironmentObject var viewModel: ProjectViewModel
    @EnvironmentObject var vm: ProfileViewModel
    @State private var goToMain = false
    
    let roles = ["UX/UI Design", "Marketing", "Back-End", "Business"]
    
    private var isFormValid: Bool {
        !vm.firstName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !vm.lastName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !vm.selectedRoles.isEmpty
    }
    
    var body: some View {
        ZStack {
            Image("SignUpBG")
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 15) {
                Spacer().frame(height: 60)
                
                Group {
                    Text("First Name")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    TextField("Ghada", text: $vm.firstName)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        .foregroundColor(.white)
                    
                    Text("Last Name")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    TextField("Alsubaie", text: $vm.lastName)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        .foregroundColor(.white)
                }
                
                Text("Role")
                    .foregroundColor(.white)
                    .font(.headline)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(roles, id: \.self) { role in
                            Button {
                                if vm.selectedRoles.contains(role) {
                                    vm.selectedRoles.removeAll { $0 == role }
                                } else {
                                    vm.selectedRoles.append(role)
                                }
                            } label: {
                                Text(role)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(roleColor(role))
                                    .cornerRadius(20)
                                    .foregroundColor(.white)
                                    .opacity(vm.selectedRoles.contains(role) ? 1.0 : 0.4)
                                    .animation(.easeInOut(duration: 0.2), value: vm.selectedRoles)
                            }
                        }
                    }
                    .padding(.vertical, 5)
                }
                
                if !isFormValid {
                    Text("Please fill all fields and select at least one role")
                        .foregroundColor(.orange)
                        .font(.caption)
                }
                
                Spacer()
                
                ReusableCapsuleButton(
                    buttonText: "Sign Up",
                    action: {
                        if isFormValid {
                            vm.completeSignUp()
                            goToMain = true
                        }
                    },
                    textColor: .black,
                    buttonColor: isFormValid ? .white : .gray
                )
                .disabled(!isFormValid)
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 25)
        }
        .fullScreenCover(isPresented: $goToMain) {
            MainTabView()
        }
    }
    
    func roleColor(_ role: String) -> Color {
        switch role {
        case "UX/UI Design": return .purple
        case "Marketing": return .teal
        case "Back-End": return .indigo
        case "Business": return .black
        default: return .gray
        }
    }
}
#Preview {
    SignUpScreen()
        .environmentObject(ProfileViewModel())
}
