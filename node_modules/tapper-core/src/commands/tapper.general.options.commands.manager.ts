import {CommandQuestionEntity} from "../models/command.question.entity.js";
import {AndroidGeneralSettingsKey} from "../models/android.general.settings.key.js";
import {TapperCommandsManager} from "../utils/tapper.commands.manager.js";
import {TapperCommandQueryBuilder} from "./tapper.command.query.builder.js";
import {TapperCommandExecutionManager} from "../utils/tapper.command.execution.manager.js";

/**
 * This File is the Manager on General Options (Device Settings Category)
 * Here you will see 2 Ways of Executing the Commands
 * 1. By Picking the Options from CLI
 * 2. Run the Commands Directly (Direct Command or Desktop App)
 *
 * The File Separated into 3 Components of the Variables
 * 1. Question Content
 * 2. Dropdown Title
 * 3. Direct Command Key
 *
 * This Category Commands Should Always Support General Options Events Only
 * 1. Device Events
 * 2. Device Buttons
 * 3. General Launcher Events
 */
export class TapperGeneralOptionsCommandsManager {

    // Sublist Questions
    private static QUESTION_ENABLED_DISABLED = "question_enabled_disabled";
    private static QUESTION_INSTALL_BY_PATH = "install_by_path";
    private static QUESTION_UN_INSTALL_BY_PACKAGE_NAME = "uninstall_by_package_name";
    private static QUESTION_ADD_PACKAGE_NAME = "add_package_name";
    private static QUESTION_ADD_PHONE_NUMBER = "add_phone_number";
    private static QUESTION_ADD_URL = "add_url";
    private static QUESTION_FILE_PATH = "save_path";

    // CLI Actions List - SubList from General Options
    private static QUESTION_TOGGLE_DARK_MODE = "Change Dark Mode";
    private static QUESTION_POWER_SAVING_MODE = "Change Power Saving Mode";
    private static QUESTION_WIFI = "Change Wifi";
    private static QUESTION_SHOW_CONNECTED_DEVICES = "Get Connected Devices";
    private static QUESTION_SHOW_CONNECTED_DEVICES_DETAILS = "Get Connected Devices With full Information";
    private static QUESTION_INSTALL_APK = "Install Apk on Device";
    private static QUESTION_UN_INSTALL_APK = "UnInstall Apk on Device";
    private static QUESTION_REBOOT = "Reboot Device";
    private static QUESTION_REMOVE_PERMISSIONS = "Remove Permissions By Package Name";
    private static QUESTION_HOME_BUTTON_CLICK = "Click On Home Button";
    private static QUESTION_CALL_PHONE_NUMBER = "Call By Phone Number";
    private static QUESTION_OPEN_URL = "Open Url";
    private static QUESTION_SCREENSHOT = "Take a Screenshot";
    private static QUESTION_OPEN_APP = "Open Application By Package Name";

    // Direct Executable Actions
    private static EXECUTION_DARK_MODE = "dark-mode";
    private static EXECUTION_POWER_SAVING_MODE = "power";
    private static EXECUTION_WIFI_MODE = "wifi";
    private static EXECUTION_CONNECTED_DEVICES = "device";
    private static EXECUTION_CONNECTED_DEVICES_DETAILS = "device-details";
    private static EXECUTION_INSTALL_APK = "install";
    private static EXECUTION_UN_INSTALL = "delete";
    private static EXECUTION_REBOOT = "restart";
    private static EXECUTE_REMOVE_PERMISSIONS = "remove-permissions";
    private static EXECUTE_HOME_CLICK = "home-tap";
    private static EXECUTE_PHONE_NUMBER = "call-phone";
    private static EXECUTE_OPEN_URL = "open-url";
    private static EXECUTE_SCREENSHOT = "screenshot";
    private static EXECUTE_OPEN_APP = "open-app";

