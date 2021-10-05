// SPDX-License-Identifier: AGPLv3"

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

import "./utils/Strings.sol";

/**
 * @dev Implementation of the LITHplus sample standard multi-token.
 * See https://eips.ethereum.org/EIPS/eip-1155
 * Originally based on code by Enjin: https://github.com/enjin/erc-1155
 */
contract LITHplus is OwnableUpgradeable, ERC1155PausableUpgradeable {
    using OraclizeStrings for string;

    mapping(bytes32 => uint256) internal uIntStorage;
    mapping(bytes32 => uint256[]) internal uIntArrayStorage;
    mapping(bytes32 => mapping(uint256 => uint256)) internal uIntMappingStorage;
    mapping(bytes32 => string) internal stringStorage;
    mapping(bytes32 => string[]) internal stringArrayStorage;
    mapping(bytes32 => mapping(string => string)) internal stringMappingStorage;
    mapping(bytes32 => address) internal addressStorage;
    mapping(bytes32 => address[]) internal addressArrayStorage;
    mapping(bytes32 => bytes) internal bytesStorage;
    mapping(bytes32 => bytes[]) internal bytesArrayStorage;
  
    bytes32 internal constant META_POSITION = keccak256("lith.LITHplus.meta");

    /**
     * @dev See {__LITHHplus_init}.
     */
    function initialize(string memory uri_, string[] memory meta_) public initializer {
        __LITHHplus_init(uri_, meta_);
    }

    /**
     * @dev See {ERC1155Upgradeable}.
     */
    function __LITHHplus_init(string memory uri_, string[] memory meta_) internal initializer {
        __Context_init_unchained();
        __Ownable_init_unchained();
        __ERC165_init_unchained();
        __ERC1155_init_unchained(uri_);
        __Pausable_init_unchained();
        __ERC1155Pausable_init_unchained();        
        __LITHplus_init_unchained(meta_);
    }

    function __LITHplus_init_unchained(string[] memory meta_) internal initializer {
        _setmeta(meta_);
    }

    function _getmeta() internal view returns(string[] storage)
    {
        return stringArrayStorage[META_POSITION];
    }

    function _setmeta(string[] memory meta_) internal
    {
        stringArrayStorage[META_POSITION] = meta_;
    }

    function getmeta(uint256 id_) public view returns(string memory)
    {
        string[] storage meta = _getmeta();
        require(id_ < meta.length, "Invalid id");
        return meta[id_];
    }

    /**
     * @dev Sets a new URI for all token types, by relying on the token type ID
     * substitution mechanism
     * https://eips.ethereum.org/EIPS/eip-1155#metadata[defined in the EIP].
     *
     * By this mechanism, any occurrence of the `\{id\}` substring in either the
     * URI or any of the amounts in the JSON file at said URI will be replaced by
     * clients with the token type ID.
     *
     * For example, the `https://token-cdn-domain/\{id\}.json` URI would be
     * interpreted by clients as
     * `https://token-cdn-domain/000000000000000000000000000000000000000000000000000000000004cce0.json`
     * for token type ID 0x4cce0.
     *
     * See {uri}.
     *
     * Because these URIs cannot be meaningfully represented by the {URI} event,
     * this function emits no events.
     */
    function setURI(string memory newuri) external onlyOwner {
        _setURI(newuri);
    }

    /**
     * @dev See {IERC1155MetadataURI-uri}.
     *
     * This implementation returns the same URI for *all* token types. It relies
     * on the token type ID substitution mechanism
     * https://eips.ethereum.org/EIPS/eip-1155#metadata[defined in the EIP].
     *
     * Clients calling this function must replace the `\{id\}` substring with the
     * actual token type ID.
     */
    function uri(uint256 id_) public view virtual override returns (string memory) {
        string[] storage meta = _getmeta();
        if (id_ >= meta.length) return "NOURI";
        return super.uri(0).strConcat(meta[id_]);
    }

   /**
     * @dev Adds META JSON as token type, and assigns them to returned `id`.
     */
    function addmeta(string memory meta_) external onlyOwner returns (uint256 id_) {
        require(bytes(meta_).length > 0, "Invalid meta file");
        string[] storage meta = _getmeta();
        id_ = meta.length;
        meta.push(meta_);
    }

   /**
     * @dev Creates `amount` tokens of token type `id`, and assigns them to `account`.
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - If `account` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155Received} and return the
     * acceptance magic value.
     */
    function mint(
        address account,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) external onlyOwner {
        require(id < _getmeta().length, "Invalid id");
        super._mint(account, id, amount, data);
    }

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {_mint}.
     *
     * Requirements:
     *
     * - `ids` and `amounts` must have the same length.
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155BatchReceived} and return the
     * acceptance magic value.
     */
    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) external onlyOwner {
        uint256 idx = 0;
        uint256 length = _getmeta().length;
        while(idx < ids.length)
        {
            require(ids[idx] < length, "Invalid id");
            unchecked { idx++; }
        }
        super._mintBatch(to, ids, amounts, data);
    }

    /**
     * @dev Destroys `amount` tokens of token type `id` from `account`
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens of token type `id`.
     */
    function burn(
        address account,
        uint256 id,
        uint256 amount
    ) external onlyOwner {
        super._burn(account, id, amount);
    }

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {_burn}.
     *
     * Requirements:
     *
     * - `ids` and `amounts` must have the same length.
     */
    function burnBatch(
        address account,
        uint256[] memory ids,
        uint256[] memory amounts
    ) external onlyOwner {
        super._burnBatch(account, ids, amounts);        
    }
    /**
     * @dev Triggers stopped state.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    function pause() external onlyOwner {
        _pause();
    }

    /**
     * @dev Returns to normal state.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    function unpause() external onlyOwner {
        _unpause();
    }  
}