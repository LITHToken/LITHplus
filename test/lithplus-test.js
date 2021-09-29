const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("LITHplus", function () {
  it("Should return the new token", async function () {
    const LITHplus = await ethers.getContractFactory("LITHplus");
    const token = await LITHplus.deploy("https://www.lithtoken.io/", ["sample0.pdf", "sample1.pdf"]);
    await token.deployed();

    expect(await token.uri(0)).to.equal("https://www.lithtoken.io/sample0.pdf");
    expect(await token.uri(1)).to.equal("https://www.lithtoken.io/sample1.pdf");
    expect(await token.uri(2)).to.equal("NOURI");
  });
});
