// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.6.0;

import "../contracts/ERC6909.sol";
import "../contracts/IERC6909.sol";

contract $ERC6909 is ERC6909 {
    bytes32 public constant __hh_exposed_bytecode_marker = "hardhat-exposed";

    event return$_update(bool ret0);

    constructor() payable {
    }

    function $_update(address owner,address receiver,uint256 id,uint256 amount,bool enforceZeroReceiver) external returns (bool ret0) {
        (ret0) = super._update(owner,receiver,id,amount,enforceZeroReceiver);
        emit return$_update(ret0);
    }

    function $_verifyOperator(address owner,uint256 id,uint256 amount) external {
        super._verifyOperator(owner,id,amount);
    }

    function $_mint(address receiver,uint256 id,uint256 amount) external {
        super._mint(receiver,id,amount);
    }

    function $_burnFrom(address owner,uint256 id,uint256 amount) external {
        super._burnFrom(owner,id,amount);
    }

    receive() external payable {}
}
