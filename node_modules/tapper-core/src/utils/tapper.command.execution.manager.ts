import { exec } from 'child_process';
import {TapperDeviceInfoManager} from "../commands/tapper.device.info.manager.js";
import {DeviceInfoCommand} from "../models/device.info.command.js";

/**
 * Any Shell Command Should be Executed Here In This File
 * Helpful in Debug, if you want to See Which Query Submitted and How Add a breakpoint Here
 */
export class TapperCommandExecutionManager {

    // @ts-ignore
    public static onExecuteCommandString(command: string) {
        exec(command, (error, stdout: string, stderr: string) => {
            if (error) {
                console.log("Error While Executing the Command ... " + error.message)
                return
            }

            console.log("Command To Execute: " + command)
            console.log(stdout)
        });
    }

    // @ts-ignore
    public static onExecuteCommandByDeviceType(command: DeviceInfoCommand) {
        exec(command.command, (error, stdout: string, stderr: string) => {
            if (error) {
                console.log("Error While Executing the Command ... " + error.message)
                return
            }

            const output = stdout.trim().replace("\n", "").replace("\t", "")
            if (output) {
                console.log(command.name + "=" + output)
            }

        });
    }

    public static getRandomCoordinates(screenWidth: number, screenHeight: number): { x: number, y: number } {
        const minX = 0;
        const maxX = screenWidth;
        const minY = 0;
        const maxY = screenHeight;

        const randomX = Math.floor(Math.random() * (maxX - minX + 1)) + minX;
        const randomY = Math.floor(Math.random() * (maxY - minY + 1)) + minY;

        return { x: randomX, y: randomY };
    }

    public static sleep(ms: number): Promise<void> {
        return new Promise(resolve => setTimeout(resolve, ms));
    }

    public static onExecuteCommandStringWithoutInput(command: string) {
        exec(command, (error, stdout: string, stderr: string) => {
            if (error) {
                console.log("Error While Executing the Command ... " + error.message)
                return
            }
        });
    }

}
