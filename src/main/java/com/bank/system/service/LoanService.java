package com.bank.system.service;

import com.bank.system.model.Loan;
import com.bank.system.model.User;
import com.bank.system.repository.LoanRepository;
import com.bank.system.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class LoanService {

    @Autowired
    private LoanRepository loanRepository;

    @Autowired
    private UserRepository userRepository;

    public Loan applyForLoan(Long userId, Loan loan) {
        User user = userRepository.findById(userId).orElse(null);
        if (user != null) {
            loan.setUser(user);
            return loanRepository.save(loan);
        }
        return null;
    }

    public List<Loan> getLoansByUserId(Long userId) {
        return loanRepository.findByUserId(userId);
    }

    public List<Loan> getAllLoans() {
        return loanRepository.findAll();
    }

    public List<Loan> getPendingLoans() {
        return loanRepository.findByStatus(Loan.LoanStatus.PENDING);
    }

    public void updateLoanStatus(Long loanId, String status) {
        Optional<Loan> loanOpt = loanRepository.findById(loanId);
        if (loanOpt.isPresent()) {
            Loan loan = loanOpt.get();
            try {
                loan.setStatus(Loan.LoanStatus.valueOf(status.toUpperCase()));
                loanRepository.save(loan);
            } catch (IllegalArgumentException e) {
                // Invalid status
            }
        }
    }
}
