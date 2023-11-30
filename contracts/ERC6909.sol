// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import {IERC6909} from './IERC6909.sol';

contract ERC6909 is IERC6909 {
    mapping (address owner => mapping (uint256 id => uint256 amount)) public balanceOf;
    mapping (address owner => 
        mapping (address operator => 
            mapping (uint256 id => uint256 amount)
        )
    ) public allowance;
    mapping (address owner => mapping (address operator => bool)) public isOperator;

    error ERC6909InvalidReceiver(address receiver);
    error ERC6909InsufficientBalance(address owner, uint id);
    error ERC6909InsufficientAllowance(address owner, address operator, uint id);

    function _update(
        address owner, 
        address receiver, 
        uint256 id, 
        uint256 amount,
        bool enforceZeroReceiver
    ) internal returns (bool) {
        if(owner != address(0)) {
            uint256 oldBalance = balanceOf[owner][id];
            if(oldBalance < amount) revert ERC6909InsufficientBalance(receiver, id);

            unchecked {
                balanceOf[owner][id] = oldBalance - amount;
                
            }
        }

        if(receiver == address(0)) {
            if(enforceZeroReceiver)
                revert ERC6909InvalidReceiver(receiver);
        } else {
            balanceOf[receiver][id] += amount;
        }

        emit Transfer(msg.sender, owner, receiver, id, amount);
        return true;
    }

    function _verifyOperator(address owner, uint id, uint amount) internal {
        if(isOperator[owner][msg.sender]) return;

        uint oldAllowance = allowance[owner][msg.sender][id];
        if(oldAllowance < amount) revert ERC6909InsufficientAllowance(owner, msg.sender, id);

        uint max;
        assembly { max := not(0) }
        if(oldAllowance == max) return;

        allowance[owner][msg.sender][id] = oldAllowance - amount;
    }

    function transfer(address receiver, uint256 id, uint256 amount) external returns (bool success) {
        return _update(msg.sender, receiver, id, amount, true);
    }

    function transferFrom(
        address owner, 
        address receiver, 
        uint256 id, 
        uint256 amount
    ) external returns (bool success) {
        _verifyOperator(owner, id, amount);
        return _update(owner, receiver, id, amount, true);
    }

    function approve(address operator, uint256 id, uint256 amount) external returns (bool success) {
        allowance[msg.sender][operator][id] = amount;
        emit Approval(msg.sender, operator, id, amount);
        return true;
    }

    function setOperator(address operator, bool approved) external returns (bool success) {
        isOperator[msg.sender][operator] = approved;
        emit OperatorSet(msg.sender, operator, approved);
        return true;
    }

    function _mint(address receiver, uint id, uint amount) internal {
        _update(address(0), receiver, id, amount, true);
    }

    function _burnFrom(address owner, uint id, uint amount) internal {
        _verifyOperator(owner, id, amount);
        _update(owner, address(0), id, amount, false);
    }
}
