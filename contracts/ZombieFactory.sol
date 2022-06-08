// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract ZombieFactory {
  // should be a camal case -> events names
  // event that new zombie is created alerts the front-end
  event NewZombie(uint256 zombieId, string name, uint256 dna);

  uint256 public dnaDigits = 16;
  uint256 public dnaModulus = 10**dnaDigits;

  struct Zombie {
    string name;
    uint256 dna;
  }

  Zombie[] public zombies;
  mapping(uint256 => address) public zombieToOwner;
  mapping(address => uint256) public ownerZombieCount;

  // Memory and _ are for private variables
  /**
   * @dev Creates a new zombie
   * @param _name The name of the zombie
   * @param _dna The dna of the zombie
   */
  function _createZombie(string memory _name, uint256 _dna) private {
    // does not allow to have more than one Zombie
    require(ownerZombieCount[msg.sender] == 0, "you already have a Zombie");
    // Creates new --> Zombie(_name, _dna) and push it to the array
    zombies.push(Zombie(_name, _dna));

    // send the zombie owner address
    zombieToOwner[zombies.length - 1] = msg.sender;
    ownerZombieCount[msg.sender]++;

    // Emits the event to the Front end
    emit NewZombie(zombies.length - 1, _name, _dna);
  }

  // Dev is for desc purposes
  // pure does just a function call, no state change and they are Free
  // display tweets using pure or view because they are free
  /**
   * @dev Generate a random DNA from a name.
   * @param _str The name of the zombie.
   * @return The DNA of the zombie.
   */
  function _generaterandomDna(string memory _str)
    private
    view
    returns (uint256)
  {
    uint256 rand = uint256(keccak256(abi.encode(_str)));
    return rand % dnaModulus;
  }

  /**
   * @dev A public function to create a new random zombie.
   * @param _name The name of the zombie.
   */
  function createRandomZombie(string memory _name) public {
    uint256 randDna = _generaterandomDna(_name);
    _createZombie(_name, randDna);
  }

  /**
   * @dev a public function to get all Zombies.
   * @return Zombie[] All the zombies of the smart contract.
   */
  function getZombies() public view returns (Zombie[] memory) {
    return zombies;
  }
}
