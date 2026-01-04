package com.bank.system.controller;

import com.bank.system.model.Account;
import com.bank.system.model.Loan;
import com.bank.system.model.User;
import com.bank.system.service.BankingService;
import com.bank.system.service.LoanService;
import com.bank.system.service.SavingsGoalService;
import com.bank.system.model.SavingsGoal;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;

@Controller
public class CustomerController {

    @Autowired
    private BankingService bankingService;

    @Autowired
    private LoanService loanService;

    @Autowired
    private SavingsGoalService savingsGoalService;

    private User getSessionUser(HttpSession session) {
        return (User) session.getAttribute("user");
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = getSessionUser(session);
        if (user == null)
            return "redirect:/login";

        Account account = bankingService.getAccountByUserId(user.getId());
        model.addAttribute("user", user);
        model.addAttribute("account", account);
        model.addAttribute("recentTransactions", bankingService.getMiniStatement(account.getId()));

        return "dashboard";
    }

    @GetMapping("/transfer")
    public String transferPage(HttpSession session) {
        if (getSessionUser(session) == null)
            return "redirect:/login";
        return "transfer";
    }

    @PostMapping("/transfer")
    public String transferMoney(@RequestParam String recipientIdentifier, @RequestParam BigDecimal amount,
            HttpSession session, Model model) {
        User user = getSessionUser(session);
        if (user == null)
            return "redirect:/login";

        String result = bankingService.transferMoney(user.getId(), recipientIdentifier, amount);
        if ("Success".equals(result)) {
            return "redirect:/dashboard?success=Transfer Successful";
        } else {
            model.addAttribute("error", result);
            return "transfer";
        }
    }

    @GetMapping("/loans")
    public String loanPage(HttpSession session, Model model) {
        User user = getSessionUser(session);
        if (user == null)
            return "redirect:/login";

        model.addAttribute("loans", loanService.getLoansByUserId(user.getId()));
        return "loans";
    }

    @PostMapping("/loans/apply")
    public String applyLoan(Loan loan, HttpSession session) {
        User user = getSessionUser(session);
        if (user == null)
            return "redirect:/login";

        loanService.applyForLoan(user.getId(), loan);
        return "redirect:/loans?success=Application Submitted";
    }

    @GetMapping("/savings")
    public String savingsPage(HttpSession session, Model model) {
        User user = getSessionUser(session);
        if (user == null)
            return "redirect:/login";

        model.addAttribute("goals", savingsGoalService.getGoalsByUserId(user.getId()));
        return "savings";
    }

    @PostMapping("/savings/add")
    public String addSavingsGoal(SavingsGoal goal, HttpSession session) {
        User user = getSessionUser(session);
        if (user == null)
            return "redirect:/login";

        savingsGoalService.addGoal(user.getId(), goal);
        return "redirect:/savings?success=Goal Added";
    }
}
