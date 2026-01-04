package com.bank.system.service;

import com.bank.system.model.Account;
import com.bank.system.model.Transaction;
import com.bank.system.repository.AccountRepository;
import com.bank.system.repository.TransactionRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class BankingService {

    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private TransactionRepository transactionRepository;

    public Account getAccountByUserId(Long userId) {
        return accountRepository.findByUserId(userId).orElse(null);
    }

    @Transactional
    public String transferMoney(Long fromUserId, String recipientIdentifier, BigDecimal amount) {
        Account fromAccount = accountRepository.findByUserId(fromUserId).orElse(null);

        Optional<Account> toAccountOpt = accountRepository.findByAccountNumber(recipientIdentifier);
        if (toAccountOpt.isEmpty()) {
            // Try fetching by UPI ID
            toAccountOpt = accountRepository.findByUpiId(recipientIdentifier);
        }

        if (fromAccount == null)
            return "Source account not found";
        if (toAccountOpt.isEmpty())
            return "Destination account not found (Invalid Account Number or UPI ID)";

        Account toAccount = toAccountOpt.get();
        if (fromAccount.getId().equals(toAccount.getId()))
            return "Cannot transfer to self";

        if (fromAccount.getBalance().compareTo(amount) < 0) {
            return "Insufficient funds";
        }

        // Deduct from source
        fromAccount.setBalance(fromAccount.getBalance().subtract(amount));
        accountRepository.save(fromAccount);

        // Add to destination
        toAccount.setBalance(toAccount.getBalance().add(amount));
        accountRepository.save(toAccount);

        // Record Transaction for Source
        Transaction t1 = new Transaction();
        t1.setAccount(fromAccount);
        t1.setSourceAccountNumber(fromAccount.getAccountNumber());
        t1.setDestinationAccountNumber(toAccount.getAccountNumber());
        t1.setAmount(amount);
        t1.setType(Transaction.TransactionType.TRANSFER_OUT);
        transactionRepository.save(t1);

        // Record Transaction for Destination
        Transaction t2 = new Transaction();
        t2.setAccount(toAccount);
        t2.setSourceAccountNumber(fromAccount.getAccountNumber());
        t2.setDestinationAccountNumber(toAccount.getAccountNumber());
        t2.setAmount(amount);
        t2.setType(Transaction.TransactionType.TRANSFER_IN);
        transactionRepository.save(t2);

        return "Success";
    }

    public List<Transaction> getMiniStatement(Long accountId) {
        return transactionRepository.findByAccountIdOrderByTimestampDesc(accountId, PageRequest.of(0, 10));
    }

    public List<Transaction> getAllTransactions() {
        return transactionRepository.findAll(org.springframework.data.domain.Sort
                .by(org.springframework.data.domain.Sort.Direction.DESC, "timestamp"));
    }

    public List<Account> getAllAccounts() {
        return accountRepository.findAll();
    }
}
