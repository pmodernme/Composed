//
//  LegacyTextField.swift
//  
//
//  Created by Zoe Van Brunt on 12/21/22.
//

import SwiftUI

@available(iOS 14.0, *)
public struct LegacyTextField: UIViewRepresentable {
    
    public init(text: Binding<String>, isEditing: Binding<Bool>, placeholder: String? = nil, font: UIFont? = nil, color: UIColor? = nil, onTextChanged: @escaping (_ newValue: String) -> Void = { _ in }) {
        _text = text
        _isEditing = isEditing
        self.placeholder = placeholder
        self.font = font
        self.color = color
        self.onTextChanged = onTextChanged
    }
    
    
    @Binding public var text: String
    @Binding public var isEditing: Bool
    public var placeholder: String?
    public var font: UIFont?
    public var color: UIColor?
    
    public var onTextChanged: (_ newValue: String) -> Void
    
    public func updateUIView(_ field: UITextField, context: Context) {
        if field.text != text {
            field.text = text
        }
        field.font = font
        field.placeholder = placeholder
        if let color = color {
            field.textColor = color
            field.tintColor = color
        }
        if isEditing && !field.isFirstResponder {
            field.becomeFirstResponder()
        }
    }
    
    public func makeUIView(context: Context) -> UITextField {
        let view = UITextField()
        view.delegate = context.coordinator
        view.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChangeText(_:)), for: .editingChanged)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return view
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, isEditing: $isEditing, onTextChanged: onTextChanged)
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        
        internal init(text: Binding<String>, isEditing: Binding<Bool>, onTextChanged: @escaping (_ newValue: String) -> Void) {
            _text = text
            _isEditing = isEditing
            self.onTextChanged = onTextChanged
        }
        
        @Binding var text: String
        @Binding var isEditing: Bool
        var onTextChanged: (_ newValue: String) -> Void
        
        @objc func textFieldDidChangeText(_ sender: UITextField) {
            if text != sender.text {
                text = sender.text ?? ""
                onTextChanged(sender.text ?? "")
            }
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.endEditing(false)
            return false
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            isEditing = false
        }
        
    }
    
    @Environment(\.isEnabled) var isEnabled

}

@available(iOS 16, *)
struct LegacyTextField_Previews: PreviewProvider {
    
    static var previews: some View {
        Container()
    }
    
    struct Container: View {
        
        @StateObject var state = PreviewState()
        @State var text: String = "Text"
        @State var isEditing: Bool = false
        
        var body: some View {
            VStack {
                LegacyTextField(text: $state.text, isEditing: $isEditing, font: .preferredFont(forTextStyle: .caption1))
                    .padding(EdgeInsets(horizontal: 8, vertical: 4))
                    .background(background)
                Text(state.text)
            }
        }
        
        @ViewBuilder var background: some View {
            let rect = RoundedRectangle(cornerRadius: 16)
            rect.stroke(style: .init(lineWidth: 2))
                .foregroundColor(.red)
        }
        
    }
    
    class PreviewState: ObservableObject {
        @Published var text: String = "Text"
    }
    
}
