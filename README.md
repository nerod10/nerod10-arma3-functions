# nerod10 arma3 functions

## Installation
1. open arma 3 editor and save it with a name of your choice
2. if you familiar with arma 3 scripting, go the the examples section, otherwise continue
3. move the downloaded github floder (the one with the readMe file you are currently reading) to static place on your drive, this folder wil be used to store the functions so you can use them in any mission you create.
3. run the "create init bat script.bat" file, that will create a new file called missionFileInit.bat
4. move the newly created missionFileInit.bat file to the mission folder you created in step 1
5. run the missionFileInit.bat as administrator, this will create a new folder called "functions" in the mission folder
6. a init.sqf file will be created in the mission folder, this file will be used to load the functions

## create a mission
to create a fliyng ship, you can use a key frame animation or to use the moveObject fucntion
the moveObject will take a entity1 (source) and fly it to entity2 (target).
in some cases the entity that you want to move will point 180 degrees from it target, in that case you will need to create a simpler entity like VR box and attach the entity you want to move to it (`this attachTo [box1]`), then use the VR box as the source entity.


## examples
### moveObject
all will place in the init.sqf file (or in the file you work with)
example 1:

```
[box1,box2,10,0] spawn TG_fnc_moveObject;
```

this will move box1 to box2 in 10 seconds and will delay the animation by 0 seconds

example 2:
```
[box1,box2,1000,"3as_ARC_Heavy_Energy_shell",40,time,300] spawn TG_fnc_fireLaser;
```
this will shoot a projectile from box1 to box2, the speed will be 1000, the projectile type will be "3as_ARC_Heavy_Energy_shell", the projectile will scale by 40, the shoot will acure emidiatly ceause the time is pointing to the current time, and the shoot accuracy radius will be 300 meters

example 3:
```
[[box1,box2,box3],targetBox,5,8,"3as_ARC_Heavy_Energy_shell","lasershot01",2000,40,300] spawn TG_fnc_laserBarrager;
```
this will start a barrager from box1,2 and 3 to targetBox, the barrager start will delay 5 seconds, will last 8 second, projectile type "3as_ARC_Heavy_Energy_shell", each shot will play the "lasershot01" sound, the speed will be 2000, the projectile will scale by 40, the shoot accuracy radius will be 300 meters


