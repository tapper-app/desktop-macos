export interface TapperArgumentEntity {
    command: string,
    description: string,
    args: Array<TapperArgumentOption> | undefined,
    options: Array<TapperArgumentOptionItem> | undefined,
}

export interface TapperArgumentOption {
    name: string,
    description: string
}

export interface TapperArgumentOptionItem {
    name: string,
    description: string
}