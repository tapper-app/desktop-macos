import {DeviceInfoCommand} from "../models/device.info.command.js";
import {TapperCommandExecutionManager} from "../utils/tapper.command.execution.manager.js";

/**
 * To Access the Device Info You Need to Execute the Commands in ADB One By One
 * and The Names is not Helpful to Read in Terminal
 * With This Manager Now We Can see A Helpful Names for The Attributes on Devices
 *
 * This manager Will Print in List The Important Attributes
 * [Key]=[Value]
 *
 * No need to Use the Query Builder Here because No Input Inside these Queries
 * All of them Just to get Info, No Submit Actions Required ...
 */
export class TapperDeviceInfoManager {

    public static onPrintDeviceInfoList() {
        for (let index = 0; index < this.getCommandsToShow().length; index++) {
            const commandInfo = this.getCommandsToShow()[index];
            if (commandInfo) {
                TapperCommandExecutionManager.onExecuteCommandByDeviceType(commandInfo);
            }
        }
    }

    private static getCommandsToShow(): Array<DeviceInfoCommand> {
        return [
            {
                name: "Release Version",
                command: "adb shell getprop ro.build.version.release"
            },
            {
                name: "Device Code",
                command: "adb get-serialno"
            },
            {
                name: "Device IMEI",
                command: "adb shell dumpsys iphonesybinfo"
            },
            {
                name: "Device Model",
                command: "adb shell getprop ro.product.model"
            },
            {
                name: "Device SDK Version",
                command: "adb shell getprop ro.vendor.build.version.sdk"
            },
            {
                name: "Android Version",
                command: "adb shell getprop ro.vendor_dlkm.build.version.release_or_codename"
            },
            {
                name: "Current Date",
                command: "adb shell getprop ro.vendor.build.date"
            },
            {
                name: "Device Cpu Type",
                command: "adb shell getprop ro.system.product.cpu.abilist"
            },
            {
                name: "Device Manufacturer",
                command: "adb shell getprop ro.soc.manufacturer"
            },
            {
                name: "Device Manufacturer Name",
                command: "adb shell getprop ro.product.vendor_dlkm.manufacturer"
            },
            {
                name: "Device Serial Number",
                command: "adb shell getprop ro.serialno"
            },
            {
                name: "Device Brand",
                command: "adb shell getprop ro.product.vendor.brand"
            },
            {
                name: "Device Model",
                command: "adb shell getprop ro.product.system_ext.model"
            },
            {
                name: "Device Language",
                command: "adb shell getprop ro.product.locale"
            },
            {
                name: "Device Min Supported SDK",
                command: "adb shell getprop ro.build.version.min_supported_target_sdk"
            },
            {
                name: "Device GPU Render Type",
                command: "adb shell getprop ro.boot.debug.hwui.renderer"
            },
            {
                name: "Device ISO Country",
                command: "adb shell getprop gsm.sim.operator.iso-country"
            },
            {
                name: "Device Name",
                command: "adb shell getprop ro.product.vendor_dlkm.nam"
            }
        ];
    }
}