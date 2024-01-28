import {TapperArgumentEntity} from "../models/tapper.argument.entity.js";
import {TapperOptionPickerEntity} from "../models/tapper.option.picker.entity.js";
import inquirer from "inquirer";
import {TapperCommandsExecutionManager} from "../tapper.commands.execution.manager.js";
import {CommandQuestionEntity} from "../models/command.question.entity.js";
import {AndroidGeneralSettingsKey} from "../models/android.general.settings.key.js";
import {AndroidSettingsKey} from "../models/android.settings.key.js";
import {AndroidTestingOptionsType} from "../models/android.testing.options.type.js";

/**
 * This File has the Questions and Commands, Validations to Execute
 * Any Dropdown, Question, Validation on Input Should be in this File
 */
export class TapperCommandsManager {

    // View Commands
    /**
     * This Section is the Main Section for Direct Commands Outside CLI
     * If you want To Execute The CLI With a Direct Command Use These Options
     */
    public static VIEW_DEVELOPER_OPTIONS_COMMAND = "developer-options-view";
    public static VIEW_TESTING_OPTIONS_COMMAND = "testing-options-view";
    public static VIEW_DEVICE_INFO = "view-device-info";
    public static VALIDATE_ADB_INSTALLATION_COMMAND = "adb-validate";
    public static HELP_COMMAND = "help";

    // Execution Commands
    /**
     * This Section is the Main Section for Direct Commands Outside CLI
     * If you want To Execute The CLI With a Direct Command Use These Options
     */
    public static EXECUTE_DEVELOPER_OPTION_COMMAND = "execute-dev-option";
    public static EXECUTE_GENERAL_OPTIONS_COMMAND = "execute-general-options";
    public static EXECUTE_TESTING_EVENTS_COMMAND = "execute-testing-events";
    public static EXECUTE_ANDROID_MONKEY_TESTING_COMMAND = "execute-monkey-testing";
    public static EXECUTE_AUTO_FLOW_TESTING_COMMAND = "execute-auto-flow";

    static async onRepeatAskCommandsQuestion() {
        const options: Array<string> = [];
        const commandsList = TapperCommandsManager.getDropdownOptionsList();
        for (let index = 0; index < commandsList.length; index++) {
            const command = commandsList[index];
            if (command) {
                options.push(command.name);
            }
        }


        const question = {
            type: 'list',
            name: 'selectedOption',
            message: 'Please select an Command To Start:',
            choices: options,
        };

        const answers = await inquirer.prompt([question]);
        const selectedCommand = commandsList.filter((item) => {
            return item.name === answers.selectedOption
        });

        if (selectedCommand && selectedCommand.length > 0) {
            TapperCommandsExecutionManager.onExecuteCommand(selectedCommand[0]?.command ?? "");
        }
    }

    static async  onAskStringInputQuestion(questionName: string): Promise<string> {
        const question = {
            type: 'input',
            name: 'question',
            message: questionName,
        };

        const answer = await inquirer.prompt([question]);
        return answer.question;
    }

    static async onAskCommandQuestions(questions: Array<CommandQuestionEntity<AndroidGeneralSettingsKey>>): Promise<CommandQuestionEntity<AndroidGeneralSettingsKey> | undefined> {
        const options: Array<string> = questions.map((item) => {
            return item.name
        });

        const answer = await this.getCommandsQuestionResponseByString(options);
        const selectedCommand = questions.filter((item) => {
            return item.name === answer
        });

        return Promise.resolve(selectedCommand[0]);
    }

    static async onAskCommandByTestingQuestions(questions: Array<CommandQuestionEntity<AndroidTestingOptionsType>>): Promise<CommandQuestionEntity<AndroidTestingOptionsType> | undefined> {
        const options: Array<string> = questions.map((item) => {
            return item.name
        });

        const answer = await this.getCommandsQuestionResponseByString(options);
        const selectedCommand = questions.filter((item) => {
            return item.name === answer
        });

        return Promise.resolve(selectedCommand[0]);
    }

    static async onAskCommandSettingsQuestions(questions: Array<CommandQuestionEntity<AndroidSettingsKey>>): Promise<CommandQuestionEntity<AndroidSettingsKey> | undefined> {
        const options: Array<string> = questions.map((item) => {
            return item.name
        });

        const answer = await this.getCommandsQuestionResponseByString(options);
        const selectedCommand = questions.filter((item) => {
            return item.name === answer
        });

        return Promise.resolve(selectedCommand[0]);
    }

    private static async getCommandsQuestionResponseByString(questions: Array<string>): Promise<string> {
        const question = {
            type: 'list',
            name: 'selectedOption',
            message: 'Please select an Command To Start:',
            choices: questions,
        };

        const answers = await inquirer.prompt([question]);
        return answers.selectedOption;
    }

