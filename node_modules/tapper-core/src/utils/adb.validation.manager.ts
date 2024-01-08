import { exec } from 'child_process';

export class AdbValidationManager {

    // @ts-ignore
    static async checkAdbInstallation(): Promise<boolean> {
        const command = 'adb version';

        exec(command, (error, stdout, stderr) => {
            if (stdout || stdout.includes('Android Debug Bridge')) {
                console.log("")
                console.log("======= ADB Installed")
                console.log("")
                return Promise.resolve(true);
            }

            if (error) {
                console.log("")
                console.log("======= ADB Not Installed")
                console.log("")
                return Promise.resolve(false);
            }

            if (stderr) {
                console.log("")
                console.log("======= ADB Not Installed")
                console.log("")
                return Promise.resolve(false);
            }

            const adbVersionMatch = stdout.match(/version (\d+\.\d+\.\d+)/);

            if (adbVersionMatch && adbVersionMatch[1]) {
                const adbVersion = adbVersionMatch[1];
                console.log(`ADB Installed on Your Device. Version: ${adbVersion}`);
                return Promise.resolve(true);
            } else {
                console.log("")
                console.log("======= ADB Not Installed")
                console.log("")
                return Promise.resolve(false);
            }
        });
    }

}