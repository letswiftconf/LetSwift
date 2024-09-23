//
//  NFCValidation.swift
//  LetSwift
//
//  Created by 지준용 on 8/19/24.
//

import CoreNFC


struct NFCValidation {
    func isValidateReaderSession(of error: Error) throws {
        guard let error = error as? NFCReaderError else { return }
        
        if error.code != .readerSessionInvalidationErrorFirstNDEFTagRead
            && error.code != .readerSessionInvalidationErrorUserCanceled {
            throw NFCError.readerSessionInvalidationError(error.code)
        }
    }
    
    func checkQueryNDEFStatus(_ error: Error?, _ status: NFCNDEFStatus) throws {
        guard error == nil else { throw error! }
        guard status != .notSupported else { throw NFCError.statusIsNotSupported }
    }
    
    func isValidateNDEFMessage(in tag: NFCNDEFMessage?) -> Result<String, Error> {
        do {
            let message = try isValidateMessage(tag: tag)  // NFC Tag 인식 확인
            let record = try isValidateRecord(of: message) // 단일 Record 적용
            try isValidateTypeNameFormat(record: record)   // Record 타입 형식 확인
            let payload = try isValidatePayloadEncoding(payload: record.payload)  // payload 인코딩
            
            let languageCodeLength = Int(record.payload.first ?? 0) & 0x3F
            let result = String(payload.dropFirst(languageCodeLength + 1)) // 언어 코드 제거
            
            try checkPayload(payload: result)
            
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
    func checkNFCReadingAvailable() throws {
        guard NFCNDEFReaderSession.readingAvailable else {
            throw NFCError.NFCReadingUnavailable
        }
    }
}

// MARK: - ValidateNDEFMessage
fileprivate extension NFCValidation {
    func isValidateMessage(tag: NFCNDEFMessage?) throws -> NFCNDEFMessage {
        guard let message = tag else {
            throw NFCError.messageError
        }
        
        return message
    }
    
    func isValidateRecord(of message: NFCNDEFMessage) throws -> NFCNDEFPayload {
        guard let record = message.records.first else {
            throw NFCError.recordError
        }
        
        return record
    }
    
    func isValidateTypeNameFormat(record: NFCNDEFPayload) throws {
        let typeNameFormat = record.typeNameFormat
        
        guard typeNameFormat == .absoluteURI
            || typeNameFormat == .nfcWellKnown else {
            throw NFCError.typeNameFormatError(typeNameFormat)
        }
    }
    
    func isValidatePayloadEncoding(payload: Data) throws -> String {
        guard let payload = String(data: payload, encoding: .utf8) else {
            throw NFCError.payloadEncodingError
        }
        
        return payload
    }
    
    private func checkPayload(payload: String) throws {
        guard Company.allCases.firstIndex(where: {$0.payload == payload}) != nil else {
            throw NFCError.messageError
        }
    }
}
