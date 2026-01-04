package com.bank.system.controller;

import com.bank.system.model.User;
import com.bank.system.service.BankingService;
import com.bank.system.service.LoanService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private LoanService loanService;

    @Autowired
    private BankingService bankingService;

    private boolean isAdmin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        return user != null && user.getRole() == User.Role.ADMIN;
    }

    @GetMapping("/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("pendingLoans", loanService.getPendingLoans());
        model.addAttribute("allLoans", loanService.getAllLoans());
        model.addAttribute("allTransactions", bankingService.getAllTransactions());
        model.addAttribute("allAccounts", bankingService.getAllAccounts());
        return "admin_dashboard";
    }

    @PostMapping("/loans/update")
    public String updateLoanStatus(@RequestParam Long loanId, @RequestParam String status, HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/login";

        loanService.updateLoanStatus(loanId, status);
        return "redirect:/admin/dashboard";
    }
}
