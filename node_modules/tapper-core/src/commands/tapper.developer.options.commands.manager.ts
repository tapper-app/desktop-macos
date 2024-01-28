import {TapperCommandsManager} from "../utils/tapper.commands.manager.js";
import {CommandQuestionEntity} from "../models/command.question.entity.js";
import {AndroidSettingsKey} from "../models/android.settings.key.js";
import {TapperCommandQueryBuilder} from "./tapper.command.query.builder.js";
import {TapperCommandExecutionManager} from "../utils/tapper.command.execution.manager.js";

/**
 * This File is the Manager on Developer Options (Developer Settings Category)
 * Here you will see 2 Ways of Executing the Commands
 * 1. By Picking the Options from CLI
 * 2. Run the Commands Directly (Direct Command or Desktop App)
 *
 * The File Separated into 3 Components of the Variables
 * 1. Question Content
 * 2. Dropdown Title
 * 3. Direct Command Key
 *
 * This Category has an Extra Checks from other Categories Why ?
 * Because this Category has More than 2 Types of Commands
 * 1. System Commands
 * 2. Global Attributes
 * 3. 2 Ways of Modifying the Attributes
 *
 * This Category Commands Should Always Support Developer Options Events Only
 */
export class TapperDeveloperOptionsCommandsManager {

    // SubList Ask Question
    private static QUESTION_ENABLED_DISABLED = "ask_enabled_disabled"
    private static QUESTION_GPU_RENDERING_TYPE = "gpu_rendering"

    // CLI Actions List - SubList from Developer Options
    private static QUESTION_TOGGLE_GPU_OVERDRAW = "Enable / Disable Gpu Overdraw";
    private static QUESTION_TOGGLE_LAYOUT_BOUNDS = "Enable / Disable Layout Bounds";
    private static QUESTION_TOGGLE_TOUCHES = "Enable / Disable Touches";
    private static QUESTION_TOGGLE_POINTER_LOCATION = "Enable / Disable Pointer Location";
    private static QUESTION_TOGGLE_STRICT_MODE = "Enable / Disable Strict Mode";
    private static QUESTION_CHANGE_GPU_VIEW_UPDATES = "Enable / Disable View Updates";
    private static QUESTION_TOGGLE_DEVELOPER_OPTIONS = "Enable / Disable Developer Options";
    private static QUESTION_TOGGLE_USB_DEBUGGING = "Enable / Disable USB Debugging";
    private static QUESTION_TOGGLE_HARDWARE_ACCELERATION = "Enable / Disable Hardware Acceleration";
    private static QUESTION_TOGGLE_FORCE_RTL = "Enable / Disable Force Rtl";
    private static QUESTION_CHANGE_GPU_RENDERING = "Change Gpu Rendering";

    // Direct Executable Actions
    private static EXECUTION_GPU_OVERDRAW = "overdraw";
    private static EXECUTION_LAYOUT_BOUNDS = "layout";
    private static EXECUTION_TOUCHES = "touch";
    private static EXECUTION_POINTER_LOCATION = "pointer";
    private static EXECUTION_STRICT_MODE = "strict";
    private static EXECUTION_GPU_UPDATES = "gpu-updates";
    private static EXECUTION_DEVELOPER_OPTIONS = "dev-options";
    private static EXECUTION_USB_DEBUGGING = "usb";
    private static EXECUTION_HARDWARE_ACCELERATOR = "hardware";
    private static EXECUTION_RTL = "rtl";
    private static EXECUTION_CHANGE_GPU_RENDERING = "gpu-rendering";

