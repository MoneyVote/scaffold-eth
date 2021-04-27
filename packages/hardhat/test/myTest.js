const { ethers } = require("hardhat");
const { use, expect } = require("chai");
const { solidity } = require("ethereum-waffle");

use(solidity);

describe("My Dapp", function () {
  let myContract;

  describe("MoneyVote", function () {
    it("Should deploy MoneyVote", async function () {
      const YourContract = await ethers.getContractFactory("MoneyVote");

      myContract = await YourContract.deploy([ethers.utils.formatBytes32String('Sean Connery'),
        ethers.utils.formatBytes32String('Roger Moore'), ethers.utils.formatBytes32String('Daniel Craig')], 20, 1);
    });
  });
});
