require "rspec"

require_relative "account"

describe Account do
  let(:account){
    Account.new("1000000000",100.00)
  }

  describe "#initialize" do
    it "creates new account" do
      expect(account).to be_a_kind_of(Account)
    end

  end

  describe "#transactions" do
     it "initial transactions should equal the starting balance" do
      account = Account.new("1000000000",100.00)
      expect(account.transactions[0]).to eq(100.00)
    end
  end

  describe "#account_number" do
    it "account number needs to be 10 digits" do
      expect{account = Account.new("blah")}.to raise_error(InvalidAccountNumberError)
    end

    it "acct_number returns the account number with everything hidden except for the last 4" do
      expect(account.acct_number).to eq("******0000")
    end
  end

  describe "deposit!" do
    it "raises error if deposit amount < 0" do
      expect{account.deposit!(-10)}.to raise_error(NegativeDepositError)
    end

    it "adds to the transaction array" do
      expect{account.deposit!(10.0)}.to change{account.transactions.length}.by(1)
    end

    it "returns the balance" do
      account.deposit!(10).should == account.balance
    end
  end

  describe "#balance" do
    it "returns the sum of the total transactions array" do
      account.deposit!(1000.00)
      account.deposit!(10000.00)
      expect(account.balance).to eq(11100.00)
    end
  end

  describe "#withdraw!" do
    it "adds to the transaction array" do
      expect{account.withdraw!(10.0)}.to change{account.transactions.length}.by(1)
    end

    it "raises overdraft error if balance + amount < 0" do
      expect{account.withdraw!(1000.00)}.to raise_error(OverdraftError)
    end

    it "returns the balance" do
      account.withdraw!(10).should == account.balance
    end
  end


end
