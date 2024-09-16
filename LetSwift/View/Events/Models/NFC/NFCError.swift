//
//  NFCError.swift
//  LetSwift
//
//  Created by 지준용 on 8/19/24.
//

import CoreNFC


enum NFCError: Error, CustomDebugStringConvertible {
    case readerSessionInvalidationError(NFCReaderError.Code)
    case statusIsNotSupported
    case messageError
    case recordError
    case payloadEncodingError
    case NFCReadingUnavailable
    case typeNameFormatError(NFCTypeNameFormat)
    
    var debugDescription: String {
        switch self {
        case .readerSessionInvalidationError(let error):
            return "Reader Session Invalidation Error: \(error)"
        case .statusIsNotSupported:
            return "Status Error: NFCStatus is Not Supported"
        case .messageError:
            return "Error: NFC Tag's Message is Empty"
        case .recordError:
            return "Error: Record is Empty"
        case .payloadEncodingError:
            return "Error: Payload is not encoded"
        case .NFCReadingUnavailable:
            return "Error: NFC Scanning not support"
        case .typeNameFormatError(let typeNameFormat):
            let result = checkTypeNameFormat(typeNameFormat)
            return "Record typeNameFormat Error: Current TypeNameFormat is \(result)"
        }
    }
    
    private func checkTypeNameFormat(_ typeNameFormat: NFCTypeNameFormat) -> String {
        switch typeNameFormat {
        case .nfcWellKnown:
            return "NFC Well Known type"
        case .media:
            return "Media type"
        case .absoluteURI:
            return "Absolute URI type"
        case .nfcExternal:
            return "NFC External type"
        case .unknown:
            return "Unknown type"
        case .unchanged:
            return "Unchanged type"
        case .empty:
            return "Empty payload"
        @unknown default:
            return "Invalid data"
        }
    }
}
