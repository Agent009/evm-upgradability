// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import {AccessControlUpgradeable} from "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";

contract TokenUpgradableV1 is ERC20Upgradeable, AccessControlUpgradeable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE"); // equivalent to using a constructor.
    bytes32 public someVariableNotConstant;

    // We are now using upgradable underlying contracts, as well as an init instead of a constructor, so this is now
    // upgradable.
    function initialize() public initializer {
        __ERC20_init("TokenUpgradable", "TKN+");
        __AccessControl_init();
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        someVariableNotConstant = keccak256("VARIABLE");
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }
}
