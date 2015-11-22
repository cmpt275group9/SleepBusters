//
//  HealthSurvey.swift
//  SleepBusters
//
//  Created by Conrad Yeung on 2015-11-20.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation
import ResearchKit

public var SurveyTask: ORKNavigableOrderedTask {
    
    var steps = [ORKStep]()
    
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Some Information Required."
    instructionStep.text = "We need some basic information about you to properly analyse your sleep."
    steps += [instructionStep]
    
    //FormStep
    let formQuestionStepTitle = "Please fill out this form."
    let formQuestionStep = ORKFormStep(identifier: "FormStep", title: formQuestionStepTitle, text: nil)
    formQuestionStep.formItems = [ORKFormItem]()
    //basic info
    formQuestionStep.formItems?.append(ORKFormItem(sectionTitle: "Basic Information"))
    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
    nameAnswerFormat.multipleLines = false
    //first name
    formQuestionStep.formItems?.append(ORKFormItem(identifier: "fname", text: "First Name", answerFormat: nameAnswerFormat))
    //last name
    formQuestionStep.formItems?.append(ORKFormItem(identifier: "lname", text: "Last Name", answerFormat: nameAnswerFormat))
    //gender
    let genderChoices = [
        ORKTextChoice(text: "Male", value: 0),
        ORKTextChoice(text: "Female", value: 1),
    ]
    let genderAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: genderChoices)
    formQuestionStep.formItems?.append(ORKFormItem(identifier: "gender", text: "Gender", answerFormat: genderAnswerFormat))
    
    //physical
    formQuestionStep.formItems?.append(ORKFormItem(sectionTitle: "Physical Attributes"))
    let heightFormat = ORKNumericAnswerFormat.integerAnswerFormatWithUnit("cm")
    let weightFormat = ORKNumericAnswerFormat.integerAnswerFormatWithUnit("lbs")
    formQuestionStep.formItems?.append(ORKFormItem(identifier: "height", text: "Height", answerFormat: heightFormat))
    formQuestionStep.formItems?.append(ORKFormItem(identifier: "weight", text: "Weight", answerFormat: weightFormat))
    
    steps += [formQuestionStep]
    
//BerlinQuestions 1-9
    var textChoices: [ORKTextChoice] = [
        ORKTextChoice(text: "No Data", value: "empty")
    ]
    var choiceAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
    
    //Berlin1
    let berlinQuestionStepTitle = "Do you snore?"
    textChoices = [
        ORKTextChoice(text: "Yes", value: 0),
        ORKTextChoice(text: "No", value: 1),
        ORKTextChoice(text: "Don't Know", value: 2)
    ]
    choiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
    let berlinQuestionStep = ORKQuestionStep(identifier: "berlinQuestionStep", title: berlinQuestionStepTitle, answer: choiceAnswerFormat)
    berlinQuestionStep.optional = false
    steps += [berlinQuestionStep]
    
    //Berlin2
    let berlinQuestionStepTitle2 = "Your snoring is..?"
    textChoices = [
        ORKTextChoice(text: "Slightly louder than breathing", value: 0),
        ORKTextChoice(text: "As loud as talking", value: 1),
        ORKTextChoice(text: "Louder than talking", value: 2),
        ORKTextChoice(text: "Very loud. Can be heard in adjacent rooms", value: 3)
    ]
    choiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
    let berlinQuestionStep2 = ORKQuestionStep(identifier: "berlinQuestionStep2", title: berlinQuestionStepTitle2, answer: choiceAnswerFormat)
    berlinQuestionStep2.optional = false
    steps += [berlinQuestionStep2]
    
    //Berlin3
    let berlinQuestionStepTitle3 = "How often do you snore?"
    textChoices = [
        ORKTextChoice(text: "Nearly every day", value: 0),
        ORKTextChoice(text: "3-4 times a week", value: 1),
        ORKTextChoice(text: "1-2 times a week", value: 2),
        ORKTextChoice(text: "never or nearly never", value: 3)
    ]
    choiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
    let berlinQuestionStep3 = ORKQuestionStep(identifier: "berlinQuestionStep3", title: berlinQuestionStepTitle3, answer: choiceAnswerFormat)
    berlinQuestionStep3.optional = false
    steps += [berlinQuestionStep3]
    
    //Berlin4
    let berlinQuestionStepTitle4 = "Has your snoring ever bothered other people?"
    textChoices = [
        ORKTextChoice(text: "Yes", value: 0),
        ORKTextChoice(text: "No", value: 1)
    ]
    choiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
    let berlinQuestionStep4 = ORKQuestionStep(identifier: "berlinQuestionStep4", title: berlinQuestionStepTitle4, answer: choiceAnswerFormat)
    berlinQuestionStep4.optional = false
    steps += [berlinQuestionStep4]
    
    //Berlin5
    let berlinQuestionStepTitle5 = "Has anyone notice you quit breathing during your sleep?"
    textChoices = [
        ORKTextChoice(text: "Nearly every day", value: 0),
        ORKTextChoice(text: "3-4 times a week", value: 1),
        ORKTextChoice(text: "1-2 times a week", value: 2),
        ORKTextChoice(text: "1-2 times a month", value: 3),
        ORKTextChoice(text: "never or nearly never", value: 4)
    ]
    choiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
    let berlinQuestionStep5 = ORKQuestionStep(identifier: "berlinQuestionStep5", title: berlinQuestionStepTitle5, answer: choiceAnswerFormat)
    berlinQuestionStep5.optional = false
    steps += [berlinQuestionStep5]
    
    //Berlin6 // navigate to here if no snore
    let berlinQuestionStepTitle6 = "How often do you feel tired or fatigued after your sleep?"
    textChoices = [
        ORKTextChoice(text: "Nearly every day", value: 0),
        ORKTextChoice(text: "3-4 times a week", value: 1),
        ORKTextChoice(text: "1-2 times a week", value: 2),
        ORKTextChoice(text: "1-2 times a month", value: 3),
        ORKTextChoice(text: "never or nearly never", value: 4)
    ]
    choiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
    let berlinQuestionStep6 = ORKQuestionStep(identifier: "berlinQuestionStep6", title: berlinQuestionStepTitle6, answer: choiceAnswerFormat)
    berlinQuestionStep6.optional = false
    steps += [berlinQuestionStep6]
    
    //Berlin7 // navigation from here
    let berlinQuestionStepTitle7 = "Have you ever nodded off or fallen asleep while driving a vehicle?"
    textChoices = [
        ORKTextChoice(text: "Yes", value: 0),
        ORKTextChoice(text: "No", value: 1)
    ]
    choiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
    let berlinQuestionStep7 = ORKQuestionStep(identifier: "berlinQuestionStep7", title: berlinQuestionStepTitle7, answer: choiceAnswerFormat)
    berlinQuestionStep7.optional = false
    steps += [berlinQuestionStep7]
    
    //Berlin8
    let berlinQuestionStepTitle8 = "How often does this occur?"
    textChoices = [
        ORKTextChoice(text: "Nearly every day", value: 0),
        ORKTextChoice(text: "3-4 times a week", value: 1),
        ORKTextChoice(text: "1-2 times a week", value: 2),
        ORKTextChoice(text: "1-2 times a month", value: 3),
        ORKTextChoice(text: "Never or nearly never", value: 4)
    ]
    choiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
    let berlinQuestionStep8 = ORKQuestionStep(identifier: "berlinQuestionStep8", title: berlinQuestionStepTitle8, answer: choiceAnswerFormat)
    berlinQuestionStep8.optional = false
    steps += [berlinQuestionStep8]
    
    //Berlin9
    let berlinQuestionStepTitle9 = "Do you have high blood pressure?"
    textChoices = [
        ORKTextChoice(text: "Yes", value: 0),
        ORKTextChoice(text: "No", value: 1),
        ORKTextChoice(text: "Don't Know", value: 2)
    ]
    choiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
    let berlinQuestionStep9 = ORKQuestionStep(identifier: "berlinQuestionStep9", title: berlinQuestionStepTitle9, answer: choiceAnswerFormat)
    berlinQuestionStep9.optional = false
    steps += [berlinQuestionStep9]
    
