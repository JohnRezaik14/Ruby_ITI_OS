require 'date'
module Logger 
    FILE ='./app.logs'
    def self.log_info(&block)
        begin
            f=File.new(FILE,'a+')
        rescue
            puts "Can't open log file"
        else
            f.puts Time.new.to_s + " -- info -- " +  block.call
        ensure
            if f
                f.close 
            end
        end
    end

    def self.log_warning(&block)
        begin
            f=File.new(FILE,'a+')
        rescue
            puts "Can't open log file"
        else
           f.puts Time.new.to_s + " -- warning -- " +  block.call
        ensure
            if f
                f.close 
            end
        end
    end

    def self.log_error(&block)
        begin
            f=File.new(FILE,'a+')
        rescue
            puts "Can't open log file"
        else
             f.puts Time.new.to_s + " -- error -- " +  block.call
        ensure
            if f
                f.close 
            end
        end
    end
end

    class User
        attr_reader :name 
        attr_accessor :balance
        def initialize(name,balance)
          @name=name
          @balance=balance
        end
    end

    class Transaction
        attr_reader :user
        attr_reader :value
        def initialize(user,value)
          @user=user
          @value=value
        end
    end


class Bank
        def initialize
         raise "Bank is an abstract class, can't instantiate instance from it \n you can extend it"
        end
            
        def transaction(transactions,&block)
        raise "This Meathod : #{__method__} is abstract , please override it"
        end
end

class CBABank < Bank
    include Logger
    @@users=[]
    attr_accessor :users

    def self.process_transactions(transactions)
        log_transactions='Processing Transactions '
        transactions.each do |transaction|
        # puts transaction
        log_transactions+=("User " + transaction.user.name.to_s + " transaction with value " + transaction.value.to_s+", ")
        end
        Logger.log_info(){log_transactions} 

   
        transactions.each do |transaction|
            user=transaction.user
            transaction_statement=user.name.to_s + "transaction with value " + transaction.value.to_s
            if @@users.include? user
                # puts "in our bank"
                
                if (user.balance + transaction.value >= 0)
                    # valid transaction
                    puts "Call endpoint for success of User " + transaction_statement
                    user.balance += transaction.value
                    Logger.log_info(){transaction_statement + " succeeed"}

                    if user.balance==0
                        Logger.log_warning(){user.name + " has 0 balance"}             
                    end
                     
                else
                    # not valid 
                    puts "Call endpoint for failure of User "+ transaction_statement+ " with reason Not enough balance"
                    Logger.log_error(){transaction_statement + " failed with message Not enough balance"} 
                end
                
            else
                puts "Call endpoint for failure of User "+ transaction_statement+ " with reason " + user.name.to_s + " not exist in the bank!!"
                Logger.log_error(){transaction_statement +' failed with message '+ user.name + 'not exist in the bank!!'} 
            end
            
        end
        
    end

    def self.users
        @@users
    end
    def self.register_user(user)
        @@users.push(user)
    end
end


users = [
  User.new("Ali", 200),
  User.new("Peter", 500),
  User.new("Manda", 100)
]

out_side_bank_users = [
  User.new("Menna", 400),
]



users.each do |user|
    CBABank.register_user(user)
end

transactions = [
  Transaction.new(users[0], -20),
  Transaction.new(users[0], -30),
  Transaction.new(users[0], -50),
  Transaction.new(users[0], -100),
  Transaction.new(users[0], -100),
  Transaction.new(out_side_bank_users[0], -100)
]

CBABank::process_transactions(transactions)