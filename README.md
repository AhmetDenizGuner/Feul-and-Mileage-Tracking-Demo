- This application was created on the ethereum platform in solidty version 0.5.2.
- You can compile and run the application in your browser at https://remix.ethereum.org/
- This implementation does not exactly match the model we developed. It is a manually operated simulation prepared just to show you how the detection process will work.
- When a vehicle is registered it is saved as vast status off. It changes automatically every time you log !!!!!
- All inputs are taken as integers.

State Variables:
- Car:It keeps the mileage and fuel information of the vehicles registered in the system, and there are also values that indicate that there is an improper situation in the vehicle.
- Fix Millage: It keeps the amount of manipulation performed on vehicles with mileage manipulation.
- owner: The person who deployed the contract is the system administrator. It adds tools to the system and detects and corrects manipulations.

Functions:
- Constructor: It starts the contract and defines the person who deployed the application as the owner.
- Add Car: Used only by the owner. It is used to register new vehicles in the system. Ethereum address is used as car id. In addition, the current fuel and mileage information of the vehicle is entered as a parameter.
- Add Log: Used only by the car. It is a function that is used to manually send logs to understand how errors are detected in the logs from vehicles. It detects fuel theft and mileage change in case of engine opening.
- Unblock Car: Used only by the owner. Vehicles with detected mileage manipulation are blocked. From this moment on, logs from the vehicle are not accepted. If the owner calls this function, the mileage of the vehicle is corrected and the blocking is removed.
- Check Fuel Cheat: Used only by the owner. When fuel manipulation is detected in a vehicle, it is not blocked from the network, but marked. To see this sign, the owner queries these functions.
- Fix Fuel Cheat: Used only by the owner. After the necessary actions are taken for the vehicle with fuel manipulation, this unmarking of the vehicle is removed with this function.