package com.bank.system.repository;

import com.bank.system.model.Loan;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LoanRepository extends JpaRepository<Loan, Long> {
    List<Loan> findByUserId(Long userId);

    List<Loan> findByStatus(Loan.LoanStatus status);
}
