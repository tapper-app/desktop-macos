import {TapperCommandsManager} from "../utils/tapper.commands.manager.js";
import {CommandQuestionEntity} from "../models/command.question.entity.js";
import {AndroidSettingsKey} from "../models/android.settings.key.js";
import {TapperCommandQueryBuilder} from "./tapper.command.query.builder.js";
import {TapperCommandExecutionManager} from "../utils/tapper.command.execution.manager.js";
import {AndroidGeneralSettingsKey} from "../models/android.general.settings.key.js";

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
                command: command
            }, inputAnswer)
        }
    }

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

    public static onExecuteCommand(command: CommandQuestionEntity<AndroidSettingsKey>, inputOption: string) {
        const commandToExecute = new TapperCommandQueryBuilder()
            .setShellCommand()

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
            const isYesAnswer = inputOption.toLowerCase().includes('y')
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

    private static getCommandsQuestions(): Array<CommandQuestionEntity<AndroidSettingsKey>> {
        return [
            {
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_GPU_OVERDRAW,
                command: AndroidSettingsKey.GPU_OVERDRAW,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_LAYOUT_BOUNDS,
                command: AndroidSettingsKey.LAYOUT_BOUNDS,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_TOUCHES,
                command: AndroidSettingsKey.SHOW_TOUCHES,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_POINTER_LOCATION,
                command: AndroidSettingsKey.SHOW_POINTER_LOCATION,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_STRICT_MODE,
                command: AndroidSettingsKey.STRICT_MODE,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_CHANGE_GPU_VIEW_UPDATES,
                command: AndroidSettingsKey.VIEW_UPDATES,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_DEVELOPER_OPTIONS,
                command: AndroidSettingsKey.DEVELOPER_OPTIONS,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_USB_DEBUGGING,
                command: AndroidSettingsKey.USB_DEBUGGING_V2,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_HARDWARE_ACCELERATION,
                command: AndroidSettingsKey.HARDWARE_ACCELERATION,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_TOGGLE_FORCE_RTL,
                command: AndroidSettingsKey.FORCE_RTL,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false
            },{
                name: TapperDeveloperOptionsCommandsManager.QUESTION_CHANGE_GPU_RENDERING,
                command: AndroidSettingsKey.GPU_RENDERING,
                inputQuestion: TapperDeveloperOptionsCommandsManager.QUESTION_GPU_RENDERING_TYPE,
                isDirectCommand: false
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
