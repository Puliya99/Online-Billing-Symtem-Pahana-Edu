export class BillModel {
    constructor(billId, billDate, accountNo, totalAmount) {
        this.billId = billId;
        this.billDate = billDate;
        this.accountNo = accountNo;
        this.totalAmount = totalAmount;
    }
}