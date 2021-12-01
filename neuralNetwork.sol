// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import "./layer.sol";

//[11069788,10275273,-5755133,2081249,-16848446,-8547037,8813243,-4437393,4093660,5242501,-6889176,-655970,2473776,-7811859,8215983,16072847,-17455066,-2530570,-5262961,-7858448,1999595,-1342600,6698353,-12604670,-9080487,2212028,5119607,13079877,-8425705,11251335,1675853,-6046764,1570838,-17154924,-244219,16865088,-3056201,13385825,-3300573,-6039869,12131904,15967135,6834885,-15774480,7172321,1071173,1297727,-9987956,2967718,7383366,-12528941,4730688,6283003,15442841,1233476,-11164042,-6338034,5457572,-14403459,8930822,-470854,-11005966,8165566,-14214352,6716372,16412966,15092058,5592446,14729981,15540768,6448973,-14884508,-2138853,-3376369,-12071776,9221320,12383105,-3212380,-4523061,-13838060,14533888,17601646,7741333,3442771,-8312243,2818343,-5968961,15119471,-13838549,-10162448,1474919,10733192,-16923204,-12994389,11205690,10548802]

contract NeuralNetwork{
    struct Layer_param{
        address address_layer;
        uint last_modify;
    }
    mapping (string => Layer_param) private layers;
    string [] private layer_names;
    address private creator;

    
    constructor(){
        creator = msg.sender;
        
    }
    modifier RequiereCreador{
        require(msg.sender==creator, "No eres el Creador de la red neuronal");
        _;
    }

    function NewLayer(int[] memory weight_ , int[] memory bias_ , string memory name_) RequiereCreador public {
        Layer_param memory params;
        params.address_layer = address (new Layer(weight_, bias_ , name_ , creator));
        params.last_modify = block.timestamp;
        layers[name_]=params;
        layer_names.push(name_) ;
        
        
    }
    function ModifyLayer(string memory name_layer, int[] memory newWeight, int[] memory newBias) RequiereCreador public {
        Layer_param memory params= layers[name_layer];
        Layer layer= Layer(params.address_layer);
        layer.update(newWeight, newBias);
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