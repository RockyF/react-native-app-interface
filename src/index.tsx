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