    /**
     * Use This Command Only when You want to Execute the Command Directly from Outside CLI
     * When you Run the CLI With Arguments Directly into this Category
     * Or When you Use The Desktop App Version That Use this Function Directly With All Attributes
     *
     * Example
     * @param attributes execute-general-options overdraw y
     * Params Description
     * [Category] [Option Key] [Answer]
     */
    public static onExecuteCommandByAttributes(attributes: Array<string>) {
        let command: AndroidGeneralSettingsKey | null = null;
        let isDirectCommand = false;
        let isPackageManagerShellCommand: boolean = false;
        const inputAnswer = attributes[attributes.length - 1]?.trim() ?? "";

        if (attributes.includes(TapperGeneralOptionsCommandsManager.EXECUTION_DARK_MODE)) {
            command = AndroidGeneralSettingsKey.ToggleDarkMode;
        }

        if (attributes.includes(TapperGeneralOptionsCommandsManager.EXECUTION_POWER_SAVING_MODE)) {
            command = AndroidGeneralSettingsKey.PowerSavingMode;
        }

        if (attributes.includes(TapperGeneralOptionsCommandsManager.EXECUTION_WIFI_MODE)) {
            command = AndroidGeneralSettingsKey.ToggleWifi;
        }

        if (attributes.includes(TapperGeneralOptionsCommandsManager.EXECUTION_CONNECTED_DEVICES)) {
            command = AndroidGeneralSettingsKey.Devices;
        }

        if (attributes.includes(TapperGeneralOptionsCommandsManager.EXECUTION_CONNECTED_DEVICES_DETAILS)) {
            command = AndroidGeneralSettingsKey.DetailedDevices;
        }

        if (attributes.includes(TapperGeneralOptionsCommandsManager.EXECUTION_INSTALL_APK)) {
            command = AndroidGeneralSettingsKey.InstallApk;
        }

        if (attributes.includes(TapperGeneralOptionsCommandsManager.EXECUTION_UN_INSTALL)) {
            command = AndroidGeneralSettingsKey.UnInstallApk;
        }

        if (attributes.includes(TapperGeneralOptionsCommandsManager.EXECUTION_REBOOT)) {
            command = AndroidGeneralSettingsKey.Reboot;
        }

        if (attributes.includes(TapperGeneralOptionsCommandsManager.EXECUTE_REMOVE_PERMISSIONS)) {
            command = AndroidGeneralSettingsKey.RemovePermissions;
            isDirectCommand = true;
            isPackageManagerShellCommand = true;
        }

        if (attributes.includes(TapperGeneralOptionsCommandsManager.EXECUTE_HOME_CLICK)) {
            command = AndroidGeneralSettingsKey.HomeButton;
            isDirectCommand = true;
            isPackageManagerShellCommand = false;
        }

        if (attributes.includes(TapperGeneralOptionsCommandsManager.EXECUTE_PHONE_NUMBER)) {
            command = AndroidGeneralSettingsKey.PhoneNumber;
            isDirectCommand = true;
            isPackageManagerShellCommand = false;
        }

        if (attributes.includes(TapperGeneralOptionsCommandsManager.EXECUTE_OPEN_URL)) {
            command = AndroidGeneralSettingsKey.OpenUrl;
            isDirectCommand = true;
            isPackageManagerShellCommand = false;
        }

        if (attributes.includes(TapperGeneralOptionsCommandsManager.EXECUTE_SCREENSHOT)) {
            command = AndroidGeneralSettingsKey.Screenshot;
            isDirectCommand = true;
            isPackageManagerShellCommand = false;
        }

        if (attributes.includes(TapperGeneralOptionsCommandsManager.EXECUTE_OPEN_APP)) {
            command = AndroidGeneralSettingsKey.OpenApp;
            isDirectCommand = true;
            isPackageManagerShellCommand = false;
        }

        if (command != null) {
            this.onExecuteCommand({
                name: "",
                isDirectCommand: isDirectCommand,
                inputQuestion: "",
                command: command,
                isShellPackageManagerCommand: isPackageManagerShellCommand
            }, inputAnswer)
        }
    }

