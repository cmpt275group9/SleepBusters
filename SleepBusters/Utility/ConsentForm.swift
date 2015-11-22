//
//  ConsentForm.swift
//  SleepBusters
//
//  Created by Conrad Yeung on 2015-11-20.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation
import ResearchKit

public var ConsentDocument: ORKConsentDocument {
    
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Sleep Busters"
    
    let consentSectionTypes: [ORKConsentSectionType] = [
        .Overview,
        .DataGathering,
        .Privacy,
        .DataUse
    ]
    var consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
        if contentSectionType == .Overview{
            consentSection.summary = "To start, we first need some information from you."
            consentSection.content = "This short survey is to collect information and allow you to understand what we use this information for."
        }else if contentSectionType == .DataGathering{
            consentSection.summary = "Basic health questions will be asked, and data will be gathered from sleep tracking."
            consentSection.content = "Information we ask from you will be basic questions about your personal health. We also will gather data such as brain and respiratory activity from sleep tracking."
        }else if contentSectionType == .Privacy{
            consentSection.summary = "Your data will be kept private."
            consentSection.content = "All information you provide and data that the application gathers will be kept private and only released with your consent and motive."
        }else if contentSectionType == .DataUse{
            consentSection.summary = "Data collected will only be used for your own personal use."
            consentSection.content = "All data gathered will only be used for your own personal use. We will never use any data for anything other than your own diagnostics."
        }
        return consentSection
    }
    
    consentDocument.sections = consentSections
    
    consentDocument.sections = consentSections
    
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}

public var ConsentTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    var consentDocument = ConsentDocument
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    steps += [visualConsentStep]
    
    let signature = consentDocument.signatures!.first as? ORKConsentSignature!
    
    let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, inDocument: consentDocument)
    
    reviewConsentStep.text = "Review Agreement."
    reviewConsentStep.reasonForConsent = "Consent to provide information."
    
    steps += [reviewConsentStep]
    
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