    /**
     * Use This Command Only when You want to Execute the Command Directly from Outside CLI
     * When you Run the CLI With Arguments Directly into this Category
     * Or When you Use The Desktop App Version That Use this Function Directly With All Attributes
     *
     * Example
     * @param attributes execute-dev-options overdraw y
     * Params Description
     * [Category] [Option Key] [Answer]
     */
    public static onExecuteCommandByAttributes(attributes: Array<string>) {
        let command: AndroidSettingsKey | null = null;
        const inputAnswer = attributes[attributes.length - 1]?.trim() ?? "";

        if (attributes.includes(TapperDeveloperOptionsCommandsManager.EXECUTION_GPU_OVERDRAW)) {
            command = AndroidSettingsKey.GPU_OVERDRAW;
        }

        if (attributes.includes(TapperDeveloperOptionsCommandsManager.EXECUTION_LAYOUT_BOUNDS)) {
            command = AndroidSettingsKey.LAYOUT_BOUNDS;
        }

        if (attributes.includes(TapperDeveloperOptionsCommandsManager.EXECUTION_TOUCHES)) {
            command = AndroidSettingsKey.SHOW_TOUCHES;
        }

        if (attributes.includes(TapperDeveloperOptionsCommandsManager.EXECUTION_POINTER_LOCATION)) {
            command = AndroidSettingsKey.SHOW_POINTER_LOCATION;
        }

        if (attributes.includes(TapperDeveloperOptionsCommandsManager.EXECUTION_STRICT_MODE)) {
            command = AndroidSettingsKey.STRICT_MODE;
        }

        if (attributes.includes(TapperDeveloperOptionsCommandsManager.EXECUTION_GPU_UPDATES)) {
            command = AndroidSettingsKey.VIEW_UPDATES;
        }

        if (attributes.includes(TapperDeveloperOptionsCommandsManager.EXECUTION_DEVELOPER_OPTIONS)) {
            command = AndroidSettingsKey.DEVELOPER_OPTIONS;
        }

        if (attributes.includes(TapperDeveloperOptionsCommandsManager.EXECUTION_USB_DEBUGGING)) {
            command = AndroidSettingsKey.USB_DEBUGGING_V2;
        }

        if (attributes.includes(TapperDeveloperOptionsCommandsManager.EXECUTION_HARDWARE_ACCELERATOR)) {
            command = AndroidSettingsKey.HARDWARE_ACCELERATION;
        }

        if (attributes.includes(TapperDeveloperOptionsCommandsManager.EXECUTION_RTL)) {
            command = AndroidSettingsKey.FORCE_RTL;
        }

        if (attributes.includes(TapperDeveloperOptionsCommandsManager.EXECUTION_CHANGE_GPU_RENDERING)) {
            command = AndroidSettingsKey.GPU_RENDERING;
        }

        if (command != null) {
            this.onExecuteCommand({
                name: "",
                isDirectCommand: false,
                inputQuestion: "",
                command: command,
                isShellPackageManagerCommand: false
            }, inputAnswer)
        }
    }

