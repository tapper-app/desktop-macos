import { exec } from 'child_process';

export class TapperCommandExecutionManager {

    // @ts-ignore
    public static onExecuteCommandString(command: string) {
        exec(command, (error, stdout: string, stderr: string) => {
            if (error) {
                console.log("Error While Executing the Command ... " + error.message)
                return
            }

            console.log(stdout)
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