    /**
     * This Function is to Show The Commands List and Wait Until User Pick the Option
     * After Picking the Option we See if the Command Has a Question to ASK
     * Then Move to (onExecuteDeveloperCommandSubmissionQuestion)
     */
    public static onExecuteGeneralOptionsCommands() {
        const questions = this.getCommandsQuestions();
        TapperCommandsManager.onAskCommandQuestions(questions)
            .then((selectedCommand) => {
                if (selectedCommand) {
                    this.onExecuteGeneralCommandSubmissionQuestion(selectedCommand);
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
    private static onExecuteGeneralCommandSubmissionQuestion(command: CommandQuestionEntity<AndroidGeneralSettingsKey>) {
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

    private static getQuestionNameByKey(key: string): string {
        if (key === TapperGeneralOptionsCommandsManager.QUESTION_ENABLED_DISABLED) {
            return "Do you want To Enable or Disable the Feature ? (y, n)";
        } else if (key === TapperGeneralOptionsCommandsManager.QUESTION_INSTALL_BY_PATH) {
            return "Insert The Full Path of the Apk File ?";
        } else if (key === TapperGeneralOptionsCommandsManager.QUESTION_UN_INSTALL_BY_PACKAGE_NAME) {
            return "Write the Package Name That want to Uninstall from the Device ?";
        } else if (key === TapperGeneralOptionsCommandsManager.QUESTION_ADD_PACKAGE_NAME) {
            return "Write the Package Name That want to Remove Permissions To ?";
        } else if (key === TapperGeneralOptionsCommandsManager.QUESTION_ADD_PHONE_NUMBER) {
            return "Write the Phone Number (+123456789) ?";
        } else if (key === TapperGeneralOptionsCommandsManager.QUESTION_ADD_URL) {
            return "Write the Url (https://example.com) ?";
        } else if (key === TapperGeneralOptionsCommandsManager.QUESTION_FILE_PATH) {
            return "Write Where you want to Save the Screenshot (Path (/sdcard/screenshot.png)) ?";
        } else {
            return "";
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
    public static onExecuteCommand(command: CommandQuestionEntity<AndroidGeneralSettingsKey>, inputOption: string) {
        if (inputOption && command.inputQuestion && command.inputQuestion === TapperGeneralOptionsCommandsManager.QUESTION_ENABLED_DISABLED) {
            if (inputOption.toLowerCase() !== "y" && inputOption.toLowerCase() !== "n") {
                console.log("Answer Should be y,n Only")
                return
            }
        }

        if (command.isDirectCommand) {
            const commandToExecute = new TapperCommandQueryBuilder();
            if (command.isShellPackageManagerCommand) {
                commandToExecute.setShellPm()
                    .setGeneralSettingsKey(command.command)

                if (inputOption) {
                    commandToExecute
                        .setPackageParam()
                        .setCustomValue(inputOption)
                }
            } else {
                commandToExecute.setGeneralSettingsKey(command.command)

                if (inputOption) {
                    commandToExecute.setCustomValue(inputOption)
                }
            }

            let queryToExecute = commandToExecute.getQuery();
            if (command.command == AndroidGeneralSettingsKey.OpenApp) {
                queryToExecute = queryToExecute.replace("{Package}", inputOption)
            }

            TapperCommandExecutionManager.onExecuteCommandString(queryToExecute);
        } else {
            const commandToExecute = new TapperCommandQueryBuilder()
                .setShellCommand()
                .setSettings()
                .put()
                .setGlobal()
                .setGeneralSettingsKey(command.command);

            if (inputOption.toLowerCase() === 'y') {
                if (command.command == AndroidGeneralSettingsKey.ToggleDarkMode) {
                    commandToExecute.setEnabledByNumbersNextLevel(true)
                } else {
                    commandToExecute.setEnabledByNumbers(true)
                }
            } else {
                if (command.command == AndroidGeneralSettingsKey.ToggleDarkMode) {
                    commandToExecute.setEnabledByNumbersNextLevel(false)
                } else {
                    commandToExecute.setEnabledByNumbers(false)
                }
            }

            TapperCommandExecutionManager.onExecuteCommandString(commandToExecute.getQuery());
        }

        if (command.command == AndroidGeneralSettingsKey.UnInstallApk) {
            TapperCommandExecutionManager.onExecuteCommandString("adb shell pm uninstall " + inputOption);
            TapperCommandExecutionManager.onExecuteCommandString("adb shell pm clear  " + inputOption);
        }
    }

    /**
     * Used In CLI Options Only, Its Displaying the List of Options
     * When you Pick this Category
     * @private
     */
    private static getCommandsQuestions(): Array<CommandQuestionEntity<AndroidGeneralSettingsKey>> {
        return [
            {
                name: TapperGeneralOptionsCommandsManager.QUESTION_TOGGLE_DARK_MODE,
                command: AndroidGeneralSettingsKey.ToggleDarkMode,
                inputQuestion: TapperGeneralOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },
            {
                name: TapperGeneralOptionsCommandsManager.QUESTION_POWER_SAVING_MODE,
                command: AndroidGeneralSettingsKey.PowerSavingMode,
                inputQuestion: TapperGeneralOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },
            {
                name: TapperGeneralOptionsCommandsManager.QUESTION_WIFI,
                command: AndroidGeneralSettingsKey.ToggleWifi,
                inputQuestion: TapperGeneralOptionsCommandsManager.QUESTION_ENABLED_DISABLED,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },
            {
                name: TapperGeneralOptionsCommandsManager.QUESTION_SHOW_CONNECTED_DEVICES,
                command: AndroidGeneralSettingsKey.Devices,
                inputQuestion: undefined,
                isDirectCommand: true,
                isShellPackageManagerCommand: false
            },
            {
                name: TapperGeneralOptionsCommandsManager.QUESTION_SHOW_CONNECTED_DEVICES_DETAILS,
                command: AndroidGeneralSettingsKey.DetailedDevices,
                inputQuestion: undefined,
                isDirectCommand: true,
                isShellPackageManagerCommand: false
            },
            {
                name: TapperGeneralOptionsCommandsManager.QUESTION_INSTALL_APK,
                command: AndroidGeneralSettingsKey.InstallApk,
                inputQuestion: TapperGeneralOptionsCommandsManager.QUESTION_INSTALL_BY_PATH,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },
            {
                name: TapperGeneralOptionsCommandsManager.QUESTION_UN_INSTALL_APK,
                command: AndroidGeneralSettingsKey.UnInstallApk,
                inputQuestion: TapperGeneralOptionsCommandsManager.QUESTION_UN_INSTALL_BY_PACKAGE_NAME,
                isDirectCommand: false,
                isShellPackageManagerCommand: false
            },
            {
                name: TapperGeneralOptionsCommandsManager.QUESTION_REBOOT,
                command: AndroidGeneralSettingsKey.Reboot,
                inputQuestion: undefined,
                isDirectCommand: true,
                isShellPackageManagerCommand: false
            },
            {
                name: TapperGeneralOptionsCommandsManager.QUESTION_REMOVE_PERMISSIONS,
                command: AndroidGeneralSettingsKey.RemovePermissions,
                inputQuestion: TapperGeneralOptionsCommandsManager.QUESTION_ADD_PACKAGE_NAME,
                isDirectCommand: true,
                isShellPackageManagerCommand: true
            },
            {
                name: TapperGeneralOptionsCommandsManager.QUESTION_HOME_BUTTON_CLICK,
                command: AndroidGeneralSettingsKey.HomeButton,
                inputQuestion: undefined,
                isDirectCommand: true,
                isShellPackageManagerCommand: false
            },
            {
                name: TapperGeneralOptionsCommandsManager.QUESTION_CALL_PHONE_NUMBER,
                command: AndroidGeneralSettingsKey.PhoneNumber,
                inputQuestion: TapperGeneralOptionsCommandsManager.QUESTION_ADD_PHONE_NUMBER,
                isDirectCommand: true,
                isShellPackageManagerCommand: false
            },
            {
                name: TapperGeneralOptionsCommandsManager.QUESTION_OPEN_URL,
                command: AndroidGeneralSettingsKey.OpenUrl,
                inputQuestion: TapperGeneralOptionsCommandsManager.QUESTION_ADD_URL,
                isDirectCommand: true,
                isShellPackageManagerCommand: false
            },
            {
                name: TapperGeneralOptionsCommandsManager.QUESTION_SCREENSHOT,
                command: AndroidGeneralSettingsKey.Screenshot,
                inputQuestion: TapperGeneralOptionsCommandsManager.QUESTION_FILE_PATH,
                isDirectCommand: true,
                isShellPackageManagerCommand: false
            },
            {
                name: TapperGeneralOptionsCommandsManager.QUESTION_OPEN_APP,
                command: AndroidGeneralSettingsKey.OpenApp,
                inputQuestion: TapperGeneralOptionsCommandsManager.QUESTION_ADD_PACKAGE_NAME,
                isDirectCommand: true,
                isShellPackageManagerCommand: false
            }
        ];
    }

    public static getAvailableCommands(): Array<string> {
        return [
            "",
            "Enable / Disable Dark Mode",
            "Enable / Disable WIFI",
            "Enable / Disable Power Saving Mode",
            "Get Connected Devices",
            "Get Connected Devices With Full Information",
            "Install Apk By Path",
            "Uninstall Apk By Package Name",
            "Reboot Device",
            "Remove Permissions By Package Name",
            "Click On Home Button",
            "Call Phone Number",
            "Open Url",
            "Take Screenshot",
            "Open Application By Package Name",
            "",
        ];
    }
}
