import {CommandQuestionEntity} from "../models/command.question.entity.js";
import {AndroidTestingOptionsType} from "../models/android.testing.options.type.js";
import {TapperCommandsManager} from "../utils/tapper.commands.manager.js";
import {TapperCommandExecutionManager} from "../utils/tapper.command.execution.manager.js";
import {TapperCommandQueryBuilder} from "./tapper.command.query.builder.js";

/**
 * This File is the Manager on User Interaction Options (Touches Settings Category)
 * Here you will see 2 Ways of Executing the Commands
 * 1. By Picking the Options from CLI
 * 2. Run the Commands Directly (Direct Command or Desktop App)
 *
 * The File Separated into 3 Components of the Variables
 * 1. Question Content
 * 2. Dropdown Title
 * 3. Direct Command Key
 *
 * This Category Commands Should Always Support User Interaction Options Events Only
 * 1. User Touches
 * 2. User Scroll
 */
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

    /**
     * Use This Command Only when You want to Execute the Command Directly from Outside CLI
     * When you Run the CLI With Arguments Directly into this Category
     * Or When you Use The Desktop App Version That Use this Function Directly With All Attributes
     *
     * Example
     * @param attributes execute-testing-options overdraw y
     * Params Description
     * [Category] [Option Key] [Answer]
     */
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
                command: testingCommandToExecute,
                isShellPackageManagerCommand: false
            }, inputAnswer)
        }
    }

    /**
     * This Function is to Show The Commands List and Wait Until User Pick the Option
     * After Picking the Option we See if the Command Has a Question to ASK
     * Then Move to (onExecuteDeveloperCommandSubmissionQuestion)
     */
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

    /**
     * After Selecting the Command From the Dropdown Menu We have the Target Command to Run
     * Now we Will see if the Command has an Input Value or Direct Command
     * If it has an Input We Will ask that Question to have The Answer
     * If not We Will execute this Command Directly
     *
     * After Picking Up The Question and Command Its Time to Execute The Command
     * @param command
     * @private
     */
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

    /**
     * Now It's Time to Build the Command To Execute the Full Command
     * This Function Use the TapperCommandQueryBuilder Which is the Base for Building the Commands
     * Its Building the
     * 1. General Commands
     * 2. Package Manager Commands
     * 3. Set Property Commands
     *
     * @param command The Target Command to Execute (Example -> Change Overdraw ?)
     * @param inputOption The Answer of the Action (Example -> y == Yes, n == No)
     */
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

    /**
     * Used In CLI Options Only, Its Displaying the List of Options
     * When you Pick this Category
     * @private
     */
    private static getCommandsQuestions(): Array<CommandQuestionEntity<AndroidTestingOptionsType>> {
        return [
            {
                name: TapperTestingCommandsManager.QUESTION_CLICK,
                command: AndroidTestingOptionsType.CLICK,
                inputQuestion: TapperTestingCommandsManager.QUESTION_COORDINATES,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },
            {
                name: TapperTestingCommandsManager.QUESTION_DOUBLE_CLICK,
                command: AndroidTestingOptionsType.DOUBLE_CLICK,
                inputQuestion: TapperTestingCommandsManager.QUESTION_COORDINATES,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },
            {
                name: TapperTestingCommandsManager.QUESTION_SCROLL_TO_BOTTOM,
                command: AndroidTestingOptionsType.SCROLL_TO_BOTTOM,
                inputQuestion: TapperTestingCommandsManager.QUESTION_DEVICE_HEIGHT,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },
            {
                name: TapperTestingCommandsManager.QUESTION_SCROLL_TO_TOP,
                command: AndroidTestingOptionsType.SCROLL_TO_TOP,
                inputQuestion: TapperTestingCommandsManager.QUESTION_DEVICE_HEIGHT,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            }
        ];
    }

}
