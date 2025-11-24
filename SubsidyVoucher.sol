// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SubsidyVouchers
 * @notice A contract for issuing and tracking decentralized agricultural input subsidy vouchers.
 */
contract SubsidyVouchers {
    // --- State Management and Roles ---
    address public immutable funder; // The primary address that deploys/manages the system.
    uint256 private voucherCounter = 0; // Unique ID generator for vouchers.

    // --- Enums and Structs ---
    enum Status { Issued, Redeemed, Expired }

    struct Voucher {
        uint256 id;
        address farmer; // The recipient of the subsidy.
        uint256 amount; // Value/quantity of the subsidy.
        uint256 issueTime;
        address supplier; // Set to the supplier's address upon redemption.
        uint256 redemptionTime;
        Status status;
    }

    // Stores all vouchers, indexed by a unique ID.
    mapping(uint256 => Voucher) public vouchers;

    // Mapping to track which addresses are authorized suppliers.
    mapping(address => bool) public isSupplier;

    // List of suppliers (for enumeration by frontend)
    address[] public supplierList;

    // --- Events for Off-Chain Auditing ---
    event VoucherIssued(
        uint256 indexed voucherId,
        address indexed farmer,
        uint256 amount,
        uint256 issueTime
    );
    
    event VoucherRedeemed(
        uint256 indexed voucherId,
        address indexed supplier,
        address farmer,
        uint256 amount,
        uint256 redemptionTime
    );

    event SupplierRegistered(address indexed supplier);
    event SupplierUnregistered(address indexed supplier);

    // --- Access Control Modifier ---
    modifier onlyFunder() {
        require(msg.sender == funder, "SV: Only the Funder can call this function");
        _;
    }

    // --- Constructor ---
    constructor() {
        funder = msg.sender;
    }
    
    // --- Role Management Functions ---
    
    /**
     * @notice Registers a new address as an authorized supplier.
     * @param _supplier The address of the agro-input supplier.
     */
    function registerSupplier(address _supplier) public onlyFunder {
        require(_supplier != address(0), "SV: Invalid address");
        require(!isSupplier[_supplier], "SV: Already registered");

        isSupplier[_supplier] = true;
        supplierList.push(_supplier);
        emit SupplierRegistered(_supplier);
    }
    
    /**
     * @notice Revokes an address's supplier status.
     * @param _supplier The address to unregister.
     * @dev We keep supplierList entries to save gas; frontend filters by isSupplier mapping.
     */
    function unregisterSupplier(address _supplier) public onlyFunder {
        require(isSupplier[_supplier], "SV: Not a supplier");
        isSupplier[_supplier] = false;
        emit SupplierUnregistered(_supplier);
    }

    // --- Helper to fetch all suppliers (including historical). Frontend should filter by isSupplier. ---
    function getAllSuppliers() public view returns (address[] memory) {
        return supplierList;
    }

    // --- Core Issuance Function ---
    function issueVoucher(address _farmer, uint256 _amount) public onlyFunder {
        require(_farmer != address(0), "SV: Invalid farmer address");
        require(_amount > 0, "SV: Amount must be greater than zero");

        voucherCounter++;
        uint256 newId = voucherCounter;
        
        vouchers[newId] = Voucher({
            id: newId,
            farmer: _farmer,
            amount: _amount,
            issueTime: block.timestamp,
            supplier: address(0),
            redemptionTime: 0,
            status: Status.Issued
        });

        emit VoucherIssued(newId, _farmer, _amount, block.timestamp);
    }
    
    // --- Core Redemption Function ---
    function redeemVoucher(uint256 _voucherId) public {
        require(isSupplier[msg.sender], "SV: Only a registered supplier can redeem vouchers");
        require(_voucherId > 0 && _voucherId <= voucherCounter, "SV: Invalid voucher ID");
        
        Voucher storage voucher = vouchers[_voucherId];
        require(voucher.status == Status.Issued, "SV: Voucher is not in Issued status");

        voucher.status = Status.Redeemed;
        voucher.supplier = msg.sender;
        voucher.redemptionTime = block.timestamp;

        emit VoucherRedeemed(
            _voucherId,
            msg.sender,
            voucher.farmer,
            voucher.amount,
            block.timestamp
        );
    }
}
