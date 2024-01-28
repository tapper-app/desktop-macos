import { AndroidSettingsKey } from "../models/android.settings.key.js";
import {AndroidGeneralSettingsKey} from "../models/android.general.settings.key.js";
import {AndroidTestingOptionsType} from "../models/android.testing.options.type.js";

/**
 * Tapper Command Builder Code
 * This Builder Built Like This Because The Best Approach of Generating Commands in Tapper
 * is to Do it Dynamically because not all commands has the Same Structure or Order of Params
 * For This Case To This Builder Build the Commands by Fragments
 *
 * How To Use This Builder ?
 * new TapperCommandQueryBuilder()
 *  .setShellPm()
 *  .setGeneralSettingsKey(command.command)
 *  .setPackageParam()
 *  .setCustomValue(inputOption)
 *  .getQuery()
 */
export class TapperCommandQueryBuilder {

    private queryString = "adb";

    public setSystemSettingsKey(key: AndroidSettingsKey): TapperCommandQueryBuilder {
        this.queryString += " " + key;
        return this;
    }

    public setGeneralSettingsKey(key: AndroidGeneralSettingsKey): TapperCommandQueryBuilder {
        this.queryString += " " + key;
        return this;
    }

    public setAndroidTestingKey(key: AndroidTestingOptionsType): TapperCommandQueryBuilder {
        this.queryString += " " + key;
        return this;
    }

    public setShellCommand(): TapperCommandQueryBuilder {
        this.queryString += " shell";
        return this;
    }

    public setSystem(): TapperCommandQueryBuilder {
        this.queryString += " system";
        return this;
    }

    public setProp(): TapperCommandQueryBuilder {
        this.queryString += " setprop";
        return this;
    }

    public setSettings(): TapperCommandQueryBuilder {
        this.queryString += " settings";
        return this;
    }

    public setShellPm(): TapperCommandQueryBuilder {
        this.queryString += " shell pm";
        return this
    }

    public setPackageParam(): TapperCommandQueryBuilder {
        this.queryString += " -p";
        return this;
    }

    public put(): TapperCommandQueryBuilder {
        this.queryString += " put";
        return this;
    }

    public setGlobal(): TapperCommandQueryBuilder {
        this.queryString += " global";
        return this;
    }

    public setBoolean(status: boolean): TapperCommandQueryBuilder {
        if (status) {
            this.queryString += " true";
        } else {
            this.queryString += " false";
        }
        return this;
    }

    public setEnabledByNumbers(status: boolean): TapperCommandQueryBuilder {
        if (status) {
            this.queryString += " 1";
        } else {
            this.queryString += " 0";
        }
        return this;
    }

    public setInput(): TapperCommandQueryBuilder {
        this.queryString += " input";
        return this;
    }

    public setEnabledByNumbersNextLevel(status: boolean): TapperCommandQueryBuilder {
        if (status) {
            this.queryString += " 2";
        } else {
            this.queryString += " 1";
        }
        return this;
    }

    public setCustomValue(value: string): TapperCommandQueryBuilder {
        if (value.includes("+")) {
            this.queryString += value;
        } else {
            this.queryString += " " + value;
        }

        return this;
    }

    public getQuery(): string {
        return this.queryString;
    }
}
