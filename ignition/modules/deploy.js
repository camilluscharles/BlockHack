const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("DeployModule", (m) => {
  const { deployments, getNamedAccounts } = m;

  async function deploy() {
    const { deployer } = await getNamedAccounts();

    // Deploy Escrow contract
    const Escrow = await deployments.get("Escrow");
    if (!Escrow) {
      await deployments.deploy("Escrow", {
        from: deployer,
        args: [],
        log: true,
      });
    }

    // Deploy CarRental contract with Escrow contract address as an argument
    const CarRental = await deployments.get("CarRental");
    if (!CarRental) {
      const escrowAddress = (await deployments.get("Escrow")).address;
      await deployments.deploy("CarRental", {
        from: deployer,
        args: [escrowAddress],
        log: true,
      });
    }
  }

  return { deploy };
});