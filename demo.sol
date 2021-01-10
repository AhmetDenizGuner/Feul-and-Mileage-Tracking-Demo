pragma solidity ^0.5.2;

contract FuelAndMillageTracking {
    
    struct Car {
        address carID;
        uint avarageFuel;
        uint Fuel;
        uint Millage;
        uint time;
        bool isBlocked;             // if  millage cheating detected , this value become true
        bool engineStatus;          // if engine close, status is false , unless status is true 
        bool isExist;               // this field exist for null controlling
        bool isThereFuelCheat;      
    }
    
    struct FixMillage {
        address carID;
        uint fixAmount; // When car unblocked, millage information increase as this value
    }
    
    address[] private carIDs;
    mapping  (address => Car) private carMap;
    mapping  (address => FixMillage) private fixMap;
    uint totalCar = 0;
    address private owner;
    
    // MODIFIERS
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    modifier onlyCar {
        require( carMap[msg.sender].isExist == true);
        _;
    }
    
    // FUNCTIONS
    
    constructor () public {
        owner = msg.sender;
    }
    
    function addCar ( address  adres, uint avarageFuelUssage, uint existFuel, uint mill  ) onlyOwner public {
        require(carMap[adres].isExist == false, "This car has already joined the system!!!");
        totalCar += 1;
        carIDs.push(adres);
        carMap[adres] =  Car(adres,avarageFuelUssage,existFuel,mill,now,false,false,true,false);
    }
    
    function addLog (uint mill , uint fuel) onlyCar public {
        
        require(carMap[msg.sender].isBlocked == false , "Pleae unblock this car to add log!!!");
        if (carMap[msg.sender].engineStatus) {      //engine Stop log
            carMap[msg.sender].Millage = mill;
            carMap[msg.sender].Fuel = fuel;
            carMap[msg.sender].time = now;
            carMap[msg.sender].engineStatus = false; 
        }
        else {                      //engine start log
            if (carMap[msg.sender].Millage == mill){
                if(carMap[msg.sender].Fuel > fuel) {   // There is fuel cheating;
                    carMap[msg.sender].time = now;
                    carMap[msg.sender].isThereFuelCheat = true;
                    carMap[msg.sender].engineStatus = true;
                }
                else{
                    carMap[msg.sender].time = now;
                    carMap[msg.sender].engineStatus = true;
                }
            }
            else {                      // There is millage cheating !!!
                carMap[msg.sender].time = now;
                carMap[msg.sender].isBlocked = true;
                fixMap[carMap[msg.sender].carID] = FixMillage(carMap[msg.sender].carID, carMap[msg.sender].Millage - mill);
            }
        }
    }
    
    
    
    function unblockCar (address adres) onlyOwner public {
        require(carMap[adres].isBlocked , "This car is not blocked!!!");
        carMap[adres].Millage += fixMap[adres].fixAmount;
        carMap[adres].isBlocked = false;
        carMap[adres].time = now;
        carMap[adres].engineStatus = false;
        fixMap[adres].fixAmount = 0;
    }
    
    function checkFuelCheat (address adres) onlyOwner public {
        require(!(carMap[adres].isThereFuelCheat) , "There is a fuel cheating!!!, Please use the fixFuelCheat function to remove this warning");
        carMap[adres].isThereFuelCheat = true; // This line useless;
    }
    
    function fixFuelCheat (address adres) onlyOwner public {
        require(carMap[adres].isThereFuelCheat,"There is no fuel cheating in this car!!!");
        carMap[adres].isThereFuelCheat = false;
    }
    
    function() external payable { } // FALLBACK FUNCTION
}
