export interface CommandQuestionEntity<QuestionKey> {
    name: string,
    isDirectCommand: boolean,
    command: QuestionKey,
    inputQuestion: string | undefined,
    isShellPackageManagerCommand: boolean
}
