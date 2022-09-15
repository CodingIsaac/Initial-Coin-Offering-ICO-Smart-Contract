import { ethers } from "hardhat";

async function main() {
  const contract = await ethers.getContractFactory("Dabby");

  const deployContract = await contract.deploy();

  await deployContract.deployed();

  console.log("Dabby Token Deployed Here", deployContract.address);

  // Dabby Token Deployed Here 0x4458A3a6e063EAf915D7b4dbc1ae0FB524f7519f


  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
