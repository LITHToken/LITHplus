const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("LITHplus", function () {
  it("Should return the new token", async function () {
    const LITHplus = await ethers.getContractFactory("LITHplus");
    const token = await LITHplus.deploy();
    await token.deployed();
    await token.initialize("https://www.lithtoken.io/", ["meta0.json", "meta1.json"]);

    expect(await token.uri(0)).to.equal("https://www.lithtoken.io/meta0.json");
    expect(await token.uri(1)).to.equal("https://www.lithtoken.io/meta1.json");
    expect(await token.uri(2)).to.equal("NOURI");
  });
});
