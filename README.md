This is a little script I made to automate the Overenchantment Tale by [Thaumic Bases](https://github.com/Rumaruka/Thaumic-Bases-Unofficial) using [Open Computers](https://github.com/MightyPirates/OpenComputers)

## How to

To start using this you will need a nanomachine and a robot with the following upgrades:
  - Inventory Controller
  - Redstone Card
  
  Put a Thaumcraft's Caster's Gauntlet (or any equivalent item) in the hand slot of the robot.
  
  The robot will be specting a Redstone Comparator followed by a Warded Jar with Praecantatio essence in the ``ESSENCE_SIDE`` side.
  
  The side ``EXP_OUTPUT_SIDE`` will be emiting redstone signal whenever the player does not has enough EXP (You probably want to connect this to some kind of XP Supply system (check the [demos](#demo))
  
  The robot must have an Overenchanting Table right in the ``ENCHANTER_SIDE``.
  
  All the sides can be changed in the ``config.lua`` file.
 
 To start using, after setup, you should put an item in the Overenchantment Table, go to the robot and issue the command ``enchant`` to enchant once and stop, or the command ``enchant forever`` to repeat the enchantment cycle until it needs to stop.
 
 Now just stay in the top of the Overenchantment Table and go get a coffee or something.
 
 ## Security
 
 - The robot will abort if there is not enough essence provided
 - The robot will abort when in forever mode if the stack enchantments didn't changed (by reaching all the limits, for instance)
 - The robot will not start until the player does not have enough experience
 - The robot will restart the enchantment if the item of the Overenchantment Table changes during the session
 - The robot will abort when in forever mode if the item in the Overenchantment Table does not get enchanted in a little more of 30 seconds (this timeout quite depends of the Robot hardware)
 - The robot will abort if it lose connection with the nanomachine while the experience is being supplied
 - You can use time shifting shit like Time in a Bottle in the Overenchantment table, soon I'll be implementing the automated use of this in the script itself
 
 ## Demo
 
 This setup is using an XP Shower from [Open Blocks](https://github.com/OpenMods/OpenBlocks) to supply the player experience
 
 ![](https://i.imgur.com/yOvIOnT.png)
 
 This happened while I was writing this guide
 
 ![](https://i.imgur.com/nV0JlNA.png)
 
 This happened in a night AFKing to test the robot
 
 ![](https://i.imgur.com/xRXwvKo.png)