    public static getApplicationArgsOptions(): Array<TapperArgumentEntity> {
        const options: Array<TapperArgumentEntity> = [];

        // Add Execution Commands
        options.push(...this.getExecutionCommands());

        // Add View Commands
        options.push(...this.getViewCommands());

        return options;
    }

    private static getExecutionCommands(): Array<TapperArgumentEntity> {
        return [
            {
                command: TapperCommandsManager.EXECUTE_DEVELOPER_OPTION_COMMAND,
                description: "Toggle Developer Options Attributes To be Enabled / Disabled",
                options: undefined,
                args: [
                    {
                        name: "<string>",
                        description: "Name of the Feature"
                    },
                    {
                        name: "<string>",
                        description: "Toggle On or Off"
                    }
                ]
            },
            {
                command: TapperCommandsManager.EXECUTE_GENERAL_OPTIONS_COMMAND,
                description: "Toggle General Device Options To be Enabled / Disabled",
                options: undefined,
                args: [
                    {
                        name: "<string>",
                        description: "Name of the Feature"
                    },
                    {
                        name: "<string>",
                        description: "Toggle On or Off"
                    }
                ]
            },
            {
                command: TapperCommandsManager.EXECUTE_TESTING_EVENTS_COMMAND,
                description: "Start Several Testing Events Like Tap, Double Tap, Scroll",
                args: [
                    {
                        name: "<string>",
                        description: "Name of the Feature"
                    }
                ],
                options: [
                    {
                        name: "<Start Point, End Point>",
                        description: "Coordinates of the Start and End Point to Do the Scroll"
                    }
                ]
            },
            {
                command: TapperCommandsManager.EXECUTE_ANDROID_MONKEY_TESTING_COMMAND,
                description: "Start Native Monkey Testing With Clicks Interval",
                options: undefined,
                args: [
                    // TODO: Fill This Block
                ]
            },
            {
                command: TapperCommandsManager.EXECUTE_AUTO_FLOW_TESTING_COMMAND,
                description: "Start Custom Auto Flow with Application Bounds and Interval for Random Clicks",
                options: undefined,
                args: [
                    {
                        name: "<Timeout Number>",
                        description: "Start Testing on Random Clicks Within Milliseconds Number"
                    }
                ]
            },
            {
                command: TapperCommandsManager.VIEW_DEVICE_INFO,
                description: "View Device Info",
                options: undefined,
                args: [

                ]
            },
        ];
    }

    private static getViewCommands(): Array<TapperArgumentEntity> {
        return [
            {
                command: TapperCommandsManager.VIEW_DEVELOPER_OPTIONS_COMMAND,
                description: "List All Available Commands That can be Executed on Connected Android Device from Developer Options",
                args: undefined,
                options: undefined,
            },
            {
                command: TapperCommandsManager.VIEW_TESTING_OPTIONS_COMMAND,
                description: "List All Available Commands That can be Executed to Test Apps On Connected Devices",
                args: undefined,
                options: undefined,
            },
            {
                command: TapperCommandsManager.VALIDATE_ADB_INSTALLATION_COMMAND,
                description: "Validate That Android Debug Bridge Installed on Your Device",
                args: undefined,
                options: undefined,
            },
            {
                command: TapperCommandsManager.HELP_COMMAND,
                description: "Show Examples On CLI Usage on all Options",
                args: undefined,
                options: undefined,
            }
        ]
    }

    public static getDropdownOptionsList(): Array<TapperOptionPickerEntity> {
        return [
            {
                name: "Control Developer Options",
                command: TapperCommandsManager.EXECUTE_DEVELOPER_OPTION_COMMAND
            },
            {
                name: "Control General Device Options",
                command: TapperCommandsManager.EXECUTE_GENERAL_OPTIONS_COMMAND
            },
            {
                name: "Execute Testing Commands",
                command: TapperCommandsManager.EXECUTE_TESTING_EVENTS_COMMAND
            },
            {
                name: "Execute Android Monkey Testing",
                command: TapperCommandsManager.EXECUTE_ANDROID_MONKEY_TESTING_COMMAND
            },
            {
                name: "Execute Auto Testing Flow",
                command: TapperCommandsManager.EXECUTE_AUTO_FLOW_TESTING_COMMAND
            },
            {
                name: "View Device Info",
                command: TapperCommandsManager.VIEW_DEVICE_INFO
            },
            {
                name: "View Developer Options",
                command: TapperCommandsManager.VIEW_DEVELOPER_OPTIONS_COMMAND
            },
            {
                name: "View Testing Options",
                command: TapperCommandsManager.VIEW_TESTING_OPTIONS_COMMAND
            },
            {
                name: "Validate ADB Installation",
                command: TapperCommandsManager.VALIDATE_ADB_INSTALLATION_COMMAND
            },
            {
                name: "Help",
                command: TapperCommandsManager.HELP_COMMAND
            }
        ];
    }
}