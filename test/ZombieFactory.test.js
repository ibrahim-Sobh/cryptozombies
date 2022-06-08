// describe is a for describing the function of the test
// describe is a function that runs a group of tests
// it is a for running the test
// beforeEach is a function that runs before each test
// afterEach is a function that runs after each test
// should is a function that runs the test

const { expect } = require("chai");
const { ethers } = require("hardhat");
require("chai").should();

describe("ZombieFactory smart contract", () => {
  let ZombieFactory;
  let zombieFactory;

  beforeEach(async () => {
    ZombieFactory = await ethers.getContractFactory("ZombieFactory");
    zombieFactory = await ZombieFactory.deploy();
  });

  it("should create a new zombie", async () => {
    const initialZombieCount = (await zombieFactory.getZombies()).length;
    expect(initialZombieCount).to.equal(0);
    await zombieFactory.createRandomZombie("Johnny Depp");

    const newZombieCount = (await zombieFactory.getZombies()).length;
    expect(newZombieCount).to.equal(1);
  });
});
