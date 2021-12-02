// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import "./layer.sol";

contract NeuralNetwork{
    struct Layer_param{
        address address_layer;
        uint last_modify;
    }
    mapping (string => Layer_param) private layers;
    string [] private layer_names;
    address private creator;

    
    constructor(){
        creator = msg.sender ;
        
    }
    modifier RequiereCreador{
        require(msg.sender==creator, "No eres el Creador de la red neuronal");
        _;
    }

    function NewLayer(int[] memory weight_ , int[] memory bias_ , string memory name_) RequiereCreador public {
        Layer_param memory params;
        params.address_layer = address (new Layer(weight_, bias_ , name_ , address(this)));
        params.last_modify = block.timestamp;
        layers[name_]=params;
        layer_names.push(name_) ;
        
        
    }
    function ModifyLayer(string memory name_layer, int[] memory newWeight, int[] memory newBias) RequiereCreador public {
        Layer_param memory params= layers[name_layer];
        Layer layer= Layer(params.address_layer);
        layer.update(newWeight, newBias);
        params.last_modify = block.timestamp;
    }

    function getLayerWeight(string memory name_) public view returns( int[] memory ){
        Layer layer= Layer(layers[name_].address_layer);
        return layer.weight();

    }
    function getLayerBias(string memory name_) public view returns( int[] memory ){
        Layer layer= Layer(layers[name_].address_layer);
        return layer.bias();

    }

    function getLayersNames() public view returns( string[] memory ){
        return layer_names;
    }

    function getLastModify(string memory name_) public view returns (uint){
        return layers[name_].last_modify;
    }

    function getLayerAdress(string memory name_) public view returns (address){
        return layers[name_].address_layer;
    }
}