/**
 * Created by rockyl on 2020-07-27.
 */

import {NativeModules, NativeEventEmitter,} from 'react-native';

const AppInterface = NativeModules.AppInterface;
const AppInterfaceEmitter = new NativeEventEmitter(AppInterface);

AppInterfaceEmitter.addListener('notification', async ({type}) => {
	console.log('notification:', type);

	switch (type) {
		case 'windowShouldClose':
			if (!windowShouldCloseCallback || await windowShouldCloseCallback()) {
				AppInterface.closeWindow();
			}
			break;
	}
});

let windowShouldCloseCallback;

export async function windowShouldClose(callback: Function) {
	windowShouldCloseCallback = callback;
}

type CURSOR_TYPES =
	'arrow' |
	'IBeam' |
	'pointingHand' |
	'closedHand' |
	'openHand' |
	'resizeLeft' |
	'resizeRight' |
	'resizeLeftRight' |
	'resizeUp' |
	'resizeDown' |
	'resizeUpDown' |
	'crosshair' |
	'disappearingItem' |
	'operationNotAllowed' |
	'dragLink' |
	'dragCopy' |
	'contextualMenu' |
	'IBeamCursorForVertical';

export function setCursor(type: CURSOR_TYPES) {
	AppInterface.setCursor(type);
}
