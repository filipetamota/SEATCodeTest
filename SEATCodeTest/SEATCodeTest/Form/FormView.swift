//
//  DetailView.swift
//  SEATCodeTest
//
//  Created by Filipe Mota on 3/7/24.
//

import SwiftUI
import SwiftData

struct FormView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State var badgeManager = AppAlertBadgeManager(application: UIApplication.shared)
    @State private var showError: Bool = false
    @State private var showSuccess: Bool = false
    
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var date: Date = .now
    @State private var issueDescription: String = ""
    @State private var issueDescriptionCharacterLimit: Int = 200
    @State private var issueDescriptionTypedCharacters: Int = 0
    
    var body: some View {
        Form {
            Section(header: Text(NSLocalizedString("person_form_title", comment: ""))) {
                TextField(NSLocalizedString("first_name_form_text", comment: ""), text: $firstname)
                TextField(NSLocalizedString("last_name_form_text", comment: ""), text: $lastname)
            }
            
            Section(header: Text(NSLocalizedString("contact_form_title", comment: ""))) {
                TextField(NSLocalizedString("email_form_text", comment: ""), text: $email)
                    .keyboardType(.emailAddress)
                TextField(NSLocalizedString("phone_form_text", comment: ""), text: $phone)
                    .keyboardType(.phonePad)
            }
            
            Section(header: Text(NSLocalizedString("date_time_form_title", comment: ""))) {
                DatePicker(selection: $date, in: ...Date.now, displayedComponents: .date) {
                    Text(NSLocalizedString("date_form_text", comment: ""))
                }
                DatePicker(selection: $date, in: ...Date.now, displayedComponents: .hourAndMinute) {
                    Text(NSLocalizedString("time_form_text", comment: ""))
                }
            }
            
            Section(header: Text(NSLocalizedString("issue_form_title", comment: "")), footer:
                        Text(String.localizedStringWithFormat(NSLocalizedString("chars_left_form_text", comment: ""), issueDescriptionTypedCharacters, issueDescriptionCharacterLimit)) ) {
                TextEditor(text: $issueDescription)
                    .frame(height: 200)
                    .onChange(of: issueDescription) {
                        issueDescriptionTypedCharacters = issueDescription.count
                        issueDescription = String(issueDescription.prefix(issueDescriptionCharacterLimit))
                    }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(NSLocalizedString("report_issue_form_title", comment: ""))
                    .fontWeight(.bold)
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                Text(NSLocalizedString("save_form_text", comment: ""))
                    .onTapGesture {
                        if
                            !firstname.isEmpty,
                            !lastname.isEmpty,
                            (phone.isEmpty || Utils.isValidPhone(phone: phone)),
                            Utils.isValidEmail(email: email),
                            !issueDescription.isEmpty
                        {
                            let issue = Issue(firstName: firstname, lastName: lastname, email: email, phone: phone, date: date, issueDescription: issueDescription)
                            context.insert(issue)
                            badgeManager.setAlertBadge(number: getIssuesCount())
                            showSuccess.toggle()
                        } else {
                            showError.toggle()
                        }
                    }
            }
        }
        .alert(NSLocalizedString("error", comment: ""), isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(NSLocalizedString("report_error_text", comment: ""))
        }
        .alert(NSLocalizedString("issue_form_title", comment: ""), isPresented: $showSuccess) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        } message: {
            Text(NSLocalizedString("report_success_text", comment: ""))
        }
    }
    
    private func getIssuesCount() -> Int {
        do {
            return try context.fetchCount(FetchDescriptor<Issue>())
        } catch {
            return 0
        }
    }
}

#Preview {
    FormView()
}
