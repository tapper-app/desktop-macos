import {CommandQuestionEntity} from "../models/command.question.entity.js";
import {AndroidTestingOptionsType} from "../models/android.testing.options.type.js";
import {TapperCommandsManager} from "../utils/tapper.commands.manager.js";
import {TapperCommandExecutionManager} from "../utils/tapper.command.execution.manager.js";
import {TapperCommandQueryBuilder} from "./tapper.command.query.builder.js";
import {animationFrame} from "rxjs";

export class TapperTestingCommandsManager {

    private static QUESTION_CLICK = "Perform Click Action By Coordinates";
    private static QUESTION_DOUBLE_CLICK = "Perform Double Click Action By Coordinates";
    private static QUESTION_SCROLL_TO_BOTTOM = "Perform Scroll To Bottom By Device Height";
    private static QUESTION_SCROLL_TO_TOP = "Perform Scroll To Top By Device Height";

    // SubList Selected Option Question
    private static QUESTION_COORDINATES = "coordinates";
    private static QUESTION_DEVICE_HEIGHT = "height";

    // Direct Executable Actions
    private static EXECUTION_CLICK = "click";
    private static EXECUTION_DOUBLE_CLICK = "double-click";
    private static EXECUTION_SCROLL_TO_TOP = "scroll-top";
    private static EXECUTION_SCROLL_TO_BOTTOM = "scroll-bottom";

    public static onExecuteCommandByAttributes(attributes: Array<string>) {
        let testingCommandToExecute: AndroidTestingOptionsType | null = null;
        const inputAnswer = attributes[attributes.length - 1]?.trim() ?? "";
        if (attributes.includes(TapperTestingCommandsManager.EXECUTION_CLICK)) {
            testingCommandToExecute = AndroidTestingOptionsType.CLICK;
        }

        if (attributes.includes(TapperTestingCommandsManager.EXECUTION_DOUBLE_CLICK)) {
            testingCommandToExecute = AndroidTestingOptionsType.DOUBLE_CLICK;
        }

        if (attributes.includes(TapperTestingCommandsManager.EXECUTION_SCROLL_TO_TOP)) {
            testingCommandToExecute = AndroidTestingOptionsType.SCROLL_TO_TOP;
        }

        if (attributes.includes(TapperTestingCommandsManager.EXECUTION_SCROLL_TO_BOTTOM)) {
            testingCommandToExecute = AndroidTestingOptionsType.SCROLL_TO_BOTTOM;
        }

        if (testingCommandToExecute != null) {
            this.onExecuteCommand({
                name: "",
                isDirectCommand: false,
                inputQuestion: "",
                command: testingCommandToExecute
            }, inputAnswer)
        }
    }

    public static onExecuteTestingOptionsCommands() {
        const questions = this.getCommandsQuestions();
        TapperCommandsManager.onAskCommandByTestingQuestions(questions)
            .then((selectedCommand) => {
                if (selectedCommand) {
                    this.onExecuteTestingCommandSubmissionQuestion(selectedCommand);
                }
            })
            .catch((error) => console.error(error))
    }

    public static onExecuteTestingCommandSubmissionQuestion(command: CommandQuestionEntity<AndroidTestingOptionsType>) {
        if (command.inputQuestion) {
            const question = this.getQuestionNameByKey(command.inputQuestion)
            TapperCommandsManager.onAskStringInputQuestion(question)
                .then((answer) => {
                    this.onExecuteCommand(command, answer);
                });
        } else {
            this.onExecuteCommand(command, "")
        }
    }

    public static async onExecuteCommand(command: CommandQuestionEntity<AndroidTestingOptionsType>, inputOption: string) {
        if (command.command == AndroidTestingOptionsType.DOUBLE_CLICK) {
            const coordinates = inputOption.replace(",", " ")
            const queryToExecute =  new TapperCommandQueryBuilder()
                .setShellCommand()
                .setInput()
                .setAndroidTestingKey(AndroidTestingOptionsType.CLICK)
                .setCustomValue(coordinates)
                .getQuery();

            TapperCommandExecutionManager.onExecuteCommandString(queryToExecute);
            await TapperCommandExecutionManager.sleep(300);
            TapperCommandExecutionManager.onExecuteCommandString(queryToExecute);
            return
        }

        if (command.command == AndroidTestingOptionsType.CLICK) {
            const coordinates = inputOption.replace(",", " ")
            const queryToExecute =  new TapperCommandQueryBuilder()
                .setShellCommand()
                .setInput()
                .setAndroidTestingKey(command.command)
                .setCustomValue(coordinates)
                .getQuery();

            TapperCommandExecutionManager.onExecuteCommandString(queryToExecute);
            return
        }

        const isScrollEvent = command.command == AndroidTestingOptionsType.SCROLL_TO_TOP || command.command == AndroidTestingOptionsType.SCROLL_TO_BOTTOM
        if (isScrollEvent) {
            const screenHeight = parseInt(inputOption.trim())
            const screenWidth = 900;
            let startPoint = 0;
            let endPoint = 0;

            if (command.command == AndroidTestingOptionsType.SCROLL_TO_TOP) {
                startPoint = 200;
                endPoint = screenHeight - 400
            } else {
                startPoint = screenHeight - 400;
                endPoint = 200;
            }

            const queryToExecute =  new TapperCommandQueryBuilder()
                .setShellCommand()
                .setInput()
                .setAndroidTestingKey(AndroidTestingOptionsType.SCROLL_TO_BOTTOM)
                .setCustomValue(`${screenWidth / 2} ${startPoint} ${screenWidth / 2} ${endPoint}`)
                .getQuery();

            TapperCommandExecutionManager.onExecuteCommandString(queryToExecute);
            return
        }
    }

    private static getQuestionNameByKey(key: string): string {
        if (key === TapperTestingCommandsManager.QUESTION_COORDINATES) {
            return "Please Insert Coordinates of the Click on The Device (x,y) ?";
        } else if (key === TapperTestingCommandsManager.QUESTION_DEVICE_HEIGHT) {
            return "Please Insert your Device Screen Height in Pixel";
        } else {
            return "";
        }
    }

    private static getCommandsQuestions(): Array<CommandQuestionEntity<AndroidTestingOptionsType>> {
        return [
            {
                name: TapperTestingCommandsManager.QUESTION_CLICK,
                command: AndroidTestingOptionsType.CLICK,
                inputQuestion: TapperTestingCommandsManager.QUESTION_COORDINATES,
                isDirectCommand: false
            },
            {
                name: TapperTestingCommandsManager.QUESTION_DOUBLE_CLICK,
                command: AndroidTestingOptionsType.DOUBLE_CLICK,
                inputQuestion: TapperTestingCommandsManager.QUESTION_COORDINATES,
                isDirectCommand: false
            },
            {
                name: TapperTestingCommandsManager.QUESTION_SCROLL_TO_BOTTOM,
                command: AndroidTestingOptionsType.SCROLL_TO_BOTTOM,
                inputQuestion: TapperTestingCommandsManager.QUESTION_DEVICE_HEIGHT,
                isDirectCommand: false
            },
            {
                name: TapperTestingCommandsManager.QUESTION_SCROLL_TO_TOP,
                command: AndroidTestingOptionsType.SCROLL_TO_TOP,
                inputQuestion: TapperTestingCommandsManager.QUESTION_DEVICE_HEIGHT,
                isDirectCommand: false
            }
        ];
    }

}
