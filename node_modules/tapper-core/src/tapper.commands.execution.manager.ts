import {TapperCommandsManager} from "./utils/tapper.commands.manager.js";
import {TapperGeneralOptionsCommandsManager} from "./commands/tapper.general.options.commands.manager.js";
import {TapperDeveloperOptionsCommandsManager} from "./commands/tapper.developer.options.commands.manager.js";
import {AdbValidationManager} from "./utils/adb.validation.manager.js";
import {TapperCommandExecutionManager} from "./utils/tapper.command.execution.manager.js";
import {TapperTestingCommandsManager} from "./commands/tapper.testing.commands.manager.js";
import {AndroidTestingOptionsType} from "./models/android.testing.options.type.js";
import {CommandQuestionEntity} from "./models/command.question.entity.js";

export class TapperCommandsExecutionManager {

    public static onExecuteCommand(command: string) {
        if (command === TapperCommandsManager.VIEW_TESTING_OPTIONS_COMMAND) {
            this.onPrintOptions(TapperGeneralOptionsCommandsManager.getAvailableCommands());
            TapperCommandsManager.onRepeatAskCommandsQuestion();
            return
        }

        if (command === TapperCommandsManager.VIEW_DEVELOPER_OPTIONS_COMMAND) {
            this.onPrintOptions(TapperDeveloperOptionsCommandsManager.getAvailableCommands());
            TapperCommandsManager.onRepeatAskCommandsQuestion();
            return
        }

        if (command === TapperCommandsManager.VALIDATE_ADB_INSTALLATION_COMMAND) {
            AdbValidationManager.checkAdbInstallation();
            return;
        }

        if (command === TapperCommandsManager.HELP_COMMAND) {
            this.onPrintHelpCommandsExamples();
            TapperCommandsManager.onRepeatAskCommandsQuestion();
            return;
        }

        if (command === TapperCommandsManager.EXECUTE_GENERAL_OPTIONS_COMMAND) {
            TapperGeneralOptionsCommandsManager.onExecuteGeneralOptionsCommands();
            return;
        }

        if (command === TapperCommandsManager.EXECUTE_DEVELOPER_OPTION_COMMAND) {
            TapperDeveloperOptionsCommandsManager.onExecuteDeveloperOptionsCommands();
            return;
        }

        if (command === TapperCommandsManager.EXECUTE_ANDROID_MONKEY_TESTING_COMMAND) {
            this.onExecuteNativeAndroidMonkeyTesting();
            return;
        }

        if (command === TapperCommandsManager.EXECUTE_TESTING_EVENTS_COMMAND) {
            TapperTestingCommandsManager.onExecuteTestingOptionsCommands();
            return;
        }

        if (command === TapperCommandsManager.EXECUTE_AUTO_FLOW_TESTING_COMMAND) {
            this.onExecuteAutoTestingFlow();
            return;
        }
    }

    public static onExecuteCommandWithAttributes(command: string, attributes: Array<string>) {
        if (command === TapperCommandsManager.EXECUTE_AUTO_FLOW_TESTING_COMMAND) {
            this.onExecuteAutoTestingFlow();
            return
        }

        if (command === TapperCommandsManager.EXECUTE_TESTING_EVENTS_COMMAND) {
            TapperTestingCommandsManager.onExecuteCommandByAttributes(attributes);
            return;
        }

        if (command === TapperCommandsManager.EXECUTE_GENERAL_OPTIONS_COMMAND) {
            TapperGeneralOptionsCommandsManager.onExecuteCommandByAttributes(attributes);
            return;
        }

        if (command === TapperCommandsManager.EXECUTE_DEVELOPER_OPTION_COMMAND) {
            TapperDeveloperOptionsCommandsManager.onExecuteCommandByAttributes(attributes);
            return;
        }

        if (command === TapperCommandsManager.EXECUTE_ANDROID_MONKEY_TESTING_COMMAND) {
            this.onExecuteNativeAndroidMonkeyTesting();
            return;
        }
    }

