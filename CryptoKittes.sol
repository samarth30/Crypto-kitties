pragma solidity ^0.5.7;

import './ERC721Token1.sol';

contract cryptoKitties is ERC721Token{
//   enum HairColor{
//      WHITE,BLACK
//     }        
//     HairColor haircolor;
//     haircolor.WHITE
   struct Kitty{
       uint id;
       uint generation;
       uint geneA;
       uint geneB;
   }
   
   mapping(uint => Kitty) public Kitties;
   uint public nextId;
   address admin;
   constructor(string memory _name,string memory _symbol,string memory _tokenURIBase)
   ERC721Token(_name,_symbol,_tokenURIBase)
   public {
       admin = msg.sender;

   }

    
   function mint() external{
       require(msg.sender == admin,"you are not authorized");
        
       Kitties[nextId] = Kitty(nextId,1,_random(10),_random(10));
       
       _mint(nextId,msg.sender);
       nextId++;
   }
  
   
   function breed(uint kitty1Id,uint kitty2Id) external{
       require(kitty2Id< nextId && kitty1Id < nextId,"the kitty does not exist");
       Kitty storage Kitty1 = Kitties[kitty1Id];
       Kitty storage kitty2 = Kitties[kitty2Id];
       
       require(ownerOf(kitty1Id) == msg.sender && ownerOf(kitty2Id) == msg.sender,'you are not authorized');
       
       uint maxGen = Kitty1.generation > kitty2.generation ?  Kitty1.generation : kitty2.generation;
       uint geneA = _random(4) > 1 ? Kitty1.geneA : kitty2.geneA;
       uint geneB = _random(4) > 1 ? Kitty1.geneB : kitty2.geneB;
       Kitties[nextId] = Kitty(nextId,1,geneA,geneB);
       
         _mint(nextId,msg.sender);
       nextId++;
   }
   
   function _random(uint max) internal view returns(uint){
       return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty))) % max;
   }

}