//Health Questions
    //HealthQuestion1
    let textQuestionStepTitle = "Do you have any of the following medical conditions?"
    textChoices = [
        ORKTextChoice(text: "Diabetes", value: 0),
        ORKTextChoice(text: "Asthma", value: 1),
        ORKTextChoice(text: "Thyroid disease", value: 2),
        ORKTextChoice(text: "Kidney disease", value: 3)
    ]
    choiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.MultipleChoice, textChoices: textChoices)
    let textQuestionStep = ORKQuestionStep(identifier: "HealthQuestionStep", title: textQuestionStepTitle, answer: choiceAnswerFormat)
    steps += [textQuestionStep]
    
    //HealthQuestion2
    let textQuestionStepTitle2 = "Do any of the following describe you?"
    textChoices = [
        ORKTextChoice(text: "Frequent drinker (alcohol)", value: "alcohol"),
        ORKTextChoice(text: "Frequent caffiene intake", value: "coffee"),
        ORKTextChoice(text: "Cigarette smoker", value: "cigarettes")
    ]
    choiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.MultipleChoice, textChoices: textChoices)
    let textQuestionStep2 = ORKQuestionStep(identifier: "HealthQuestionStep2", title: textQuestionStepTitle2, answer: choiceAnswerFormat)
    steps += [textQuestionStep2]
    
    //Summary Step
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "All finished!"
    summaryStep.text = "Thank you for completing all the questions."
    steps += [summaryStep]
    
    let healthSurvey = ORKNavigableOrderedTask(identifier: "SurveyTask", steps: steps)
    
    //Navigation Rules
    let ResultSelector = ORKResultSelector(stepIdentifier: "berlinQuestionStep", resultIdentifier: "berlinQuestionStep")
    let predicateBerlin1 = ORKResultPredicate.predicateForChoiceQuestionResultWithResultSelector(ResultSelector, expectedAnswerValue: 1)
    let predicateBerlin2 = ORKResultPredicate.predicateForChoiceQuestionResultWithResultSelector(ResultSelector, expectedAnswerValue: 2)
    let predicateBerlin = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateBerlin1, predicateBerlin2])
    let predicateBerlinRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers:  [(predicateBerlin, "berlinQuestionStep6")])
    
    let ResultSelector2 = ORKResultSelector(stepIdentifier: "berlinQuestionStep7", resultIdentifier: "berlinQuestionStep7")
    let predicateBerlin3 = ORKResultPredicate.predicateForChoiceQuestionResultWithResultSelector(ResultSelector2, expectedAnswerValue: 1)
    let predicateBerlinRule2 = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers:  [(predicateBerlin3, "berlinQuestionStep9")])
    
    healthSurvey.setNavigationRule(predicateBerlinRule, forTriggerStepIdentifier: "berlinQuestionStep")
    healthSurvey.setNavigationRule(predicateBerlinRule2, forTriggerStepIdentifier: "berlinQuestionStep7")
    //let directRule = ORKDirectStepNavigationRule(destinationStepIdentifier: ORKNullStepIdentifier)
    //healthSurvey.setNavigationRule(directRule, forTriggerStepIdentifier: "be")

    
    return healthSurvey
}