    private static async onExecuteAutoTestingFlow() {
        const eventsCountAnswer = await TapperCommandsManager.onAskStringInputQuestion("How many Events you want To Execute on Your Device ?");
        const screenHeightAnswer = await TapperCommandsManager.onAskStringInputQuestion("What is the Screen Height of your Device (In Pixel) ?");
        const screenHeight = parseInt(screenHeightAnswer);
        const eventsCount = parseInt(eventsCountAnswer);
        if (!screenHeight || screenHeight == 0) {
            return
        }

        if (!eventsCount || eventsCount == 0) {
            return
        }

        const testingEventsToExecute: Array<CommandQuestionEntity<AndroidTestingOptionsType>> = [];
        const testingOptions = [
            AndroidTestingOptionsType.CLICK,
            AndroidTestingOptionsType.DOUBLE_CLICK,
            AndroidTestingOptionsType.SCROLL_TO_BOTTOM,
            AndroidTestingOptionsType.SCROLL_TO_TOP
        ];

        for (let i = 0; i < eventsCount; i++) {
            const randomIndex = Math.floor(Math.random() * testingOptions.length);
            const randomOption = testingOptions[randomIndex];
            if (randomOption) {
                const isScrollEvent = randomOption == AndroidTestingOptionsType.SCROLL_TO_TOP || randomOption == AndroidTestingOptionsType.SCROLL_TO_BOTTOM;
                let optionResult = "";
                if (isScrollEvent) {
                    optionResult = `${screenHeight}`;
                } else {
                    const coordinates = TapperCommandExecutionManager.getRandomCoordinates(900, screenHeight);
                    optionResult = `${coordinates.x},${coordinates.y}`;
                }

                testingEventsToExecute.push({
                    name: "",
                    isDirectCommand: false,
                    inputQuestion: "",
                    command: randomOption
                })
            }
        }

        for (let i = 0; i < testingEventsToExecute.length; i++) {
            const eventToExecute = testingEventsToExecute[i];
            if (eventToExecute) {
                await TapperTestingCommandsManager.onExecuteCommand(eventToExecute, eventToExecute.inputQuestion ?? "");
                await TapperCommandExecutionManager.sleep(300);
            }
        }
    }

    private static async onExecuteNativeAndroidMonkeyTesting() {
        const packageNameQuestion = await TapperCommandsManager.onAskStringInputQuestion("Insert Your Application Package Name ?");
        const numberOfEventsCount = await TapperCommandsManager.onAskStringInputQuestion("Write how Many Events you want to Execute on your Application ?");
        if (numberOfEventsCount === '0' || numberOfEventsCount === '' || !numberOfEventsCount) {
            return
        }

        if (!packageNameQuestion || packageNameQuestion === '') {
            return
        }

        TapperCommandExecutionManager.onExecuteCommandStringWithoutInput(`adb shell monkey -p ${packageNameQuestion} -v ${numberOfEventsCount}`);
    }

    private static onPrintHelpCommandsExamples() {
        console.log("")
        console.log("Tapper Help Commands, The Following Commands is an Short Example for Tapper Usage")
        console.log("Developer Options Examples")
        console.log("tapper execute-dev-option layout y -- To Enable Layout Bounds")
        console.log("tapper execute-dev-option layout n -- To Disable Layout Bounds")
        console.log("")
        console.log("Testing Functions Example")
        console.log("tapper execute-testing-events click 538,1727.9 -- To Perform Click By Coordinates (x,y)")
        console.log("tapper execute-testing-events double-click 538,1727.9 -- To Perform Double Click By Coordinates (x,y)")
        console.log("")
        console.log("General Options Example")
        console.log("tapper execute-general-options device -- To Show Connected Android Devices")
        console.log("tapper execute-general-options install pathToApkFile -- To Install Apk on The Device")
        console.log("")
        console.log("Execute Native Monkey Testing By Questions")
        console.log("tapper execute-monkey-testing")
        console.log("")
    }

    private static onPrintOptions(options: Array<string>) {
        for (let i = 0; i < options.length; i++) {
            console.log(options[i])
        }
    }

}
