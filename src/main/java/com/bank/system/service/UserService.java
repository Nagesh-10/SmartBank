package com.bank.system.service;

import com.bank.system.model.Account;
import com.bank.system.model.User;
import com.bank.system.repository.AccountRepository;
import com.bank.system.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Optional;
import java.util.Random;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AccountRepository accountRepository;

    public User registerUser(User user) {
        // Generate OTP
        Random rand = new Random();
        String otp = String.format("%06d", rand.nextInt(999999));
        user.setVerificationCode(otp);
        user.setVerified(false);

        // Print OTP to console for simulation
        System.out.println("=================================================");
        System.out.println("SIMULATED EMAIL OTP for " + user.getEmail() + ": " + otp);
        System.out.println("=================================================");

        // Save user first
        User savedUser = userRepository.save(user);

        // Create an account for the user automatically
        Account account = new Account();
        account.setUser(savedUser);
        account.setBalance(new BigDecimal("1000.00")); // Give 1000 initial balance for testing
        account.setAccountNumber(generateAccountNumber());
        account.setUpiId(savedUser.getPhoneNumber() + "@smartbank");
        accountRepository.save(account);

        return savedUser;
    }

    public User loginUser(String email, String password) {
        Optional<User> user = userRepository.findByEmail(email);
        // Only allow login if verified
        if (user.isPresent() && user.get().getPassword().equals(password)) {
            if (!user.get().isVerified()) {
                return null; // or handle specifically
            }
            return user.get();
        }
        return null;
    }

    public boolean verifyUser(String email, String otp) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (otp.equals(user.getVerificationCode())) {
                user.setVerified(true);
                userRepository.save(user);
                return true;
            }
        }
        return false;
    }

    private String generateAccountNumber() {
        Random rand = new Random();
        String card = "AC";
        for (int i = 0; i < 10; i++) {
            int n = rand.nextInt(10);
            card += Integer.toString(n);
        }
        return card;
    }
}
