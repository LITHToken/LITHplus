const hre = require("hardhat");

async function main() {
  const LITHplusProxy = await hre.ethers.getContractFactory("LITHplusProxy");
  const proxy = await LITHplusProxy.deploy(process.env.LITHPLUS_ADDRESS, process.env.OWNER_ADDRESS, "0x");

  await proxy.deployed();

  console.log("LITHplusProxy deployed to:", proxy.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