    /**
     * This Function is to Show The Commands List and Wait Until User Pick the Option
     * After Picking the Option we See if the Command Has a Question to ASK
     * Then Move to (onExecuteDeveloperCommandSubmissionQuestion)
     */
    public static onExecuteDeveloperOptionsCommands() {
        const questions = this.getCommandsQuestions();
        TapperCommandsManager.onAskCommandSettingsQuestions(questions)
            .then((selectedCommand) => {
                if (selectedCommand) {
                    this.onExecuteDeveloperCommandSubmissionQuestion(selectedCommand);
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
    private static onExecuteDeveloperCommandSubmissionQuestion(command: CommandQuestionEntity<AndroidSettingsKey>) {
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
    public static onExecuteCommand(command: CommandQuestionEntity<AndroidSettingsKey>, inputOption: string) {
        const isYesAnswer = inputOption.toLowerCase().includes('y')
        const commandToExecute = new TapperCommandQueryBuilder()
            .setShellCommand()

        if (command.command == AndroidSettingsKey.GPU_OVERDRAW) {
            if (isYesAnswer) {
                TapperCommandExecutionManager.onExecuteCommandString("adb shell setprop debug.hwui.overdraw show");
            } else {
                TapperCommandExecutionManager.onExecuteCommandString("adb shell setprop debug.hwui.overdraw false");
            }
            return
        }

        if (this.isSetPropAttribute(command.command)) {
            commandToExecute.setProp().setSystemSettingsKey(command.command)
        } else {
            commandToExecute
                .setSettings()
                .put()

            if (this.isGlobalAttribute(command.command)) {
                commandToExecute.setGlobal()
            }

            if (this.isSystemAttribute(command.command)) {
                commandToExecute.setSystem()
            }

            commandToExecute.setSystemSettingsKey(command.command)
        }

        const isGpuRenderingAttribute = command.command == AndroidSettingsKey.GPU_RENDERING
        if (isGpuRenderingAttribute) {
            const isOpenGlAnswer = inputOption.toLowerCase().includes('o')
            if (isOpenGlAnswer) {
                commandToExecute.setCustomValue("skiagl")
            } else {
                commandToExecute.setCustomValue("skiavk")
            }
        } else {
            if (this.isNumberAttribute(command.command)) {
                if (isYesAnswer) {
                    commandToExecute.setEnabledByNumbers(true)
                } else {
                    commandToExecute.setEnabledByNumbers(false)
                }
            } else {
                commandToExecute.setBoolean(isYesAnswer)
            }
        }

        TapperCommandExecutionManager.onExecuteCommandString(commandToExecute.getQuery());
        TapperCommandExecutionManager.onExecuteCommandStringWithoutInput("adb shell service check SurfaceFlinger");
        TapperCommandExecutionManager.onExecuteCommandStringWithoutInput("adb shell service call activity 1599295570");
    }

    private static isNumberAttribute(command: AndroidSettingsKey): boolean {
        if (command == AndroidSettingsKey.DEVELOPER_OPTIONS) {
            return true;
        }

        if (command == AndroidSettingsKey.FORCE_RTL) {
            return true;
        }

        if (command == AndroidSettingsKey.STRICT_MODE) {
            return true;
        }

        if (command == AndroidSettingsKey.SHOW_POINTER_LOCATION) {
            return true;
        }

        if (command == AndroidSettingsKey.SHOW_TOUCHES) {
            return true;
        }

        if (command == AndroidSettingsKey.USB_DEBUGGING_V2) {
            return true;
        }

        return false;
    }

    private static isSystemAttribute(command: AndroidSettingsKey): boolean {
        if (command == AndroidSettingsKey.SHOW_TOUCHES) {
            return true;
        }

        if (command == AndroidSettingsKey.SHOW_POINTER_LOCATION) {
            return true;
        }

        return false;
    }

    private static isGlobalAttribute(command: AndroidSettingsKey): boolean {
        if (command == AndroidSettingsKey.DEVELOPER_OPTIONS) {
            return true;
        }

        if (command == AndroidSettingsKey.STRICT_MODE) {
            return true;
        }

        if (command == AndroidSettingsKey.FORCE_RTL) {
            return true;
        }

        if (command == AndroidSettingsKey.USB_DEBUGGING_V2) {
            return true;
        }

        return false;
    }

    private static isSetPropAttribute(command: AndroidSettingsKey): boolean {
        if (command == AndroidSettingsKey.HARDWARE_ACCELERATION) {
            return true;
        }

        if (command == AndroidSettingsKey.GPU_OVERDRAW) {
            return true;
        }

        if (command == AndroidSettingsKey.LAYOUT_BOUNDS) {
            return true;
        }

        if (command == AndroidSettingsKey.VIEW_UPDATES) {
            return true;
        }

        if (command == AndroidSettingsKey.GPU_RENDERING) {
            return true;
        }

        return false;
    }

    private static getQuestionNameByKey(key: string): string {
        if (key === TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED) {
            return "Do you want To Enable or Disable the Feature ? (y, n)";
        } else if (key === TapperDeveloperOptionsCommandsManager.QUESTION_GPU_RENDERING_TYPE) {
            return "Do you wnat To change gpu rendering type ? Type (o,v) for (OpenGL, Vulkan)";
        } else {
            return "";
        }
    }

    /**
     * Used In CLI Options Only, Its Displaying the List of Options
     * When you Pick this Category
     * @private
     */
    private static getCommandsQuestions(): Array<CommandQuestionEntity<AndroidSettingsKey>> {
        return [
            {
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_GPU_OVERDRAW,
                command: AndroidSettingsKey.GPU_OVERDRAW,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_LAYOUT_BOUNDS,
                command: AndroidSettingsKey.LAYOUT_BOUNDS,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_TOUCHES,
                command: AndroidSettingsKey.SHOW_TOUCHES,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_POINTER_LOCATION,
                command: AndroidSettingsKey.SHOW_POINTER_LOCATION,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_STRICT_MODE,
                command: AndroidSettingsKey.STRICT_MODE,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_CHANGE_GPU_VIEW_UPDATES,
                command: AndroidSettingsKey.VIEW_UPDATES,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_DEVELOPER_OPTIONS,
                command: AndroidSettingsKey.DEVELOPER_OPTIONS,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_USB_DEBUGGING,
                command: AndroidSettingsKey.USB_DEBUGGING_V2,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_HARDWARE_ACCELERATION,
                command: AndroidSettingsKey.HARDWARE_ACCELERATION,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_FORCE_RTL,
                command: AndroidSettingsKey.FORCE_RTL,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_CHANGE_GPU_RENDERING,
                command: AndroidSettingsKey.GPU_RENDERING,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_GPU_RENDERING_TYPE,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },
        ];
    }

    public static getAvailableCommands(): Array<string> {
        return [
            "",
            "Enable / Disable Developer Options",
            "Enable / Disable USB Debugging",
            "Enable / Disable Strict Mode",
            "Enable / Disable GPU Overdraw",
            "Enable / Disable Hardware Acceleration",
            "Enable / Disable GPU View Updates",
            "Show / Hide Layout Bounds",
            "Show / Hide Touches",
            "Show / Hide Pointer Location",
            "Change GPU Rendering (OpenGL, Vulkan)",
            "",
        ];
    }

}
