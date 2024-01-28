#!/usr/bin/env node

// Libraries Used in Cli
import figlet from 'figlet';
import inquirer from 'inquirer';
import { program } from 'commander';
import { TapperInfo } from "./utils/tapper.info.js";
import { TapperCommandsManager } from "./utils/tapper.commands.manager.js";
import { TapperCommandsExecutionManager } from "./tapper.commands.execution.manager.js";

/**
 * This is the Main File for Tapper
 * The Start Point in the Application
 * Here We Print the Header Logs Always With the CLI Version
 * After it, We See if the CLI Started Only or Started with an Attributes
 * If the Cli Started without Arguments We Will Print a Dropdown Options of the Available Commands
 * If the Cli Started With Args We Will Start Execution Directly
 */
// Start Tapper Initialization in Terminal
console.log("==========================================================")
console.log("===== Welcome To Tapper CLI")
console.log("==========================================================")
console.log(figlet.textSync("Tapper CLI"));
console.log("==========================================================")
console.log("Welcome To Android Testing CLI Platform")
console.log("CLI Version : " + TapperInfo.CLI_VERSION)
console.log("CLI Supported Platforms : " + TapperInfo.CLI_SUPPORTED_PLATFORMS)
console.log("CLI Homepage : " + TapperInfo.CLI_HOMEPAGE)
console.log("CLI Source Code : " + TapperInfo.CLI_SOURCE_CODE)
console.log("==========================================================")
console.log("Tapper CLI is the Source Code of Tapper UI Application Available on Windows, Macos, Linux")
console.log("Tapper Can Interact With Android Devices to Execute Several Functions")
console.log("You can Use it Directly from Terminal or GUI Applications")
console.log("")

// Initialize Commander To Show Commands
program
    .name('Tapper')
    .description('Cli To Interact With ADB Android Devices For Developers')
    .version(TapperInfo.CLI_VERSION);

// Add Available Project Commands On CLI Options and Arguments
const cliOptions = TapperCommandsManager.getApplicationArgsOptions();
for (let optionIndex = 0; optionIndex < cliOptions.length; optionIndex++) {
    const option = cliOptions[optionIndex];
    if (option) {
        const commandInstance = program.command(option.command).description(option.description)
        if (option.args != undefined) {
            for (let optionArgument = 0; optionArgument < option.args.length; optionArgument++) {
                const argumentToShow = option.args[optionArgument];
                if (argumentToShow) {
                    commandInstance.argument(argumentToShow.name, argumentToShow.description)
                }
            }
        }

        if (option.options != undefined) {
            for (let optionArgument = 0; optionArgument < option.options.length; optionArgument++) {
                const argumentToShow = option.options[optionArgument];
                if (argumentToShow) {
                    commandInstance.option(argumentToShow.name, argumentToShow.description)
                }
            }
        }

        commandInstance.action((str, options) => {
            onCommandClick(option.command, options);
        })
    }
}

/**
 * Each Option has its Own Action Listener when The CLI Started by Arguments or Picking one Option of the Dropdown List
 * @param command - command To be Executed
 * @param options - Some Commands has Options and Arguments, Need to Pass them to Command Parser
 */
function onCommandClick(command: string, options: any) {
    console.log("Command: " + command)
    switch (command) {
        case TapperCommandsManager.HELP_COMMAND:
            TapperCommandsExecutionManager.onExecuteCommand(TapperCommandsManager.HELP_COMMAND);
            break
        case TapperCommandsManager.VIEW_DEVELOPER_OPTIONS_COMMAND:
            TapperCommandsExecutionManager.onExecuteCommand(TapperCommandsManager.VIEW_DEVELOPER_OPTIONS_COMMAND);
            break
        case TapperCommandsManager.VIEW_TESTING_OPTIONS_COMMAND:
            TapperCommandsExecutionManager.onExecuteCommand(TapperCommandsManager.VIEW_TESTING_OPTIONS_COMMAND);
            break
        case TapperCommandsManager.VALIDATE_ADB_INSTALLATION_COMMAND:
            TapperCommandsExecutionManager.onExecuteCommand(TapperCommandsManager.VALIDATE_ADB_INSTALLATION_COMMAND);
            break
        case TapperCommandsManager.VIEW_DEVICE_INFO:
            TapperCommandsExecutionManager.onExecuteCommand(TapperCommandsManager.VIEW_DEVICE_INFO);
            break
        default:
            TapperCommandsExecutionManager.onExecuteCommandWithAttributes(command, options);
    }
}

// Show Dropdown Options
async function onStartDropDownOptionsList() {
    console.log("")
    console.log("To Start Using Tapper Select one of the Following Options")
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

const isCliStartedWithArguments = process.argv != undefined && process.argv.length > 2
if (isCliStartedWithArguments) {
    const argumentsToValidate = process.argv;
    let executionKey: string | undefined = "";
    if (argumentsToValidate.length == 3) {
        executionKey = argumentsToValidate[argumentsToValidate.length - 1]
    } else {
        executionKey = argumentsToValidate[argumentsToValidate.length - 3]
    }

    console.log("Execute: " + argumentsToValidate)
    console.log("Execute: " + executionKey)
    onCommandClick(executionKey ?? "", argumentsToValidate);
} else {
    onStartDropDownOptionsList();
}
