import { AndroidSettingsKey } from "../models/android.settings.key.js";
import {AndroidGeneralSettingsKey} from "../models/android.general.settings.key.js";
import {AndroidTestingOptionsType} from "../models/android.testing.options.type.js";

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
        this.queryString += " " + value;
        return this;
    }

    public getQuery(): string {
        return this.queryString;
    }
}
