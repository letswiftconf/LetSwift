//
//  StampButton.swift
//  LetSwift
//
//  Created by 지준용 on 8/19/24.
//

import CoreNFC
import SwiftUI


struct StampButton: UIViewRepresentable {
    
    // MARK: - Properties
    private let foregroundColor: UIColor
    private let backgroundColor: UIColor
    @Binding var payload: String
    
    // MARK: - Init
    init(
        foregroundColor: UIColor = .black,
        backgroundColor: UIColor = .whiteText,
        payload: Binding<String>
    ) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        _payload = payload
    }
    
    // MARK: - UIViewRepresentable
    func makeUIView(context: Context) -> UIButton {
        let button = UIButton(configuration: .filled())
        button.configuration?.title = String(localized: "stampButton.title")
        button.configuration?.baseBackgroundColor = backgroundColor
        button.configuration?.baseForegroundColor = foregroundColor
        button.configuration?.background.cornerRadius = 8
        button.addAction(UIAction { action in context.coordinator.startReadingNFCTag() },
                         for: .touchUpInside)
        
        return button
    }
    
    func updateUIView(_ uiView: UIButton, context: Context) {}
    
    // MARK: - Coordinator
    func makeCoordinator() -> NFCReaderCoordinator {
        return NFCReaderCoordinator(payload: $payload)
    }
}


final class NFCReaderCoordinator: NSObject, NFCNDEFReaderSessionDelegate {
    
    // MARK: - Properties
    private let validation = NFCValidation()
    private var session: NFCNDEFReaderSession?
    @Binding var payload: String
    
    // MARK: - Init
    init(payload: Binding<String>) {
        _payload = payload
    }
    
    // MARK: - Methods
    func startReadingNFCTag() {
        let readingNFC = Result { try validation.checkNFCReadingAvailable() }
        
        switch readingNFC {
        case .success():
            session = NFCNDEFReaderSession(delegate: self,
                                           queue: DispatchQueue.main,
                                           invalidateAfterFirstRead: false)
            session?.alertMessage = String(localized: "defaultNFC.description",
                                           table: "NFCLocalizable")
            session?.begin()
        case .failure(let error):
            // TODO: NFC 읽기불가 시, 재시도 요청 또는 QR코드로 넘기는 코드 필요.
            debugPrint(error)
        }
    }
    
    // MARK: - NFCNDEFReaderSessionDelegate
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: any Error) {
        do {
            try validation.isValidateReaderSession(of: error)
        } catch {
            session.restartPolling()
            debugPrint(error)
        }
        
        self.session = nil
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [any NFCNDEFTag]) {
        if tags.count > 1 {
            session.alertMessage = String(localized: "detectMultipleTags.description",
                                          table: "NFCLocalizable")
            return session.restartPolling()
        }
        
        guard let tag = tags.first else { return } // 단일 태그 전용
        
        tag.queryNDEFStatus { status, _, error in
            do {
                try self.validation.checkQueryNDEFStatus(error, status)
                
                self.tagReadNDEF(session, of: tag)
            } catch {
                session.restartPolling()
                debugPrint(error)
            }
        }
    }
    
    private func tagReadNDEF(_ session: NFCNDEFReaderSession, of tag: NFCNDEFTag) {
        tag.readNDEF { message, error in
            let result = self.validation.isValidateNDEFMessage(in: message)
            
            switch result {
            case .success(let payload):
                self.payload = payload
                session.alertMessage = String(localized: "successStampCollection.description",
                                              table: "NFCLocalizable")
                session.invalidate()
                
            case .failure(let error):
                session.alertMessage = String(reflecting: error)
                session.restartPolling()
                debugPrint(error)
            }
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Required Method
        // NDEF 메서드 감지, Need for `didDetect tags` Method
    }
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        // to remove a console alert
    }
}

