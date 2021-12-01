// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
contract Layer{
    int [] private layer_weight ;
    int [] private layer_bias;
    string private layer_name;
    address public owner; 
    constructor(int[] memory weight_, int[] memory bias_, string memory name_, address owner_){
        layer_weight=weight_;
        layer_bias=bias_;
        layer_name= name_;
        owner = owner_;

    }
    modifier RequiereCreador{
        require(msg.sender==owner, "No eres el creador de la Capa");
        _;
    }
    function update(int[] memory weight_, int[] memory bias_) RequiereCreador public{
        layer_weight=weight_;
        layer_bias = bias_;
    }

    function weight() public view returns(int[] memory){
        return layer_weight;
    }

    function bias() public view returns(int[] memory){
        return layer_bias;
    }

}