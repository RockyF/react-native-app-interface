# react-native-app-interface

App interface for rn

## Installation

```sh
npm install react-native-app-interface
or
yarn add react-native-app-interface
```

## Usage

```js
import {windowShouldClose, setCursor} from "react-native-app-interface";

// ...
//prevent close action
windowShouldClose(()=>{
	return new Promise(resolve=>{
		setTimeout(()=>{
			resolve(true);  //return true to close window, false to cancel action
		}, 1000);
	});
})

//set system cursor
setCursor('pointingHand');
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
